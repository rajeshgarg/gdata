require 'rubygems'
require 'ruby-debug'
require 'gdata'
require 'pp'

SPREADSHEET_FEED = 'https://spreadsheets.google.com/feeds/spreadsheets/private/full'
SPREADSHEET_FEED = 'http://spreadsheets.google.com/feeds/spreadsheets/private/full'
client = GData::Client::DocList.new

email = "ronit.garg@gmail.com"
spreadsheet_name = "url"
password = "<rajesh>"
 if true
  puts "is here "
  if STDIN.tty?
    puts "Access a Google Spreadsheet Programmatically"

    unless email
      print "Enter gmail address: "
      email = STDIN.gets.strip
    end

    unless password
      %x[stty -echo]
      print "Enter password: "
      password = STDIN.gets.strip
      %x[stty echo]
      puts
    end

    client.clientlogin(email, password)

    if true
      puts "rajesh2 is here "
      spreadsheet_keys = [] # key(s) for entered spreadsheet_name

      # Get keys & names of my spreadsheets
      spreadsheets = {}
      feed = client.get('http://spreadsheets.google.com/feeds/spreadsheets/private/full').to_xml
      feed.elements.each('entry') do |entry|
        key = entry.elements['id'].text[/full\/(.*)/, 1].to_sym
        spreadsheets[key] = entry.elements['title'].text.strip
        puts spreadsheets[key]
      end

      while true
        print "Enter spreadsheet name exactly: "
        spreadsheet_name = STDIN.gets.strip

        # Find matching spreadsheets
        spreadsheets.each do |k, n|
          spreadsheet_keys << k if n == spreadsheet_name
        end

        if spreadsheet_keys.length > 1
          puts "You have more than one spreadsheet with that name:"
          spreadsheet_keys.each_with_index { |k, i| puts "#{i}. #{k}" }
          print "Enter the index of the one you want:"
          spreadsheet_key = spreadsheet_keys[STDIN.gets.strip.to_i]
          break
        elsif spreadsheet_keys.length == 1
          spreadsheet_key = spreadsheet_keys[0]
          break
        else
          puts 'We couldn\'t find your spreadsheet named ' +
            spreadsheet_name + '.'
          print "Please try again. "
        end
      end
    end
  else
    puts "usage: <GMail address> <spreadsheet_name> <password>"
    Process.exit
  end
end

puts email
puts spreadsheet_key