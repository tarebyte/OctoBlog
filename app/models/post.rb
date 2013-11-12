class Post
  include Mongoid::Document

  field :title,   type: String
  field :content, type: String

  field :created_at,   type: DateTime, default: Time.now
  field :last_updated, type: DateTime, default: Time.now

  field :author,    type: String
  field :author_id, type: Integer

  belongs_to :repo
end
