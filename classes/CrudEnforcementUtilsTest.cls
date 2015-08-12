@isTest
private class CrudEnforcementUtilsTest {

  private static User testUser1, testUser2;

  static testMethod void testCrudEnforcement() {
    initTestData();

    Test.startTest();

    SObject nullObject = null;
    List<SObject> nullList;

    System.assertEquals(false, CrudEnforcementUtils.canCreateObject(nullList));
    System.assertEquals(false,
      CrudEnforcementUtils.canCreateObject(nullObject));
    System.assertEquals(false, CrudEnforcementUtils.canUpsertObject(nullList));
    System.assertEquals(false,
      CrudEnforcementUtils.canUpsertObject(nullObject));
    System.assertEquals(false, CrudEnforcementUtils.canUpdateObject(nullList));
    System.assertEquals(false,
      CrudEnforcementUtils.canUpdateObject(nullObject));
    System.assertEquals(false, CrudEnforcementUtils.canCreateAllFields(
      nullList, null));
    System.assertEquals(false, CrudEnforcementUtils.canCreateAllFields(
      nullObject, null));
    System.assertEquals(false, CrudEnforcementUtils.canUpdateAllFields(
      nullList, null));
    System.assertEquals(false, CrudEnforcementUtils.canUpdateAllFields(
      nullObject, null));
    System.assertEquals(false, CrudEnforcementUtils.canUpsertAllFields(
      nullList, null));
    System.assertEquals(false, CrudEnforcementUtils.canUpsertAllFields(
      nullObject, null));

    Set<String> fields = new Set<String> { 'Name' };

    Account a = new Account();
    List<Account> aList = new List<Account>();

    System.runAs(testUser1) {
      System.assertEquals(false, CrudEnforcementUtils.canCreateObject(aList));
      System.assertEquals(false, CrudEnforcementUtils.canCreateObject(a));
      System.assertEquals(false, CrudEnforcementUtils.canUpdateObject(aList));
      System.assertEquals(false, CrudEnforcementUtils.canUpdateObject(a));
      System.assertEquals(false, CrudEnforcementUtils.canUpdateAllFields(
        aList, fields));
      System.assertEquals(false, CrudEnforcementUtils.canUpdateAllFields(
        a, fields));
      System.assertEquals(false, CrudEnforcementUtils.canCreateAllFields(
        aList, fields));
      System.assertEquals(false, CrudEnforcementUtils.canCreateAllFields(
        a, fields));
      System.assertEquals(false, CrudEnforcementUtils.canUpsertObject(aList));
      System.assertEquals(false,
        CrudEnforcementUtils.canUpsertObject(a));
    }

    System.runAs(testUser2) {
      System.assertEquals(true, CrudEnforcementUtils.canCreateObject(aList));
      System.assertEquals(true, CrudEnforcementUtils.canCreateObject(a));
      System.assertEquals(true, CrudEnforcementUtils.canUpdateObject(aList));
      System.assertEquals(true, CrudEnforcementUtils.canUpdateObject(a));
      System.assertEquals(true, CrudEnforcementUtils.canUpdateAllFields(
        aList, fields));
      System.assertEquals(true, CrudEnforcementUtils.canUpdateAllFields(
        a, fields));
      System.assertEquals(true, CrudEnforcementUtils.canCreateAllFields(
        aList, fields));
      System.assertEquals(true, CrudEnforcementUtils.canCreateAllFields(
        a, fields));
      System.assertEquals(true, CrudEnforcementUtils.canUpsertObject(aList));
      System.assertEquals(true,
        CrudEnforcementUtils.canUpsertObject(a));
      System.assertEquals(true, CrudEnforcementUtils.canUpsertAllFields(aList,
        fields));
      System.assertEquals(true,
        CrudEnforcementUtils.canUpsertAllFields(a, fields));
    }


    Test.stopTest();
  }

  private static void initTestData() {
    testUser1 = TestUtils.createStandardUser();
    insert testUser1;

    testUser2 = TestUtils.createSystemAdministrator();
    insert testUser2;
  }
}