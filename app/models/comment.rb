class Comment
  include Mongoid::Document

  field :name, type: String
  field :message, type: String
  field :post_id, type: BSON::ObjectId


  # belongs_to :post
  embedded_in :post
end
