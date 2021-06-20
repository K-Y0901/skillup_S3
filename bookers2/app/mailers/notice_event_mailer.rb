class NoticeEventMailer < ActionMailer::Base
    default :from => 'any_from_address@example.com'

    def notice_event_email(mail)
        @mail = mail
        mail( :to => @mail.users.email,
              :subject => 'Notice an Event' )
    end
end


