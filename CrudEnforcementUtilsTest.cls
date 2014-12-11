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
    
    Set<String> fields = new Set<String> { 'Taxable__c' };
    
    Promotion__c p = new Promotion__c();
    List<Promotion__c> pList = new List<Promotion__c>();
    
    System.runAs(testUser1) {
      System.assertEquals(false, CrudEnforcementUtils.canCreateObject(pList));
      System.assertEquals(false, CrudEnforcementUtils.canCreateObject(p));
      System.assertEquals(false, CrudEnforcementUtils.canUpdateObject(pList));
      System.assertEquals(false, CrudEnforcementUtils.canUpdateObject(p));
      System.assertEquals(false, CrudEnforcementUtils.canUpdateAllFields(
        pList, fields));
      System.assertEquals(false, CrudEnforcementUtils.canUpdateAllFields(
        p, fields));
      System.assertEquals(false, CrudEnforcementUtils.canCreateAllFields(
        pList, fields));
      System.assertEquals(false, CrudEnforcementUtils.canCreateAllFields(
        p, fields));
      System.assertEquals(false, CrudEnforcementUtils.canUpsertObject(pList));
      System.assertEquals(false,
        CrudEnforcementUtils.canUpsertObject(p));
    }
    
    System.runAs(testUser2) {
      System.assertEquals(true, CrudEnforcementUtils.canCreateObject(pList));
      System.assertEquals(true, CrudEnforcementUtils.canCreateObject(p));
      System.assertEquals(true, CrudEnforcementUtils.canUpdateObject(pList));
      System.assertEquals(true, CrudEnforcementUtils.canUpdateObject(p));
      System.assertEquals(true, CrudEnforcementUtils.canUpdateAllFields(
        pList, fields));
      System.assertEquals(true, CrudEnforcementUtils.canUpdateAllFields(
        p, fields));
      System.assertEquals(true, CrudEnforcementUtils.canCreateAllFields(
        pList, fields));
      System.assertEquals(true, CrudEnforcementUtils.canCreateAllFields(
        p, fields));
      System.assertEquals(true, CrudEnforcementUtils.canUpsertObject(pList));
      System.assertEquals(true,
        CrudEnforcementUtils.canUpsertObject(p));
      System.assertEquals(true, CrudEnforcementUtils.canUpsertAllFields(pList,
        fields));
      System.assertEquals(true,
        CrudEnforcementUtils.canUpsertAllFields(p, fields));
    }
    
    
    Test.stopTest();
  }
  
  private static void initTestData() {
    testUser1 = TestUtils.createStandardUser();
    insert testUser1;
    
    testUser2 = TestUtils.createStandardUser();
    insert testUser2;
    
    Id permissionSetId =
      TestUtils.getPermissionSetIdByName('BIW_Administrator');
    
    PermissionSetAssignment psa = new PermissionSetAssignment(
      PermissionSetId = permissionSetId,
      AssigneeId = testUser2.Id);
    insert psa;
  }
}