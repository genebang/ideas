class UserMailer < ActionMailer::Base
  
  default :from => IDEAS_EMAIL

  def new_idea_notification(user, post)
    @user = user
    @idea = post
    mail(:to => @user.email, :subject => "New idea posted at Ideas") unless @idea.user.email == @user.email
  end

  def new_comment_notification(post)
    post_owner = post.user.email
    @comment = post
    mail(:to => post_owner, :subject => "New coment on your idea at Ideas") unless post_owner == @comment.user.email
  end

end
