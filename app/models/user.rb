class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :avatar, :provider, :uid, :stripe_token, :coupon
  attr_accessor :stripe_token, :coupon 
  before_save :update_stripe
  # attr_accessible :title, :body
  has_many :wikis, dependent: :destroy
  has_many :sales
  has_many :collaborations
  has_many :users, :through => :collaborations
  # before_create :set_member
  #validates_numericality_of :price,
    #greater_than: 49,
    #message: "must be at least 50 cents"

  mount_uploader :avatar, AvatarUploader

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      pass = Devise.friendly_token[0,20]
      user = User.new(username: auth.extra.raw_info.name,
                         provider: auth.provider,
                         uid: auth.uid,
                         email: auth.info.email,
                         password: pass,
                         password_confirmation: pass
                        )
      user.skip_confirmation!
      user.save
    end
    user
  end

  ROLES = %w[free basic pro moderator admin]
  def role?(base_role)
    role.nil? ? false : ROLES.index(base_role.to_s) <= ROLES.index(role)
  end  

  def collaborating(wiki)
    self.collaborations.where(id: wiki.id).first
  end
  
  #Users with an “example.com” domain will not be added to Stripe as subscribers; they will only be added to the application database.
  # def update_stripe
  # return if email.include?(ENV['ADMIN_EMAIL'])
  # return if email.include?('@example.com') and not Rails.env.production?
  # end

  def update_stripe
    return if email.include?(ENV['ADMIN_EMAIL'])
    return if email.include?('@example.com') and not Rails.env.production?
    if customer_id.nil?
      if !stripe_token.present?
        raise "Stripe token not present. Can't create account."
      end
      if coupon.blank?
        customer = Stripe::Customer.create(
          :email => email,
          :description => username,
          :card => stripe_token,
          :plan => role
        )
      else
        customer = Stripe::Customer.create(
          :email => email,
          :description => username,
          :card => stripe_token,
          :plan => role,
          :coupon => coupon
        )
      end
    else
      customer = Stripe::Customer.retrieve(customer_id)
      if stripe_token.present?
        customer.card = stripe_token
      end
      customer.email = email
      customer.description = username
      customer.save
    end
    self.last_4_digits = customer.cards.data.first["last4"]
    self.customer_id = customer.id
    self.stripe_token = nil
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "#{e.message}."
    self.stripe_token = nil
    false
  end

  private

  # def set_member
  #   self.role = 'free'
  # end

end