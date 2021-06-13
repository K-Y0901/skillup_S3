class ApplicationMailer < ActionMailer::Base
  
  default from: 'from@example.com',
          bcc:      "sent@gmail.com",
          reply_to: "reply@gmail.com"
  layout 'mailer'
end




