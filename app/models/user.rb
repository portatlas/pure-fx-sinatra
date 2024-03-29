class User < ActiveRecord::Base

  include BCrypt
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  has_many :fxrequests, {class_name: "Fxtran", foreign_key: :requestor_id}
  has_many :fxaccepts, {class_name: "Fxtran", foreign_key: :acceptor_id}

  # has_secure_password

  def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end

  def self.authenticate(email, password)
    @user = User.find_by(email: email)
    if @user && @user.password == password
      @user
    else
      nil
    end
  end

end
