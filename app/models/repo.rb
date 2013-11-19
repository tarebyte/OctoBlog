class Repo
  include Mongoid::Document
  include Mongoid::Slug
  include Tenacity

  field :name,   type: String
  field :url,    type: String

  slug do |cur_object|
    cur_object.name
  end

  t_belongs_to :user
  has_many :posts
end
