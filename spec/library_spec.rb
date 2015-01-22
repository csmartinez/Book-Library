require("rspec")
require("pg")
require("book")
require("pry")

DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM library *;")
  end
end

describe(List) do
  describe(".all") do
    it("starts with no library") do
      expect(Library.all()).to(eq([]))
    end
  end

end
