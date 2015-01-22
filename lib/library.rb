class Library
  attr_reader(:title, :author, :id)

  define_method(:initialize) do |attributes|
    @title = attributes.fetch(:title)
    @author = attributes.fetch(:author)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    #all look at https://www.learnhowtoprogram.com/lessons/to-do-with-sql-weekend-homework
  end
end
