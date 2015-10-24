Feature: Sanity check.

  @api
  Scenario: Check front page
    Given I visit "/node"
     Then I should see "No front page content has been created yet."