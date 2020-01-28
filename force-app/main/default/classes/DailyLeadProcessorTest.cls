@isTest
public class DailyLeadProcessorTest {
	@testSetup 
    static void setup() {
        List<Lead> leadToInsert = new List<Lead>();
        // add 200 Lead with blank LeadSource
        for (Integer i=0;i<200;i++) {
            leadToInsert.add(new Lead(LastName='Lead '+i, 
                Status='Working - Contacted', Company='TestLead',LeadSource=''));
        }
        insert leadToInsert;
    }
    static testmethod void testScheduler() {
        DailyLeadProcessor dlp = new DailyLeadProcessor();
        String sch = '20 2 2 10 2 ?';
        Test.startTest();
        System.schedule('Test Scheduler',sch,dlp);
        Test.stopTest();
        System.assertEquals(200, [select Id from Lead where LeadSource = : 'Dreamforce'].size() );
    }
    
}