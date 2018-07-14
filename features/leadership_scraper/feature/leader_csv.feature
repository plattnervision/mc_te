Feature: Retrieve a csv with the name, title, and bio of MailChimps leadership enter_last_name

Scenario: navigating to and exporting leaders
  Given I start on the homepage
  And I scroll to the footer and click the about link
  Then I am on the about page

Scenario: compiling leaders into a CSV
  Given I start on the about page
  When I click each leaders picture and copy their name, title, and bio
  When I add the leaders to a CSV And Save the file
  Then I should have a leadership.csv file in /mc_te
