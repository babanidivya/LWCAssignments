@isTest
public class AnimalLocatorTest {
    @isTest static void testGetCallout(){
        // Create the mock response based on a static resource
        //StaticResourceCalloutMock AnimalLocatorMock = new StaticResourceCalloutMock();
        //AnimalLocatorMock.setStaticResource('GetAnimalResource');
        //AnimalLocatorMock.setStatusCode(200);
        //AnimalLocatorMock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        // Call method to test
        String animalName = AnimalLocator.getAnimalNameById(1);
        System.assertEquals('test', animalName,
          'true');
    }
}