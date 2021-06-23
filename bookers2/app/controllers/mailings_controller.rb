class MailingsController < ApplicationController
    
    def new
        @mailing = Mailing.new
    end
    
    def create
        @mailing = Mailing.new(mailing_params)
        @mailing.user_id = current_user.id
        
       
        if @mailing.save
        
        NoticeEventMailer.notice_event_email(@mailing).deliver
        redirect_to mailing_path(@mailing)
        else
          @mailing = Mailing.new
          render :new
        end
    end
    
    def show
        @mailing = Mailing.find(params[:id])
    end
    
    private
    def mailing_params
      params.require(:mailing).permit(:title, :content)
    end
end
