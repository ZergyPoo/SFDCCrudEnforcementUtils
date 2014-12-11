@isTest
public with sharing class TestUtils {

  private static Integer uniqueNumber = 0;
  private static Profile standardProfile;
  private static Profile sysAdminProfile;

  public static User createSystemAdministrator() {
    if (sysAdminProfile == null) {
      querySystemAdminProfile();
    }

    return new User(
      FirstName = 'TestStandard',
      LastName = 'TestUser',
      Email = 'test@test.com',
      Username = 'test@test' + String.valueOf(Math.random() * 100) + '.com',
      Alias = 'su',
      CommunityNickname = 'su' + String.valueOf(Math.random() * 100),
      ProfileId = sysAdminProfile.Id,
      LocaleSidKey = 'en_US',
      LanguageLocaleKey = 'en_US',
      EmailEncodingKey = 'ISO-8859-1',
      TimeZoneSidKey = 'America/Los_Angeles');
  }

  public static User createStandardUser() {
    if (standardProfile == null) {
      queryStandardProfile();
    }

    return new User(
      FirstName = 'TestStandard',
      LastName = 'TestUser',
      Email = 'test@test.com',
      Username = 'test@test' + String.valueOf(Math.random() * 100) + '.com',
      Alias = 'su',
      CommunityNickname = 'su' + String.valueOf(Math.random() * 100),
      ProfileId = standardProfile.Id,
      LocaleSidKey = 'en_US',
      LanguageLocaleKey = 'en_US',
      EmailEncodingKey = 'ISO-8859-1',
      TimeZoneSidKey = 'America/Los_Angeles');
  }

  public static String getUnique() {
    return String.valueOf(uniqueNumber++) + '_' + System.now().millisecond();
  }

  private static void querySystemAdminProfile() {
    List<Profile> profiles;
    Set<String> profileNames =
      new Set<String>{'System Administrator'};

    profiles = [select Id, Name
                    from Profile
                    where Name in :profileNames
                    order by Name];

    sysAdminProfile = profiles[0];
  }

  private static void queryStandardProfile() {
    List<Profile> profiles;
    Set<String> profileNames =
      new Set<String>{'Standard User'};

    profiles = [select Id, Name
                    from Profile
                    where Name in :profileNames
                    order by Name];

    standardProfile = profiles[0];
  }
}
