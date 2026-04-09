class RatingsController < ApplicationController
  before_action :set_klub
  before_action :set_book_list
  before_action :require_membership

  def create
    @rating = @book_list.ratings.find_or_initialize_by(user: Current.session.user)
    @rating.score = rating_params[:score]

    if @rating.save
      redirect_to klub_book_list_path(@klub, @book_list), notice: "Rating saved."
    else
      redirect_to klub_book_list_path(@klub, @book_list), alert: @rating.errors.full_messages.to_sentence
    end
  end

  def destroy
    @book_list.ratings.find_by(user: Current.session.user)&.destroy
    redirect_to klub_book_list_path(@klub, @book_list), notice: "Rating removed."
  end

  private

  def set_klub
    @klub = Klub.find(params[:klub_id])
  end

  def set_book_list
    @book_list = @klub.book_lists.find(params[:book_list_id])
  end

  def require_membership
    unless @klub.member?(Current.session.user)
      redirect_to root_path, alert: "You must be a member to rate books."
    end
  end

  def rating_params
    params.expect(rating: [ :score ])
  end
end
