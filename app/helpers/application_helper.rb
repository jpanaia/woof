module ApplicationHelper
  def show_followers
     # Caclulate  # of followers
    @users = User.all
    @followers = []
    @users.each do |user|
      user.following.each do |f|
        if f == current_user.id
          @followers.push(user.id)
        end
      end
    end
  end

end
