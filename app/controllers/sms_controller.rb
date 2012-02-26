class SmsController < ApplicationController
  before_filter :authenticate_user!
  layout "form"

  def index
    @group = Group.find(params[:id])
    authorize! :admin, @group
    @sms = @group.sms
  end

  def push
    @group = Group.find(params[:id])
    authorize! :admin, @group

    client = Savon::Client.new("http://qun.pku.edu.cn:8080/PKUMSG/services/sendSMS?wsdl")
    client.wsdl.soap_actions

    re = 1
    @group.members.each do |member|
      response = client.request(:send_sms) do
        soap.body = "<phone>#{member.phone}</phone><sms>#{params[:content]}</sms>"
      end
      re = response.body[:send_sms_response][:return]
    end

    Sms.create(:group_id => params[:id], 
               :content => params[:content], 
               :status => re)

    redirect_to sms_group_path
  end
end
