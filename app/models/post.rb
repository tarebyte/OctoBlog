class Post
  include Mongoid::Document
  include Tenacity

  field :title,   type: String
  field :content, type: String

  field :created_at,   type: DateTime, default: Time.now
  field :last_updated, type: DateTime, default: Time.now

  field :author,    type: String
  field :user_id,   type: Integer

  t_belongs_to :user
  belongs_to :repo
end
