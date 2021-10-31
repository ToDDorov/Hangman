class Visualizer
  def display_board(game_word, guess, misses)
    puts "Word: #{game_word}"
    puts "Guess: #{guess}"
    puts "Misses: #{misses.reduce { |product, n| product + " #{n}" }}"
    draw_body(misses.length)
  end

  def draw_body(misses_length)
    case misses_length
    when 0
      puts '-----|======'
      puts '-----O----||'
      puts '---/-|-\--||'
      puts '----/-\---||'
      puts '__________||'
    when 1
      puts '-----|======'
      puts '-----O----||'
      puts '----------||'
      puts '----------||'
      puts '__________||'
    when 2
      puts '-----|======'
      puts '-----O----||'
      puts '-----|----||'
      puts '----------||'
      puts '__________||'
    when 3
      puts '-----|======='
      puts '-----O----||'
      puts '---/-|----||'
      puts '----------||'
      puts '__________||'
    when 4
      puts '-----|======='
      puts '-----O----||'
      puts '---/-|-\--||'
      puts '----------||'
      puts '__________||'
    when 5
      puts '-----|======'
      puts '-----O----||'
      puts '---/-|-\--||'
      puts '----/-----||'
      puts '___/______||'
    when 6
      puts '-----|======'
      puts '-----O----||'
      puts '---/-|-\--||'
      puts '----/-\---||'
      puts '___/___\__||'
    end
  end
end
