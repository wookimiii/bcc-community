class User
  include Mongoid::Document
  field :uid, type: String
  field :name, type: String
  field :image_url, type: String
  embedded_in :Post
end
