# frozen_string_literal: true

require 'json'

class Visualizer
  def initialize
    @body_progression = JSON.parse File.read('hangman_body.json')
  end

  def display_board(game_word, guess, misses)
    puts "Word: #{game_word}"
    puts "Guess: #{guess}"
    puts "Misses: #{misses.reduce { |product, n| product + " #{n}" }}"
    draw_body(misses.length)
  end

  def draw_body(misses_length)
    body_number = misses_length.to_s
    body = @body_progression[body_number]

    body.each do |part|
      puts part
    end
  end
end
