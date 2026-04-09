class KlubsController < ApplicationController
  before_action :set_klub, only: %i[show]

  def index
    @my_klubs    = Current.session.user.klubs
    @other_klubs = Klub.where.not(id: @my_klubs)
  end

  def show
    @members = @klub.memberships.includes(:user)
    # Preload ratings so average_score doesn't cause N+1 queries
    @klub.book_lists.includes(:ratings)
  end

  def new
    @klub = Klub.new
  end

  def create
    @klub = Klub.new(klub_params)
    if @klub.save
      @klub.memberships.create!(user: Current.session.user, role: "admin")
      redirect_to @klub, notice: "Klub created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_klub
    @klub = Klub.find(params[:id])
  end

  def klub_params
    params.expect(klub: [ :name, :description, :activity_type ])
  end
end
