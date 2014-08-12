require './lib/task'
require './lib/list'


DB = PG.connect(:dbname => 'to_do_list')

@current_list = nil

def main_menu
  loop do
    system 'clear'
    puts "###Welcome to the To Do list!###"
    puts "Type 'a' to add a list, or press 'l' to show lists."
    puts "Type 'x' to exit"
    main_choice = gets.chomp
    if main_choice == 'a'
      add_list
    elsif main_choice == 'l'
      show_lists
    elsif main_choice == 'x'
      puts "Thanks Bye"
      exit
    else
      puts "Not a valid entry"
      sleep(0.5)
    end
  end
end

def add_list
  puts "Please type a name for your new list."
  input_list_name = gets.chomp
  List.new(input_list_name).save
  puts "Your list has been added!"
  main_menu
end

def show_lists
  puts " Here are your lists"
  List.all.each do |list|
    puts list.name
  end
  puts "Type in the name of the list that you would like to add a task to."
  list_name = gets.chomp
  List.all.each do |list|
    if list_name == list.name
      @current_list = list
    end
  end
  add_task
end

def add_task
  puts "press 't' to add task or 'm' to return to main menu"
  choice = gets.chomp
  if choice == 't'
    puts "Enter a task:"
    input_task_name = gets.chomp
    Task.new(input_task_name, @current_list.id).save
  end
end

main_menu
