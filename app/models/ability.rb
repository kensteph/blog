class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :read, :all
    can :delete, Post do |post|
      post.author == user
    end
    can :delete, Comment do |comment|
      comment.author == user
    end

    return unless user.role == 'admin'

    can :manage, :all
    can :delete, Post
    can :delete, Comment
  end
end
