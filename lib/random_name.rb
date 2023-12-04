require 'httparty'

def menu
  puts "What's your poison?"
  puts
  puts '0 - exit'
  puts '1 - random first name'
  puts '2 - random last name'
  puts '3 - random full name'
  puts '4 - convert response into new object then print the object'
  puts
  puts 'Pls enter a response:'
  choice = gets.chomp
  find_path(choice)
end

def find_path(choice)
  @chosen_value = ""
  case choice
  when '0'
    @chosen_value = close_script
  when '1'
    @chosen_value = get_first_name
  when '2'
    @chosen_value = get_last_name
  when '3'
    @chosen_value = get_full_name
  when '4'
    @chosen_value = parse_api_response
  else
    invalid_answer
  end
  puts "Here's your answer!"
  puts @chosen_value
  sleep 1.5
  puts "Want to go again? [y/n]"
  answer = gets.chomp
  case answer
  when 'y' || 'yes'
    menu
  when 'n' || 'no'
    close_script
  else
    invalid_answer
  end
end

def close_script
  puts
  puts 'Thanks for playning!'
  sleep 0.5
  puts 'Goodbye!'
  exit
end

def invalid_answer
    puts 'INVALID RESPONSE!!!!!!!'
    sleep 0.2
    puts 'YOU MONSTER'
    sleep 0.2
    puts 'TRY AGAIN!!!!!'
    sleep 0.2
    puts
    menu
end

def parse_api_response
  response = HTTParty.get('https://randomuser.me/api/')
  if response.success?

    user_data = response['results'][0]['name']

    {
      first_name: user_data['first'],
      last_name: user_data['last']
    }
  else
    {
      first_name: "al'Lan",
      last_name: 'Mandragoran'
    }
  end
end

def get_first_name
  name = parse_api_response[:first_name]
  return name
end

def get_last_name
  name = parse_api_response[:last_name]
  return name
end

def get_full_name
  # name = "#{parse_api_response[:first_name]} #{parse_api_response[:last_name]}"
  name = parse_api_response.map { |key, value| "#{value}" }.join(' ')
  return name
end

if __FILE__ == $0
  menu
end
