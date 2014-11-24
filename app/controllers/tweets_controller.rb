class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @tweets = Tweet.paginate(:page => params[:page], :per_page => 5).order('updated_at DESC')
    #@tweets = @tweets.order(:updated_at).reverse
    @users = User.all
    respond_with(@tweets)
  end

  def show
    respond_with(@tweet)
  end

  def new
    @tweet = Tweet.new
    respond_with(@tweet)
  end

  def edit
    @users = User.all
  end

  def create
    @tweet = Tweet.new(tweet_params)
   #@tweet.save
   #respond_with(@tweet)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to tweets_path, notice: 'Woof was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @tweet.update(tweet_params)
   # respond_with(@tweet)
   respond_to do |format|
      if @tweet.save
        format.html { redirect_to tweets_path, notice: 'Woof was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tweet.destroy
    respond_with(@tweet)
  end

  private
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def tweet_params
      params.require(:tweet).permit(:message, :user_id)
    end
end
