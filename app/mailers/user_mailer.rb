class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def delete_notify(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Your profile has been erased from our site.')
  end

end
