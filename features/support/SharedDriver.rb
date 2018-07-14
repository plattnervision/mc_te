require 'rspec'
require 'selenium-webdriver'

include Selenium

#Creating Remote WebDriver
browser = Selenium::WebDriver.for :chrome
#gotta share the state 

Before do
  @browser = browser
end
