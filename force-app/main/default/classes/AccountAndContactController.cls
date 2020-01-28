/**
Name        :
Author      :
Date        :
Description :Contact
*/
public class AccountAndContactController{
    //Instance Variable
    
    private Id accountId;
    public Account account{get;set;}
    //Constructor
    public AccountAndContactController(){
        //Get Id
        accountId = ApexPages.currentPage().getParameters().get('id');
        if( accountId  != NULL ){
            account = [SELECT Id,Name,Phone,BillingStreet,BillingCity,BillingState,Type,
                      (Select Id, Name, FirstName, LastName,Designation__c,FavGame__c,
                      BirthDate__c,Age__c,GmailId__c,Phone__c,Salary__c FROM Contacts) FROM Account
                         WHERE Id=:accountId];
        }else{
            account = new Account();
        }
    }
    public PageReference saveAccount(){
        List<Contact> contacts = new List<Contact>();
        System.debug( '###' + account );
        if( account.contacts != NULL && account.contacts.size() > 0 ){
            for( Contact con : account.contacts){
                contacts.add( con );
            }
        }
        
        UPSERT account;
        if( contacts != NULL && contacts.size() > 0 ){
            UPDATE contacts;
        }
        
        return new PageReference('/' + account.Id );
    }
    public PageReference cancel(){
        if( account.Id != NULL ){
            return new PageReference('/' + account.Id );
        }
        return new PageReference('/001' );
    }
}