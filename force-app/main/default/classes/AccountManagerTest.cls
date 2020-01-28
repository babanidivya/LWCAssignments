@IsTest
public class AccountManagerTest {
    @isTest static void testGetAccountById(){
        Id recordId = createTestRecord();
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://diya95-311-dev-ed.my.salesforce.com/services/apexrest/Accounts/'
            + recordId+'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account thisAccount = AccountManager.getAccount();
        // Verify results
        System.assert(thisAccount != null);
        System.assertEquals('TestAccount', thisAccount.Name);
    }
    // Helper method
    static Id createTestRecord() {
        // Create test record
        Account accountTest = new Account(
            					Name = 'TestAccount'
            				   );
        insert accountTest;
        Contact contactTest = new Contact(
            								LastName = 'TestContact',
            								Designation__c = 'HR',
            								Preferred_Location__c = 'Ajmer',
            								Salary__c = 10000,
            								AccountId = accountTest.Id
        								  );
        insert contactTest;
        return accountTest.Id;
    }        
}