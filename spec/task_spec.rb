require 'Task'
require 'rspec'

describe Task do
  it 'is initialized with a name' do
    task = Task.new('Do Stuff')
    expect(task).to be_an_instance_of Task
  end

end
