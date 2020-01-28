@isTest
public class SheduleInterviewEmailTest {
	@testSetup
    static void setup() {
        Account testAccount = new Account();
        testAccount.Name='Test Account' ;
        insert testAccount;

        List<Contact> conToInsert = new List<Contact>();
        // add 200 Lead with blank LeadSource
        for (Integer i=0;i<200;i++) {
            conToInsert.add(new Contact(FirstName='ConFirstName'+i,LastName='ConLastName '+i,Title='test',
                Designation__c='Developer', GmailId__c='decentdiyad@gmail.com',Accountid=testAccount.id));
        }
        insert conToInsert;
    }
    @isTest static void testScheduler() {
        sheduleintervieemail sie = new sheduleintervieemail();
        Test.startTest();
        ID batchprocessid = Database.executeBatch(sie);
        Test.stopTest();
        System.assertEquals(200, [select count() from Contact where Designation__c = 'Developer' AND Title = 'test']);
    }
}