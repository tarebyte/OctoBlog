class User < ActiveRecord::Base

  def self.from_omniauth(auth)
    where(auth.slice('provider', 'uid')).first || create_from_omniauth(auth)
  end

  # def to_param
  #   self.username.downcase
  # end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.username = auth['info']['nickname']
      user.name     = auth['info']['name'] ? auth['info']['name'] : user.username
      user.provider = auth['provider']
      user.uid      = auth['uid']
    end
  end
end
