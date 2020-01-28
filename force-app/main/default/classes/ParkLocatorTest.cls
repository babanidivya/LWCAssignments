@isTest
private class ParkLocatorTest {
	@isTest static void testCallout() {              
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        // Call the method that invokes a callout
        String countryName = 'Japan';
        List<String> result = ParkLocator.country(countryName);
       List<String> acceptedOutput = new List<String>{'Shiretoko National Park', 'Oze National Park', 'Hakusan National Park'};
       // Verify that a fake result is returned
        System.assertEquals(acceptedOutput, result); 
    }
}