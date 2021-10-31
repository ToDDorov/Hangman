require 'json'

class GameLoader
  PROGRESS_FOLDER_NAME = 'progress'

  def save_progress(_data)
    time = Time.now
    file_name = "#{PROGRESS_FOLDER_NAME}/#{time.strftime('%F %T')}.json"

    Dir.mkdir(PROGRESS_FOLDER_NAME) unless Dir.exist?(PROGRESS_FOLDER_NAME)

    write_progress_to_file(file_name)

    puts "Game saved to file #{time.strftime('%F %T')}."
  end

  def write_progress_to_file(file_name)
    File.open(file_name, 'w') do |file|
      file.puts JSON.dump(_data)
    end
  end

  def load_progress
    if Dir.exist?(PROGRESS_FOLDER_NAME)
      correct_file_name_entered = false

      progress_files = Dir.children(PROGRESS_FOLDER_NAME)
      puts 'Type the file name you want to load or type "exit" to continue the game. Files:'
      puts progress_files

      until correct_file_name_entered
        file_name = gets.strip

        break if file_name == 'exit'

        if progress_files.any?(file_name)
          data = JSON.load File.read("#{PROGRESS_FOLDER_NAME}/#{file_name}")

          @game_word = data['game_word']
          @correct_letters = data['correct_letters'].map(&:clone)
          @misses = data['wrong_letters'].map(&:clone)

          correct_file_name_entered = true
          puts 'Game loaded!'
        else
          puts "There is no file with name #{file_name}."
        end
      end
    else
      puts 'There are no saved files.'
    end
  end
end
