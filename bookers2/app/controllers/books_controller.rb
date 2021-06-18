class BooksController < ApplicationController
  before_action :authenticate_user!,only: [:create,:edit,:update,:destroy,:index]
  impressionist :actions=> [:show]

  def index
    @book = Book.new
    
    if params[:sort_update]
      @books = Book.latest  ##新しい順
    elsif params[:rate_update]
      @books = Book.rate  ##評価順
    else
      @books = Book.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    end
    
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
  
  def search
    @book = Book.new
    @books = Book.search(params[:search])
    render "index"
  end
  
  def day_search
    @user = current_user
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    # @day_search = Book.search(params[:day_search])
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  
    @books = @user.books
    @book = Book.new
    
    @day_search = Book.day_search(params[:day_search])
    render "users/show"
  end
  
  def category
    @book = Book.new
    @books = Book.where(category: params[:category])
    render "index"
  end

  private
    def book_params
      params.require(:book).permit(:title, :body, :rate, :category)
    end

    def screen_user(book)
      if book.user.id != current_user.id
        redirect_to books_path
      end
    end

end
