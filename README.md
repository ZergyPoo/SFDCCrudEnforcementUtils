# SFDCCrudEnforcementUtils

Hello! Welcome to Crud Enforcement Utils.

To install this package in your salesforce instance, follow these steps:

1. Install the Force.com Ant Migration Tool. (https://developer.salesforce.com/page/Force.com_Migration_Tool)

2. Clone this repository into a local directory.

3. Create a new file in the root directory of the repository called "build.properties"

4. Open the "build.properties" file in your favorite text editor.

Fill in this file with your salesforce credentials so that it looks like this:

```
sfdc.serverUrl=https://www.salesforce.com
sfdc.username=<your username>
sfdc.password=<your password><your security token>
```

5. Run "ant deploy" from the repository base directoy.

6. Enjoy!

To use Crud Enforcement:

To check insert permissions:

```
Set<String> accountFields = new Set<String> { 'Name' };

List<Account> accounts = new List<Account>();

accounts.add(new Account(
  Name = 'My Test Account'));

if (CrudEnforcementUtils.canCreateObjects(accounts) &&
    CrudEnforcementUtils.canCreateAllFields(accounts, accountFields)) {
  insert accounts;
}
```
