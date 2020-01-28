@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
	@HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        // grab the accountId from the end of the URL
        LIST<String> urlArray = request.requestURI.split( '/' );
        String accountId = urlArray[ urlArray.size() - 2];
        Account result =  [SELECT Id,Name,(SELECT Contact.Id,Contact.Name
                           FROM Contacts) FROM Account WHERE Id = :accountId];
        return result;
    }
}