@isTest
public class AddPrimaryContactTest {
	@testSetup 
    static void setup() {
        List<Account> accountsOfNY = new List<Account>();
        // add a parent account
        //accountsOfNY.add(new Account(name='AccountNY',BillingState='NY'));
        // add 50 child accounts
        for (Integer i = 0; i < 50; i++) {
            accountsOfNY.add(new Account(
                name='AccountNY'+i,
                BillingState='NY'
            ));
        }
        insert accountsOfNY;
        List<Account> accountsOfCA = new List<Account>();
        // add a parent account
        //accountsOfNY.add(new Account(name='AccountNY',BillingState='NY'));
        // add 50 child accounts
        for (Integer i = 0; i < 50; i++) {
            accountsOfCA.add(new Account(
                name='AccountCA'+i,
                BillingState='CA'
            ));
        }
        insert accountsOfCA;
    }
    
    static testmethod void testQueueable() {
        // query for test data to pass to queueable class
        Contact conData = new Contact(
            							LastName='TestContactCA',
            							Designation__c='Developer',
            							Salary__c = 10000,
            							Preferred_Location__c = 'Ajmer'
        							 );
        String state = 'CA';
        // Create our Queueable instance
        AddPrimaryContact addConatct = new AddPrimaryContact(conData, state);
        // startTest/stopTest block to force async processes to run
        Test.startTest();        
        System.enqueueJob(addConatct);
        Test.stopTest();        
        // Validate the job ran. Check if record have correct parentId now
        System.assertEquals(50, [select count() from Contact where Account.BillingState = :'CA']);
    }
}