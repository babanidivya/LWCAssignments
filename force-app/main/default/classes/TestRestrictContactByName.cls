@isTest
public class TestRestrictContactByName {
    @isTest static void TestContactByLastName(){
        // Create an contact with last name INVALIDNAME
        Contact c=new Contact(
            FirstName='TestInvalid',
            LastName = 'INVALIDNAME',
            Email = 'email@gmail.com',
            Phone = '9743800309'); 
        Test.startTest();
        Database.SaveResult result = Database.insert(c, false);
        Test.stopTest();
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('The Last Name "'+c.LastName+'" is not allowed for DML',
                             result.getErrors()[0].getMessage());
    }
}