class EpicenterController < ApplicationController

  def feed
  	# Here we initialize the array that will 
  	# hold tweets from the current_user's 
  	# following list.
  	@tweets_for_feed = []
    @users = User.all

  	# We pull in all the tweets...
  	@tweetz = Tweet.all.order(:updated_at).reverse
  	# Then we sort through the tweets
  	# to find the ones associated with
  	# users from the current_user's 
  	# following array.
  	@tweetz.each do |tweet|
  		current_user.following.each do |f|
  			if tweet.user_id == f
  				@tweets_for_feed.push(tweet)
  				# And those tweets are pushed
  				# into the @following_tweets array
  				# we saw back in the view.
  			end
  		end
  	end

    @tweets_for_feed = @tweets_for_feed.paginate(:page => params[:page], :per_page => 5)
     
    if current_user.following == ""
      @user = User.find(current_user.following.last)
    end

  end

  def show_user
  	@user = User.find(params[:user_id])
    @users = User.all

    tweet = Tweet.new
    tweet.message = params[:message]
    tweet.user_id = params[:user_id]
    tweet.save
    #show_followers 

    # Show a user's tweets
    @user_tweets = @user.tweets.paginate(:page => params[:page], :per_page => 5).order('updated_at DESC')
     
  end

  def now_following
  	@user = User.find(params[:follow_id])

  	# Add the user.id of the user you are now following to an array
  	current_user.following.push(params[:follow_id].to_i)
    
    # Add the current user's id to the followers array of the user who is now following you
    @user.followers.push(current_user.id)

    current_user.save
    @user.save

    #puts "*********************"
    #puts "@user.followers: #{@user.followers}"
    #puts "@user.username: #{@user.id}"
    #puts "current_user.id: #{current_user.id}"
    #puts "*********************"

    if current_user.save
      flash[:success] = "You are now following #{@user.username}!"
      redirect_to root_path
    else
      flash[:error] = "Something went wrong."
    end
  end

  # def show_followers
  #    # Caclulate number of followers
  #   @users = User.all
  #   @followers = []
  #   @users.each do |user|
  #     user.following.each do |f|
  #       if f == current_user.id
  #         @followers.push(user.id)
  #       end
  #     end
  #   end
  # end

  def unfollow
    @user = User.find(params[:follow_id])

    current_user.following.delete(params[:follow_id].to_i)
    @user.followers.delete(current_user.id)

    current_user.save
    @user.save
    
     if current_user.save
      flash[:success] = "You are no longer following #{@user.username}!"
      redirect_to root_path
    else
      flash[:error] = "Something went wrong."
    end
    #show_followers
  end
end
