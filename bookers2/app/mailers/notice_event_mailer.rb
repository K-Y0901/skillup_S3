class NoticeEventMailer < ActionMailer::Base
    default :from => 'any_from_address@example.com'

    def notice_event_email(mailing)
        @mailing = mailing
        mail( :to => @mailing.user.email,
              :subject => 'Notice an Event' )
    end
end


