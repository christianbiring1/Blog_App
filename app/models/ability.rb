class Ability
  include CanCan::Ability

  def initialize(user)
    # Handle the case where we don't have a current_user i.e. the user is a guest
    # user ||= User.new
    # can :read, :all, id: user.id

    # if user.role == 'admin'
    #   can :manage, :all
    #   can :access, :rails_admin
    # else
    #   can :manage, Post, author_id: user.id
    #   can :manage, Comment, author_id: user.id
    #   can :read, User, id: user.id
    # end
    return unless user.present?
    can :destroy, Post, author_id: user.id
    can :destroy, Comment, author_id: user.id
    return unless user.admin?
    can :manage, :all
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
