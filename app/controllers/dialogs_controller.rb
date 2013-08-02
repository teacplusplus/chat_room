class DialogsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @communications = Communication.for_user(current_user.id).paginate(:page => params[:page])
    @user_ids = Communication.to_users(@communications, current_user.id)
  end

  def create
    user = params[:name] !=current_user.name && User.where(['name = ?', params[:name]]).first
    if user.present?
      redirect_to controller: :messages, action: :index, to_user_id: user.id
    else
      redirect_to  dialogs_path, notice: 'User not found'
    end
  end

end
