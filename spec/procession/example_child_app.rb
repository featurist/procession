# creates a file called delete_me.txt after 0.5s

temp_filename = File.expand_path("../delete_me.txt", __FILE__)

sleep 0.5

File.open(temp_filename, 'w') do |f|
  f.write("""This file is created by example_child_app.rb, which should
             never actually happen, because the child process is killed.""")
end