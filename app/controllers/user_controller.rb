class UserController < ApplicationController

def show
	#Alternate method.
	#@user = User.find_by username: params[:username]
	@user = User.where(username: params[:username]).first
	@twets = Twet.by_user_ids(@user.id) if @user
end

end
