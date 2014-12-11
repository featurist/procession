child_app_path = File.expand_path("../example_child_app.rb", __FILE__)

puts "Starting child app..."
spawn("ruby", child_app_path)
