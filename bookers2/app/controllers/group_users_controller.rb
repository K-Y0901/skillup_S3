class GroupUsersController < ApplicationController
    def create
        @group_user = GroupUser.new(group_user_params)
        @group_user.user_id = current_user.id
        @group_user.save
        redirect_to groups_path
    end
    
    def destroy
        @group = Group.find(params[:id])
        group_user = GroupUser.find_by(user_id: current_user, group_id: @group.id)
        group_user.destroy
        redirect_to groups_path
    end
    
    private
    
    def group_user_params
      params.require(:group_user).permit(:group_id)
    end
end
