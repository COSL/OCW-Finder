  class CommentsController < Muck::CommentsController
    
    before_filter :login_required # require the user to be logged in to make a comment
    
    # Modify this method to change how permissions are checked to see if a user can comment.
    # Each model that implements 'acts_as_muck_comment' can override can_comment? to 
    # change how comment permissions are handled.
    def has_permission_to_comment(user, parent)
      parent.can_comment?(user)
    end
    
  end
