class UserController < ApplicationController

def show
	#Alternate method.
	#@user = User.find_by username: params[:username]
	@user = User.where(username: params[:username]).first
	@twets = @user.all_twets
end

end
