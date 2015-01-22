require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/book")
require("pg")
require("pry")

DB = PG.connect({:dbname => "library"})

get("/") do
  @books = Book.all()
  erb(:index)
end

post("/") do
  @author = params.fetch("author")
  @title = params.fetch("title")
  @the_book = Book.new({:author => @author, :title => @title})
  @the_book.save()
  redirect("/")
end

post('/search') do
  @search_by = params.fetch("search_by")
  @search_term = params.fetch("search_term")
  @results = Book.find(@search_by, @search_term)
  erb(:search)
end
