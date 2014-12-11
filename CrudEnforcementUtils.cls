public with sharing class CrudEnforcementUtils {
  
  public static Boolean canUpsertObject(SObject templateObject) {
    if (templateObject == null) {
      return false;
    }
    
    return canCreateObject(templateObject) && canUpdateObject(templateObject);
  }
  
  public static Boolean canUpsertObject(List<SObject> templateObjects) {
    if (templateObjects == null) {
      return false;
    }
    
    return canCreateObject(templateObjects) && canUpdateObject(templateObjects);
  }
  
  public static Boolean canUpsertAllFields(SObject templateObjects,
      Set<String> fields) {
    if (templateObjects == null || fields == null || fields.isEmpty()) {
      return false;
    }
    
    return canCreateAllFields(templateObjects, fields) &&
      canUpdateAllFields(templateObjects, fields);
  }
  
  public static Boolean canUpsertAllFields(List<SObject> templateObjects,
      Set<String> fields) {
    if (templateObjects == null || fields == null || fields.isEmpty()) {
      return false;
    }
    
    return canCreateAllFields(templateObjects, fields) &&
      canUpdateAllFields(templateObjects, fields);
  }
  
  public static Boolean canCreateObject(SObject templateObject) {
    if (templateObject == null) {
      return false;
    }
    
    return canCreateObject(templateObject.getSObjectType());
  }
  
  public static Boolean canCreateObject(List<SObject> templateObjects) {
    if (templateObjects == null) {
      return false;
    }
    
    return canCreateObject(templateObjects.getSObjectType());
  }
  
  public static Boolean canUpdateObject(SObject templateObject) {
    if (templateObject == null) {
      return false;
    }
    
    return canUpdateObject(templateObject.getSObjectType());
  }
  
  public static Boolean canUpdateObject(List<SObject> templateObjects) {
    if (templateObjects == null) {
      return false;
    }
    
    return canUpdateObject(templateObjects.getSObjectType());
  }
  
  public static Boolean canCreateAllfields(SObject templateObject,
      Set<String> fields) {
    if (templateObject == null || fields == null || fields.isEmpty()) {
      return false;
    }
    
    return canCreateAllFields(templateObject.getSObjectType(), fields);
  }
  
  public static Boolean canCreateAllFields(List<SObject> tObjects,
      Set<String> fields) {
    if (tObjects == null || fields == null || fields.isEmpty()) {
      return false;
    }
    
    return canCreateAllFields(tObjects.getSObjectType(), fields);
  }
  
  public static Boolean canUpdateAllFields(List<SObject> tObjects,
      Set<String> fields) {
    if (tObjects == null || fields == null || fields.isEmpty()) {
      return false;
    }
    
    return canUpdateAllFields(tObjects.getSObjectType(), fields);
  }
  
  public static Boolean canUpdateAllFields(SObject templateObject,
      Set<String> fields) {
    if (templateObject == null || fields == null || fields.isEmpty()) {
      return false;
    }
    
    return canUpdateAllFields(templateObject.getSObjectType(), fields);
  }
  
  private static Boolean canCreateObject(Schema.SObjectType t) {
    return t.getDescribe().isCreateable();
  }
  
  private static Boolean canUpdateObject(Schema.SObjectType t) {
    return t.getDescribe().isUpdateable();
  }
  
  private static Boolean canCreateAllFields(Schema.SObjectType t,
      Set<String> fields) {
    Map<String,Schema.SObjectField> m =
      t.getDescribe().fields.getMap();
    
    for (String f : fields) {
      if (!m.get(f).getDescribe().isCreateable()) {
        return false;
      }
    }
    
    return true;
  }
  
  private static Boolean canUpdateAllFields(Schema.SObjectType t,
      Set<String> fields) {
    Map<String,Schema.SObjectField> m =
      t.getDescribe().fields.getMap();
    
    for (String f : fields) {
      if (!m.get(f).getDescribe().isUpdateable()) {
        return false;
      }
    }
    
    return true;
  }
}