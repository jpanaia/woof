class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  serialize :following, Array
  serialize :followers, Array

  has_many :tweets

  validates :name, :username, :location, :bio, presence: true
  validates :email, :username, uniqueness: true

  has_attached_file :avatar, 
  :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
  :default_url => "missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end