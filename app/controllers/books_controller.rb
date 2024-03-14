class BooksController < ApplicationController
  before_action :move_to_signed_in, only: [:edit, :show, :index]
  def new
   @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
       redirect_to book_path(@book.id)
    else
      @books = Book.all
       render :index
    end
  end

  def index
     move_to_signed_in
    @book = Book.new
    @books = Book.all
  end

  def show
     move_to_signed_in
    @book = Book.find(params[:id])
  end

  def edit
     move_to_signed_in
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      @books = Book.all
      redirect_to '/books'
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
    redirect_to book_path(@book.id)
    else
      render 'edit'
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

   private
  def move_to_signed_in
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
end
