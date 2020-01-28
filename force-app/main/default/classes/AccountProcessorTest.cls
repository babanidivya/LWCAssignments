@isTest
public class AccountProcessorTest {
	@isTest static void TestAccountProcessor(){
        List<Id> accIds = new List<Id>();
        Account acc = new Account(Name='TestAccountNumberCon1');
        insert acc;
        accIds.add(acc.Id);
        Contact con = new Contact(FirstName = '1234cont',
                                  LastName = 'hello',
                                  Designation__c = 'Developer',
                                  Preferred_Location__c = 'Ajmer',
                                  Salary__c = 10000,
                                  AccountId = acc.Id
        						 );
        insert con;
        Test.startTest();
        AccountProcessor.countContacts(accIds);
        Test.stopTest();
        Account acc1 = [Select Id,Number_of_Contacts__c from Account where Id =: acc.Id];
        System.assertEquals(1,acc1.Number_of_Contacts__c);
    }
}