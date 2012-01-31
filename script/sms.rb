require 'savon'

client = Savon::Client.new("http://qun.pku.edu.cn:8080/PKUMSG/services/sendSMS?wsdl")

client.wsdl.soap_actions

response = client.request(:send_sms) do
  soap.body = "<phone>18679811166</phone><sms>Hello!</sms>"
end

print response.body[:send_sms_response][:return]
