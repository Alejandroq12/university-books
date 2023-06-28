# books_controller.rb
require_relative 'book'

class BooksController
  def initialize(interface)
    @interface = interface
    @books = []
  end

  def list_all_books
    @books.each { |book| @interface.print_message("Title: \"#{book.title}\", Author: #{book.author}") }
  end

  def create_book
    @interface.print_message('Title: ')
    title = @interface.get_input

    @interface.print_message('Author: ')
    author = @interface.get_input

    @books << Book.new(title, author)
    @interface.print_message('Book created successfully')
  end

  # This method will be used by RentalsController to list all books and get the selected one
  def select_book
    @interface.print_message('Select a book from the following list by number')
    @books.each_with_index do |book, index|
      @interface.print_message("#{index}) Title: \"#{book.title}\", Author: #{book.author}")
    end
    book_index = @interface.get_input.to_i
    @books[book_index]
  end
end
