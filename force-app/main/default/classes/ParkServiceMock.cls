@isTest
global class ParkServiceMock implements WebServiceMock {
	global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
        // start - specify the response you want to send
        ParkService.byCountryResponse response_x = 
            new ParkService.byCountryResponse();
        LIST<String> parkList = new LIST<String>{'Shiretoko National Park', 'Oze National Park', 'Hakusan National Park'};
        response_x.return_x = parkList;
        // end
        response.put('response_x', response_x); 
   }
}