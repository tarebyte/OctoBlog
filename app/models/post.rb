class Post
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Timestamps
  include Tenacity

  field :title,   type: String
  field :content, type: String

  slug :title, :scope => :repo_id

  t_belongs_to :user
  belongs_to :repo
end
