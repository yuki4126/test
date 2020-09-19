class User < ApplicationRecord
    validates :name, {presence: true}
    validates :email, {presence: true, uniqueness: true}
    validates :password, {presence: true}
    
    has_secure_password
    
    def posts
        return Post.where(user_id: self.id)
    end
    
    def post_like
        return Post.find_by(id: self.post_id)
    end
    
    def liked
        return Like.where(user_id: self.id)
    end
end
