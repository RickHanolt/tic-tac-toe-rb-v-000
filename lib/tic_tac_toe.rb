
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

board = [" "," "," "," "," "," "," "," "," "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
end

def turn(board)
  puts "Where would you like to move?"
  input = gets.strip
  position = input_to_index(input)
  if valid_move?(board,position)
    player_token = current_player(board)
    move(board, position, player_token)
  else
    puts "Invalid move."
    turn(board)
  end
end

def move(board, position, player_token)
  board[position] = player_token
end

def position_taken?(board, position)
  !(board[position] == nil || board[position] == " ")
end

def valid_move?(board, position)
  !position_taken?(board, position) && position <= 8 && position >= 0
end

def turn_count(board)
  (board.select {|i| i == "X" || i == "O"}).count
end

def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end

def won?(board)
  if WIN_COMBINATIONS.any? {|i| i.all?{|j| board[j] == "X"}}
    true
  elsif WIN_COMBINATIONS.any? {|i| i.all?{|j| board[j] == "O"}}
    true
  else
    false
  end
end

def full?(board)
  turn_count(board) == 9
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  full?(board) || won?(board)
end

def winner(board)
  if WIN_COMBINATIONS.any? {|i| i.all?{|j| board[j] == "X"}}
    "X"
  elsif WIN_COMBINATIONS.any? {|i| i.all?{|j| board[j] == "O"}}
    "O"
  else
    nil
  end
end

def play(board)
  until over?(board)
    if !draw?(board)
      turn(board)
    end
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  else
    puts "I think I screwed up somehwere..."
  end
end
