require 'selenium-webdriver'

class AboutPage

  attr_reader :leaders

  def initialize(driver)
    @driver = driver
    @locators = {
      "bio_image" => {:class_name => "mb2"},
      "bio_view" => {:id => "bio_view"},
      "mailchimp_leaders" => {:css => ".col.span1of4.large-span1of3.small-span1of2.ptb3.mb3.align-left"},
      "bio_content_block" => {:css => ".col.span3of5.small-span1of1.top"},
      "bio_name" => {:css => ".col.span3of5.small-span1of1.top > h3"},
      "bio_title" => {:css => ".col.span3of5.small-span1of1.top > span"},
      "bio_desc" => {:css => ".col.span3of5.small-span1of1.top > p"}
    }
    @leaders = []
  end

  def wait_for
    Selenium::WebDriver::Wait.new(:timeout => 10).until {yield}
  end

  def open
    @driver.get "https://mailchimp.com/about"
  end

  def mailchimp_leaders
    @driver.find_elements(@locators["mailchimp_leaders"])
  end

  def add_to_leader_array(name, title, bio)
    leaders << {:name => name, :title => title, :bio => bio}
  end

  def return_leader_info
    leader_info(mailchimp_leaders)
  end

  private

  def leader_info(leaders)
    # retry limit so i don't blow the stack
    max_retries = 3
    retry_count = 0

    leaders.each {|bio|
      # make sure the bio element is actually there
      wait_for { bio.find_element(@locators["bio_image"])}
      begin
        # this kept randomly failing with an unknown error every 3rd or so run
        bio.click
      rescue Selenium::WebDriver::Error::UnknownError
        retry_count += 1
        retry if retry_count < max_retries
      ensure
        # always quit if i hit max retries
        if retry_count == max_retries
          @driver.quit
        end
      end
      # bio block moves dynamically based on which profile picture is clicked
      # need to wait for the block to move below each picture before trying to get text
      wait_for {bio.find_element(@locators["bio_view"])}

      wait_for {bio.find_element(@locators["bio_content_block"])}
      name = bio.find_element(@locators["bio_name"])
      wait_for {bio.find_element(@locators["bio_content_block"])}
      title = bio.find_element(@locators ["bio_title"])
      wait_for {bio.find_element(@locators["bio_content_block"])}
      desc = bio.find_element(@locators["bio_desc"])

      add_to_leader_array(name.text, title.text, desc.text)
    }
  end
end
