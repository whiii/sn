Feature: Manage profiles
  
  Scenario: Editing profile with valid values
    Given user with email:"qwe@asd.aa" and password:"qweasd"
    When I sign in as "qwe@asd.aa/qweasd"
    Then I should see "Profile"

    When I follow "Profile"
    Then I should be on the edit profile page of user with email "qwe@asd.aa"

    When I fill in "Country" with "Some country"
    And I press "Update Profile"
    Then I should be on the profile page of user with email "qwe@asd.aa"
    And I should not see "error"
    And I should see "Some country"

  Scenario: Editing profile with invalid values
    Given user with email:"qwe@asd.aa" and password:"qweasd"
    When I sign in as "qwe@asd.aa/qweasd"
    Then I should see "Profile"

    When I follow "Profile"
    Then I should be on the edit profile page of user with email "qwe@asd.aa"

    When I fill in "Icq number" with "not an icq number"
    And I press "Update Profile"
    Then I should be on the profile page of user with email "qwe@asd.aa"
    And I should see "error"
    And I should see "Invalid ICQ UIN"

  @javascript
  Scenario: Updating status
    Given user with email:"John@asd.aa" and password:"qweasd"
    And user with email:"Jack@asd.aa" and password:"qweasd"
    And users "John@asd.aa" and "Jack@asd.aa" are friends
    When I am in John's browser
    And I sign in as "John@asd.aa/qweasd"
    And I click "#status_label"
    And I wait for 1 second
    Then I should see element with id "status_input"

    When I fill in "status_input" with "John's new status"
    And I unfocus "#status_input"
    And I wait for 3 seconds
    Then I should see "John's new status"

    When I am in Jack's browser
    And I sign in as "Jack@asd.aa/qweasd"
    Then I should see "John's new status"