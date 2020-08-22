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

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  return (user_input.to_i - 1)
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, position)
  if board[position] == " "
    return false
  end
  return true
end

def valid_move?(board, position)
  return position>-1 && position<9 && !position_taken?(board, position)
  #   return true
  # end
  # return false
end

def turn_count(board)
  return board.select{|i| i != " "}.length
end

def current_player(board)
  if turn_count(board).odd?
    return "O"
  else
    return "X"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets.strip)
  if valid_move?(board,index)
    move(board,index,current_player(board))
  else
    turn(board)
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    combination_1 = board[win_combination[0]]
    combination_2 = board[win_combination[1]]
    combination_3 = board[win_combination[2]]

    if (combination_1 == combination_2 && combination_1 == combination_3 && combination_2 == combination_3) && combination_1 != " "
      return win_combination
    end
  end
  return false
end

def full?(board)
  return !board.detect{|i| i==" "}
end

def draw?(board)
  return full?(board) && !won?(board)
end

def over?(board)
  return full?(board) || won?(board) || draw?(board)
end

def winner(board)
  winner = won?(board)
  if !!winner
    return board[winner[0]]
  else
    return nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  winner = winner(board)
  if winner
    puts "Congratulations #{winner}!"
  else
    puts "Cat's Game!"
  end
end
