class User < ActiveRecord::Base
  include Tenacity

  extend FriendlyId
  friendly_id :username, use: :slugged

  t_has_many :repos
  t_has_many :posts

  ROLES = %w{ admin member }

  def avatar
    # return the avatar url, default to github identicons
    avatar_url || "https://identicons.github.com/#{username}.png"
  end

  def self.from_omniauth(auth)
    user = where(auth.slice('provider', 'uid')).first || create_from_omniauth(auth)

    # get avatar_url from Github
    if !auth.extra.raw_info.nil?
      avatar_url = auth.extra.raw_info.avatar_url

      # update it if necessary
      if user.avatar_url != avatar_url
        user.avatar_url = avatar_url
        user.save
      end
    else 
      avatar_url = "http://placehold.it/391x391"
    end

    user
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.username = auth['info']['nickname']
      user.name     = auth['info']['name'] ? auth['info']['name'] : user.username
      user.provider = auth['provider']
      user.uid      = auth['uid']
      user.slug     = user.username
      user.role     = 'member'
    end
  end

  # Meta programming bitch
  # add is_member? and is_admin?
  ROLES.each do |a_role|
    define_method "is_#{a_role}?" do
      role == a_role
    end
  end
end
