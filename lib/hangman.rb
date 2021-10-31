# frozen_string_literal: true

require_relative 'visualizer'
require_relative 'progress_controller'
require 'json'

class Hangman
  LIVES = 6
  SAVE_COMMAND = '-save'
  LOAD_COMMAND = '-load'
  PROGRESS_FOLDER_NAME = 'progress'

  def initialize
    @game_over = false
    @correct_letters = []
    @misses = []
    @dictionary = []

    File.open('5desk.txt', 'r').readlines.each do |line|
      clean_line = line.strip
      @dictionary.push(clean_line) if clean_line.length > 4 && clean_line.length < 13
    end

    @game_word = @dictionary.sample
    @visualizer = Visualizer.new
    @progress_controller = ProgressController.new
  end

  def start_game
    main_loop
    on_game_over
  end

  private

  def main_loop
    until game_over
      puts 'Type -save to save your progress, type -load to load a save file or type a letter to continue the game:'
      user_input = gets.strip

      if user_input.length == 1
        continue_game(user_input)
      else
        on_command_enter(user_input)
      end
    end
  end

  def continue_game(guess)
    if guess.match?(/-?[0-9]/)
      puts 'Enter a single letter!'
    else
      check_is_guess_correct(guess)

      @visualizer.display_board(build_correct_word, guess, @misses)
    end
  end

  def on_command_enter(command)
    if command.match?(SAVE_COMMAND)
      data = {
        game_word: @game_word,
        correct_letters: @correct_letters,
        wrong_letters: @misses
      }

      @progress_controller.save(data)
    elsif command.match?(LOAD_COMMAND)
      load_progress
    else
      puts 'You have type unsupported commad. Type -save or -load.'
    end
  end

  def load_progress
    data = @progress_controller.get_load_data

    return if data.nil?

    @game_word = data['game_word']
    @correct_letters = data['correct_letters'].map(&:clone)
    @misses = data['wrong_letters'].map(&:clone)

    puts 'Game loaded!'
  end

  def on_game_over
    if @game_word.split(//).uniq.length == @correct_letters.length
      puts "You won! The word was indeed #{@game_word}."
    elsif LIVES == @misses.length
      puts "You lost. The word was #{@game_word}."
    end
  end

  def build_correct_word
    guessed_word = ''

    @game_word.split(//).each do |letter|
      guessed_word += if @correct_letters.any?(letter)
                        "#{letter} "
                      else
                        '_ '
                      end
    end

    guessed_word
  end

  def check_is_guess_correct(guess)
    if @game_word.downcase.match?(guess)
      @correct_letters.push(guess) unless @correct_letters.any?(guess)
    else
      @misses.push(guess) unless @misses.any?(guess)
    end
  end

  def game_over
    @game_word.split(//).uniq.length == @correct_letters.length || LIVES == @misses.length
  end
end

hangman = Hangman.new
hangman.start_game
