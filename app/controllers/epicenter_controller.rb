class EpicenterController < ApplicationController
  include ApplicationHelper

  def feed
  	# Here we initialize the array that will 
  	# hold tweets from the current_user's 
  	# following list.
  	@tweets_for_feed = []

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
    @tweets_for_feed = Tweet.paginate(:page => params[:page], :per_page => 5).order('updated_at DESC')

    show_followers
     
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
    show_followers 

    # Show a user's tweets
    @user_tweets = @user.tweets.paginate(:page => params[:page], :per_page => 5).order('updated_at DESC')
     
  end

  def now_following
  	# This line is just for displaying purposes:
  	@user = User.find(params[:follow_id])
  	# Here is where some back-end
  	# work really happens:
  	current_user.following.push(params[:follow_id].to_i)
  	# What we're doing is added the user.id of
  	# the User you want to follow to your
  	# 'following' array attribute.
  	current_user.save

    if current_user.save
      flash[:success] = "You are now following #{@user.username}!"
      redirect_to root_path
    else
      flash[:error] = "Something went wrong."
    end
    show_followers
  end

  def unfollow
    @user = User.find(params[:follow_id])
    current_user.following.delete(params[:follow_id].to_i)
    current_user.save
     if current_user.save
      flash[:success] = "You are no longer following #{@user.username}!"
      redirect_to root_path
    else
      flash[:error] = "Something went wrong."
    end
    show_followers
  end
end
