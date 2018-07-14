require 'selenium-webdriver'

class HomePage

  def initialize(driver)
    #selenium driver
    @driver = driver
    #"name for driver call" => {selenium symbol => "selector"}
    @locators = {
      "footer" => {:css => '.site-footer'},
      "about_link_text" => {:link_text => "About MailChimp"}
    }
  end

  def open
    @driver.get "https://mailchimp.com"
  end

  def follow_about_mailchimp_link
    #need to scroll down to bottom of page so the footer loads otherwise it errors
    @driver.find_element(@locators["footer"]).location_once_scrolled_into_view
    @driver.find_element(@locators["about_link_text"]).click
  end

end
