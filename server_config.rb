require 'yaml'

config_file = File.join(File.expand_path(File.dirname(__FILE__)), 'config.yml')

# Checking config file presence
raise 'Unable to find config.yml' unless File.exist?(config_file)

config = YAML::load(File.open(config_file))

if config['steps'] && config['steps'].any?
  cont = 1
  config['steps'].each do |step|
    puts "\n(#{cont}/#{config['steps'].size}) - Installing '#{step[:short_name]}'\n"
    puts "\n" + (system(step[:command]) ? 'OK' : 'ERROR') + "\n"
    cont += 1
  end
else
  puts "No steps to do"
  exit
end

# require 'yaml'
# config = {}
# config['debug'] = true
# config['steps'] = [ { :short_name   => 'Creating simoned account',
#                       :command      => 'command1'},
#                     { :short_name   => 'Setting password for simoned account',
#                       :command      => 'command2'},
#                     { :short_name   => 'Touching a file inside simoned home',
#                       :command      => 'command3'}]
# File.open('config.yml', 'w') do |f|
#   f.puts config.to_yaml
# end