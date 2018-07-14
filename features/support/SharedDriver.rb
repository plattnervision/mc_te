require 'rspec'
require 'selenium-webdriver'

include Selenium

#Creating Remote WebDriver
browser = Selenium::WebDriver.for :chrome
#If you want to run it locally, use Watir::Browser.new :firefox

Before do
  @browser = browser
end
