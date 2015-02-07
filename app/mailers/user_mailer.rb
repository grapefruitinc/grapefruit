class UserMailer < ActionMailer::Base

  def tester
    @name = "Graham"
    @url = "http://graham.li"
    mail(to: "gramsey@me.com", subject: 'Test Grapefruit Message')
  end

end
