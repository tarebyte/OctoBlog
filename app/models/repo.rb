class Repo
  include Mongoid::Document
  include Tenacity

  field :name,   type: String
  field :url,    type: String

  t_belongs_to :user
  has_many :posts
end
