class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  field :body, type: String
  embeds_one :user
end
