Feature: Manage contacts
  
  Scenario: Add friend
    Given the following users:
      | email         | password | firstname | lastname |
      | Johnny@qwe.aa | 123123   | Johnny    | Walker   |
      | Jack@qwe.aa   | 123123   | Jack      | Daniels  |
    When I am in Johnny's browser
    And I sign in as "Johnny@qwe.aa/123123"
    And I go to the profile page of user with email "Jack@qwe.aa"
    And I press "Invite to contacts"
    
    When I am in Jack's browser
    And I sign in as "Jack@qwe.aa/123123"
    And I follow "Contacts"
    Then I should see "1 new"

    When I follow "1 new"
    Then I should see "New contacts"
    And I should see "Johnny Walker"
    
    When I press "Add to contacts"
    And I go to the home page
    Then I should see "Johnny" 

    When I am in Johnny's browser
    And I go to the home page
    Then I should see "Jack" 

  Scenario: Remove friend
    Given the following users:
      | email         | password | firstname | lastname |
      | Johnny@qwe.aa | 123123   | Johnny    | Walker   |
      | Jack@qwe.aa   | 123123   | Jack      | Daniels  |
    And users "Johnny@qwe.aa" and "Jack@qwe.aa" are friends
    When I am in Johnny's browser
    And I sign in as "Johnny@qwe.aa/123123"
    And I go to the contacts list of user with email "Johnny@qwe.aa"
    Then I should see "Jack Daniels"

    When I press "Remove from contacts"
    And I go to the home page
    Then I should not see "Jack"
    
    When I am in Jack's browser
    And I sign in as "Jack@qwe.aa/123123"
    Then I should not see "Johnny"