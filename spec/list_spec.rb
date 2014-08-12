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

end

