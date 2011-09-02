Feature: Manage albums
    
  Scenario: Creating new album
    Given user with email:"Me@asd.aa" and password:"qweasd"
    When I sign in as "Me@asd.aa/qweasd"
    Then I should see "Photos"

    When I follow "Photos"
    Then I should be on the album list of user with email "Me@asd.aa"
    And I should see "New album"

    When I fill in "album_name" with "My new album name"
    And I press "Create"
    Then I should be on the album list of user with email "Me@asd.aa"
    And I should see "My new album name"

  Scenario: Deleting my album
    Given user with email:"Me@asd.aa" and password:"qweasd"
    And user with email "Me@asd.aa" has album "My existing album"
    When I sign in as "Me@asd.aa/qweasd"
    And I go to the album list of user with email "Me@asd.aa"
    Then I should see "My existing album"
    And I should see "Delete"

    When I follow "Delete"
    Then I should be on the album list of user with email "Me@asd.aa"
    And I should not see "My existing album"

  Scenario: Viewing others albums
    Given the following users:
      | email         | password | firstname | lastname |
      | Johnny@qwe.aa | 123123   | Johnny    | Walker   |
      | Jack@qwe.aa   | 123123   | Jack      | Daniels  |
    And user with email "Johnny@qwe.aa" has album "Johnny's album"
    When I sign in as "Jack@qwe.aa/123123"
    And I go to the album list of user with email "Johnny@qwe.aa"
    Then I should see "Johnny's album"
    And I should not see "Delete"
    And I should not see "New album"

  Scenario: Viewing the album
    Given the following users:
      | email         | password | firstname | lastname |
      | Johnny@qwe.aa | 123123   | Johnny    | Walker   |
      | Jack@qwe.aa   | 123123   | Jack      | Daniels  |
    And user with email "Johnny@qwe.aa" has album "Johnny's album"
    And user with email "Jack@qwe.aa" has album "Jack's album"
    When I sign in as "Jack@qwe.aa/123123"
    And I go to the album list of user with email "Jack@qwe.aa"
    Then I should see "Jack's album"
    And I should see "0 photos"

    When I follow "Jack's album"
    Then I should see "Jack's album"
    And I should see "Add photo"
    And I should see "Back to Jack's albums"

    When I go to the album "Johnny's album" of user with email "Johnny@qwe.aa"
    Then I should see "Johnny's album"
    And I should not see "Add photo"
    And I should see "Back to Johnny's albums"