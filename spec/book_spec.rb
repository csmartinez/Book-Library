require("rspec")
require("pg")
require("library")
require("pry")

DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM books *;")
  end
end

describe(Book) do
  describe(".all") do
    it("is empty at first") do
      expect(Book.all()).to(eq([]))
    end
  end

  describe(".find") do
    it("searches for book by title or author") do
      test_book = Book.new({:title => "To Kill A Mockingbird", :author => "Harper Lee"})
      test_book.save()
      test_book2 = Book.new({:title => "Slouching Towards Bethlehem", :author => "Joan Didion"})
      test_book2.save()
      expect(Book.find("title", "Slouching Towards Bethlehem")).to(eq([test_book2]))
    end
  end

  describe("#save") do
    it("adds a book to the array of saved books") do
      test_book = Book.new({:title => "Slouching Towards Bethlehem", :author => "Joan Didion"})
      test_book.save()
      expect(Book.all()).to(eq([test_book]))
    end
  end

  describe("#==") do
    it("is the same book if it has the same title and author") do
      book1 = Book.new({:title => "To Kill A Mockingbird", :author => "Harper Lee"})
      book2 = Book.new({:title => "To Kill A Mockingbird", :author => "Harper Lee"})
      expect(book1).to(eq(book2))
    end
  end

  describe("#author") do
    it("lets you know who the author is") do
      test_book = Book.new({:title => "To Kill A Mockingbird", :author => "Harper Lee"})
      expect(test_book.author()).to(eq("Harper Lee"))
    end
  end

  describe("#title") do
    it("lets you know what the title is") do
      test_book = Book.new({:title => "To Kill A Mockingbird", :author => "Harper Lee"})
      expect(test_book.title()).to(eq("To Kill A Mockingbird"))
    end
  end

  describe("#update") do
    it("lets you update books in the database") do
      testbook = Book.new({:title => "Colllected Stories", :author => "Lydia Davis"})
      testbook.save()
      testbook.update({:title => "Collected Stories", :author => "Lydia Davis"})
      expect(testbook.title()).to(eq("Collected Stories"))
    end
  end

end
