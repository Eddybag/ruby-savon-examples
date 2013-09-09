# Ruby Savon Examples

Working project to experiement with the Ruby [Savon](http://savonrb.com/) SOAP client.  [example01.rb](example01.rb) contains the example code.

Examples use salesforce SOAP endpoints.  You can find more information in the salesforce [SOAP API Developer's Guide](http://www.salesforce.com/us/developer/docs/api/index.htm)

Examples use Savon [Version 2](http://savonrb.com/version2/).  If not using Gemfile, please be sure to install the Savon version 2.

## Getting Started 

1. Set USERNAME and PASSWORD environment variables
2. Start local webserver to serve WSDL files.

```
python -m SimpleHTTPServer
```

NOTE: Change port in example01.rb if needed