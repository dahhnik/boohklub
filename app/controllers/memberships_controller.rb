class MembershipsController < ApplicationController
  before_action :set_klub

  def create
    unless @klub.member?(Current.session.user)
      @klub.memberships.create!(user: Current.session.user, role: "member")
    end
    redirect_to @klub, notice: "You joined #{@klub.name}!"
  end

  def destroy
    membership = @klub.memberships.find_by(user: Current.session.user)
    membership&.destroy
    redirect_to klubs_path, notice: "You left #{@klub.name}."
  end

  private

  def set_klub
    @klub = Klub.find(params[:klub_id])
  end
end
