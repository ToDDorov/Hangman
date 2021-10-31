class Visualizer
  def display_board(game_word, guess, misses)
    puts "Word: #{game_word}"
    puts "Guess: #{guess}"
    puts "Misses: #{misses.reduce { |product, n| product + " #{n}" }}"
  end
end
