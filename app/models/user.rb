class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username, use: :slugged

  def self.from_omniauth(auth)
    where(auth.slice('provider', 'uid')).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.username = auth['info']['nickname']
      user.name     = auth['info']['name'] ? auth['info']['name'] : user.username
      user.provider = auth['provider']
      user.uid      = auth['uid']
      user.slug     = user.username
    end
  end

  # Wrappers for Mongo Queries since we can't make associations
  def post(title)
    Post.where(title: title)
  end

  def repo(name)
    Repo.where(name: name)
  end

  def repos
    Repo.where(author_id: self.id)
  end

  def posts
    Post.where(author_id: self.id)
  end
end
