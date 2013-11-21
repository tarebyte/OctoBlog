class Post
  include Mongoid::Document
  include Mongoid::Slug
  include Tenacity

  field :title,   type: String
  field :content, type: String

  field :created_at,   type: DateTime, default: Time.now
  field :last_updated, type: DateTime, default: Time.now

  slug :title, :scope => :repo_id

  t_belongs_to :user
  belongs_to :repo
end
