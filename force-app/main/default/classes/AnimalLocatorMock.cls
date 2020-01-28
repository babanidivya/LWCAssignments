@isTest
public class AnimalLocatorMock implements HttpCalloutMock{
	public HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"animal":{"id":2,"name":"test","eats":"test food","says":"cluck cluck"}}');
        response.setStatusCode(200);
        return response; 
    }
}