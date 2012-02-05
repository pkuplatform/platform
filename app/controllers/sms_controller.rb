class SmsController < ApplicationController

  def index
    @group = Group.find(params[:id])
  end

  def push
    @group = Group.find(params[:id])

    client = Savon::Client.new("http://qun.pku.edu.cn:8080/PKUMSG/services/sendSMS?wsdl")
    client.wsdl.soap_actions

    @group.members.each do |member|
      response = client.request(:send_sms) do
        soap.body = "<phone>#{member.phone}</phone><sms>#{params[:content]}</sms>"
      end
      re = response.body[:send_sms_response][:return]
    end

    print "-----#{re}------"
    if status == 0
      Sms.create(:group_id => params[:group_id], :content => params[:content])
    end

    redirect_to sms_group_path
  end
end
