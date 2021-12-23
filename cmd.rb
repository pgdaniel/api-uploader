require 'nokogiri'
require "uri"
require "net/http"
require 'httparty'
require 'pry'
require 'sidekiq'
require_relative 'xmluploader'

doc = File.open("extracted.xml") { |f| Nokogiri::XML(f) }

 doc.xpath("//ClinicalData").each do |node|
   attr = node.attribute("StudyOID")
   attr.value = attr.value.tr('-', '_')

   if node.xpath('//StudyEventData//FormData').attribute("FormOID").value == 'APP_SPOTLIGHT'
     XmlUploader.perform_async(node)
   else
     puts "NOT APP SPOTLIGHT"
   end
 end
