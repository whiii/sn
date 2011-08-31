Feature: Manage walls
  
  @javascript
  Scenario: Writing on my wall
    Given user with email:"Me@asd.aa" and password:"qweasd"
    When I sign in as "Me@asd.aa/qweasd"
    Then I should see "Wall"

    When I fill in "wall_message_input" with "My new wall message"
    And I press "Write"
    And I wait for 3 seconds
    Then I should see "My new wall message"

  @javascript
  Scenario: Writing on others wall
    Given user with email:"John@asd.aa" and password:"qweasd"
    And user with email:"Jack@asd.aa" and password:"qweasd"
    When I am in John's browser
    And I sign in as "John@asd.aa/qweasd"
    And I go to the profile page of user with email "Jack@asd.aa"
    And I fill in "wall_message_input" with "Hello from John"
    And I press "Write"
    And I wait for 3 seconds
    Then I should see "Hello from John"

    When I am in Jack's browser
    And I sign in as "Jack@asd.aa/qweasd"
    Then I should see "Hello from John"