class Repo
  include Mongoid::Document

  field :name,   type: String
  field :url,    type: String

  field :author,    type: String
  field :author_id, type: Integer

  has_many :posts
end
