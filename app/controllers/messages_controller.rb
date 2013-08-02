class MessagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_communication
  def index
    @messages = @communication.messages.order('created_at DESC').paginate(:page => params[:page], :per_page => params[:amount] || 6)
    @to_user_name = $redis.hget("user:#{current_user.id}", params[:to_user_id])
    @from_user_name = current_user.name
  end

  def create
    Message.create!(communication_id: @communication.id, body: params[:body], user_id: current_user.id)
    redirect_to action: :index, amount: params[:amount], to_user_id: params[:to_user_id]
  end

  private
  def find_communication
    users = [current_user.id, params[:to_user_id].to_i]
    user_min = users.min
    user_max = users.max
    @communication = Communication.find_by_from_user_id_and_to_user_id(user_min, user_max)
    if @communication.blank?
      user_name_min = User.find(user_min).name
      user_name_max = User.find(user_max).name
      @communication = Communication.create!(from_user_id: user_min, to_user_id: user_max)
      $redis.multi do
        $redis.hset("user:#{users.min}", user_max, user_name_max)
        $redis.hset("user:#{users.max}", user_min, user_name_min)
      end
    end
  end
end
