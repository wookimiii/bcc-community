class Post
  include Mongoid::Document
  field :body, type: String
  embeds :user
end
