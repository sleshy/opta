#!/usr/bin/env ruby
require 'watir-webdriver'
require 'pry-nav'
require 'optparse'

options = {}

options[:current_league] = "A"
options[:league_scouting] = "A"
options[:output_file] = "opta-#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}.csv"

option_parser = OptionParser.new do |opts|

	opts.banner = "Usage: ./opta_export.rb [options]"

	opts.on("-c", "--current_league [league]", "Set what CAPSL division you're currently in. Default is A.") do |league|
		options[:current_league] = league.capitalize
	end

	opts.on("-s", "--league_scouting [league]", "Set what CAPSL division you'd like to scout. Default is A.") do |league|
		options[:league_scouting] = league.capitalize
	end

	opts.on("-o", "--output-file <output file>", "Set file for results output (default is opta-time.csv)") do |output_file|
    options[:output_file] = output_file
  end
end

option_parser.parse!

b = Watir::Browser.new
output_file = File.open(options[:output_file],"w")

b.goto("xperteleven.com")
begin
  puts "username:"
  username = gets.chomp
  b.text_field(id: "ctl00_cphMain_FrontControl_lwLogin_tbUsername").set username
  puts "password:"
  system 'stty -echo'
  password = gets.chomp
  b.text_field(id: "ctl00_cphMain_FrontControl_lwLogin_tbPassword").set password
  system 'stty echo'
rescue NoMethodError, Interrupt
  system 'stty echo'
  exit
end

b.button(type: "submit").click

b.goto("http://xperteleven.com/standings.aspx?Lid=288129&Sel=T&Lnr=1&dh=2")

if options[:current_league] != options[:league_scouting]
  b.select_list(id: "ctl00_cphMain_usxLeagueMenu_dpdLeagues").select "#{options[:league_scouting]}-League"
end

game = 2
while game <= 6
  b.link(id: "ctl00_cphMain_dgLastGame_ctl0#{game}_Hyperlink14").click
  output_file.puts b.a(id: "ctl00_cphMain_hplHomeTeam").text
  output_file.puts b.table(id: "ctl00_cphMain_dgHomeLineUp").links.map(&:title).map! {|s| s.gsub(/\n|Grade: |Assist: [1-10]|Goal: [1-10]|Injured|Booked/,",")}.map! {|s| s.gsub(/\,{2,}/,",")}
  output_file.puts ""
  output_file.puts ""
  output_file.puts b.a(id: "ctl00_cphMain_hplAwayTeam").text
  output_file.puts b.table(id: "ctl00_cphMain_dgAwayLineUp").links.map(&:title).map! {|s| s.gsub(/\n|Grade: |Assist: [1-10]|Goal: [1-10]|Injured|Booked/,",")}.map! {|s| s.gsub(/\,{2,}/,",")}
  output_file.puts ""
  output_file.puts ""

game += 1
b.back
end

b.close
output_file.close

puts "output file: #{options[:output_file]}"

exit
