require 'task'
# require 'rspec'
require 'pg'


DB = PG.connect(:dbname => 'to_do_list_test')

Rspec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM tasks *;")
  end
end

describe Task do
  it 'is initialized with a name and task ID' do
    task = Task.new('Do Stuff', 1)
    expect(task).to be_an_instance_of Task
  end

  it 'tells you its name' do
    task = Task.new('Do Stuff', 1)
    expect(task.name).to eq 'Do Stuff'
  end

  it 'tells you its list ID' do
    task = Task.new('Do Stuff', 1)
    expect(task.list_id).to eq 1
  end

  it "starts with no tasks" do
    expect(Task.all).to eq []
  end

  it 'lets you save tasks to the database' do
    task = Task.new('Do Stuff', 1)
    task.save
    expect(Task.all).to eq [task]
  end

  it 'Is the same task if it has the same name and list ID' do
    task1 = Task.new('Do Stuff', 1)
    task2 = Task.new('Do Stuff', 1)
    expect(task1).to eq task2
  end


end
