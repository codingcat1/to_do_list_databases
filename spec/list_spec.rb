require 'rspec'
require 'list'
require 'pg'

DB = PG.connect(:dbname => 'to_do_list_test')

Rspec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM lists *;")
  end
end

describe List do

  it "is initialized with a name" do
    list = List.new('Some List')
    expect(list).to be_an_instance_of List
  end

  it 'tells you its name' do
    list = List.new('Some List')
    expect(list.name).to eq 'Some List'
  end

  it "starts with no lists" do
    expect(List.all).to eq []
  end

  it 'lets you save lists to the database' do
    list = List.new('Some List')
    list.save
    expect(List.all).to eq [list]
  end

  it 'is the same list if it has the same name' do
    list1 = List.new('Some List')
    list2 = List.new('Some List')
    expect(list1).to eq list2
  end

  it 'sets the ID when you save it' do
    list = List.new('Some List')
    list.save
    expect(list.id).to be_an_instance_of Fixnum
  end

end

