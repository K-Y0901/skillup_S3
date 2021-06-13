class BooksController < ApplicationController
  before_action :authenticate_user!,only: [:create,:edit,:update,:destroy,:index]
  impressionist :actions=> [:show]

  def index
    @books = Book.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    
    impressionist(@book, nil, unique: [:ip_address])
  end

  def edit
    @book = Book.find(params[:id])
    screen_user(@book)
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to @book
    else
      @books = Book.all
      render 'index'
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
    def book_params
      params.require(:book).permit(:title, :body, :rate)
    end

    def screen_user(book)
      if book.user.id != current_user.id
        redirect_to books_path
      end
    end

end
