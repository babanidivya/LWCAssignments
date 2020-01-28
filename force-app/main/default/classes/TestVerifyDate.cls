@isTest
public class TestVerifyDate {
    @isTest static void testLowerDate(){
        Date d1 = Date.today();
		Date d2= Date.newInstance(2019, 4, 29); 
      	VerifyDate.CheckDates(d1, d2); 
    }
    @isTest static void testHigherDate(){
        Date d1 = Date.today();
		Date d2= Date.newInstance(2019, 6, 13); 
      	VerifyDate.CheckDates(d1, d2); 
    }
    @isTest static void testValidDate(){
        Date d1 = Date.today();
		Date d2= Date.newInstance(2019, 5, 29); 
      	VerifyDate.CheckDates(d1, d2); 
    }
}