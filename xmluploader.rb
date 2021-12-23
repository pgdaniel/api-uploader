require 'nokogiri'
require "uri"
require "net/http"
require 'httparty'
require 'pry'
require 'sidekiq'
require 'sidekiq/web'



class XmlUploader
  include Sidekiq::Worker

  def perform(node)
    #sleep how_long
    body_head = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<ODM CreationDateTime=\"2019-02-18T00:00:00\" FileOID=\"test\" FileType=\"Transactional\" ODMVersion=\"1.3\" xmlns=\"http://www.cdisc.org/ns/odm/v1.3\">\n"
    body = node.to_s

    tail = "\n</ODM>"
    body = body_head + body + tail
    
    #puts body

    #response = HTTParty.get('https://apellis.mdsol.com/RaveWebServices/WebService.aspx?PostODMClinicalData', {
    response = HTTParty.post('http://localhost:3000/patients', {
      headers: {
        "User-Agent" => "Httparty",
        "Content-type" => "text/xml",
        "Authorization" => "Basic QVBMX1JXUzpDb21wbGVtZW50MjAxOA==",
        "accept-encoding" => "identity",
        "Cookie" => "MedidataRave=!x2tynaQWn5+Oxvri2Sl1R94pFf6z5yULGz3cY6L/m5nuA/S3ueZYCIuqrSfAYx7lS96PNRdgibqUMok="
      },
      body: body
    })
  end
end

