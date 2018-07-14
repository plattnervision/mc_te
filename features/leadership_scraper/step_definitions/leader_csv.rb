Given("I start on the homepage") do
  @homepage = HomePage.new(@browser)
  @homepage.open
end

Given("I scroll to the footer and click the about link") do
  @homepage.follow_about_mailchimp_link
end

Then("I am on the about page") do
  matchurl = @browser.current_url
  expect(matchurl).to eq("https://mailchimp.com/about/")
end

Given("I start on the about page") do
  @about_page = AboutPage.new(@browser)
end

When("I click each leaders picture and copy their name, title, and bio") do
  @about_page.return_leader_info
  expect(@about_page.leaders.empty?).to eq(false)
end

When("I add the leaders to a CSV And Save the file") do
  CSV.open("leadership.csv", "wb") do |csv|
    # adds the attributes name on the first line of csv
    csv << @about_page.leaders.first.keys
    # iterates over and returns all leader info
    @about_page.leaders.each do |leader|
      csv << leader.values
    end
  end
end

Then("I should have a leadership.csv file in \/mc_te") do
  expect(File.file?("leadership.csv")).to eq(true)
end
