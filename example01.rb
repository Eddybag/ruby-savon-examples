# *** NOTES ***
# * This only works with Savon 2 (not 1 or 3) - gem 'savon', '~> 2.0'
# * Start local webserver in current directory to serve up WSDLs
require 'bundler/setup'
require 'savon'
require 'open-uri'
require 'pp'

USERNAME = ENV['USERNAME']
PASSWORD = ENV['PASSWORD']

wsdl_url = 'http://localhost:12764/partner.wsdl'
client = Savon::Client.new(wsdl: wsdl_url)

# login
response = client.call(:login, message: {username: USERNAME, password: PASSWORD})
server_url = response.body[:login_response][:result][:server_url]
session_id = response.body[:login_response][:result][:session_id]

# set endpoint and sessionid for client
client.globals[:endpoint] = server_url
client.globals[:soap_header] = {'ins0:SessionHeader' => {'ins0:sessionId' => session_id }}

# test query/soql
response = client.call(:query, message: {query: 'select id, name from account limit 5'})

# apex ws
apex_wsdl_url = 'http://localhost:12764/apex.wsdl'
ac = Savon::Client.new(wsdl: apex_wsdl_url)
ac.globals[:soap_header] = {'tns:SessionHeader' => {'tns:sessionId' => session_id }, 'tns:DebuggingInfo' => {'debugLog' => 'DEBUG'}, 'tns:DebuggingHeader' => {'debugLevel' => 'Debugonly', }, 'tns:LogInfo' => {'category' => 'All', 'level' => 'Debug'} }
response = ac.call(:execute_anonymous, message: {String: 'System.debugz(\'hello\\nworld\');'})
puts "\n\n\n\n"

if response.body[:execute_anonymous_response][:result][:success]
	pp response.header[:debugging_info][:debug_log].split("\n")
else
	pp response.body[:execute_anonymous_response][:result][:compile_problem]
end