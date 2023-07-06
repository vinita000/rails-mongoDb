class Post
  include Mongoid::Document

  field :title, type: String
  field :body, type: String

  ### validation, association 
  # has_many :comments, dependent: :destroy
  embeds_many :comments
end
