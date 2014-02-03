class User < ActiveRecord::Base
  # see: https://github.com/plataformatec/devise
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :follows
  has_many :twets

  validates :name, :presence => true
  validates :username, :presence => true, :uniqueness => true

  # Scope method to get all users except the one passed.
  #
  def self.all_except(user)
    User.where(arel_table[:id].not_eq(user.id)).order(:name)
  end

  # Leverages Twet.by_user_ids to return all twets created by this user
  # and all users that this user follows.
  #
  def all_twets
    Twet.by_user_ids(id, *follows.map(&:following_id))
  end

  def gravatar
    email_address = self.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    image_scr = "http://www.gravatar.com/avatar/#{hash}"
  end
end
