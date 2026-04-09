class BookListsController < ApplicationController
  before_action :set_klub
  before_action :require_membership
  before_action :set_book_list, only: %i[show edit update destroy]

  def show
    @ratings   = @book_list.ratings.includes(:user).order(created_at: :asc)
    @my_rating = @book_list.ratings.find_or_initialize_by(user: Current.session.user)
  end

  def new
    @book_list = @klub.book_lists.new
    @book_list.build_book
  end

  def create
    @book = find_or_build_book
    @book_list = @klub.book_lists.new(month: schedule_params[:month], year: schedule_params[:year], book: @book)

    if @book.save && @book_list.save
      redirect_to @klub, notice: "Book added to reading list."
    else
      @book_list.book = @book
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @book_list.book.update(book_params)
    if @book_list.update(schedule_params)
      redirect_to @klub, notice: "Reading list entry updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book_list.destroy
    redirect_to @klub, notice: "Book removed from reading list."
  end

  private

  def set_klub
    @klub = Klub.find(params[:klub_id])
  end

  def require_membership
    unless @klub.member?(Current.session.user)
      redirect_to root_path, alert: "You must be a member to manage the reading list."
    end
  end

  def set_book_list
    @book_list = @klub.book_lists.find(params[:id])
  end

  def find_or_build_book
    Book.find_or_initialize_by(title: book_params[:title].to_s.strip, author: book_params[:author].to_s.strip).tap do |b|
      b.goodreads_url = book_params[:goodreads_url]
      b.description   = book_params[:description]
    end
  end

  def book_params
    params.expect(book_list: [ :title, :author, :goodreads_url, :description ])
  end

  def schedule_params
    params.expect(book_list: [ :month, :year ])
  end
end
