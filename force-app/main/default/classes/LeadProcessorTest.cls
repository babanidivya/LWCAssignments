@isTest
public class LeadProcessorTest {
	@testSetup
    static void setup() {
        List<Lead> insertLeadList = new List<Lead>();
        // insert 200 Leads
        for (Integer i=0;i<200;i++) {
            insertLeadList.add(new Lead(LastName='Lead '+i, 
                Status='Working - Contacted', Company='TestLead'));
        }
        insert insertLeadList;
    }
    
    @isTest static void testLeadBatchUpdate(){
        Test.startTest();
        LeadProcessor ldp = new LeadProcessor();
        Id batchId = Database.executeBatch(ldp);
        Test.stopTest();
        System.assertEquals(200, [select count() from Lead where Company  = 'TestLead']);
    }
}