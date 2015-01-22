class Book
  attr_reader(:title, :author)

  define_method(:initialize) do |attributes|
    @title = attributes.fetch(:title)
    @author = attributes.fetch(:author)
  end

  define_singleton_method(:all) do
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each() do |book|
     title = book.fetch("title")
     author = book.fetch("author")
     books.push(Book.new({:title => title, :author => author}))
    end
    books
  end

  define_method(:==) do |another_book|
    self.title().==(another_book.title()).&(self.author().==(another_book.author()))
  end

  define_method(:save) do
    DB.exec("INSERT INTO books (title, author) VALUES ('#{@title}', '#{@author}')")
  end

  define_singleton_method(:find) do |search_by, search_term|
    results = []
    the_book = []
    Book.all.each() do |searched_book|
      if search_by.eql?("title")
        if searched_book.title().include?(search_term)
          the_book = searched_book
          results.push(the_book)
        end
      elsif search_by.eql?("author")
        if searched_book.author().include?(search_term)
          the_book = searched_book
          results.push(the_book)
        end
      end
    end
    results
  end

  define_method(:update) do |attributes|
    @title = attributes.fetch(:title)
    @author = attributes.fetch(:author)
    DB.exec("UPDATE books SET title = '#{@title}' WHERE author = '#{@author}';")
  end
end
