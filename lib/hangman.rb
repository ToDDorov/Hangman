require_relative 'visualizer'

class Hangman
  LIVES = 6

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
  end

  def start_game
    main_loop
    on_game_over
  end

  private

  def main_loop
    until game_over
      puts 'Enter you letter: '
      guess = gets.strip

      if guess.length > 1 || guess.match?(/-?[0-9]/)
        puts 'Enter a single letter!'
      else
        check_is_guess_correct(guess)

        @visualizer.display_board(build_correct_word, guess, @misses)
      end
    end
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
