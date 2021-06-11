class NoticeEventMailer < ApplicationMailer

    def notice_event_email(mail)
        @mail = mail
        mail( :to => @mail.users.email,
              :subject => 'Notice an Event' )
    end
end
