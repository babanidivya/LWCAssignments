/**
    Name: OrgDetailController
    Author: Divya
    Date: 4/12/2018
*/
public class OrgDetailController{
    //Instance Variable   
    private Id accountId;
    public Account account{get;set;}
    public List<Contact> lst_con{get;set;}
    public List<Opportunity> lst_opp{get;set;}
    public List<Case> lst_case{get;set;}
    public List<String> accChildObj{get;set;}
    public Map<String,List<String>> accChildObjFields{get;set;}
    public List<String> AccountTabs{get;set;}
    public string accChildObjFieldsString{get;set;}

    public OrgDetailController(){
        //Id of accountId
        AccountTabs = new List<String>();
        accChildObj= new List<String>();
        accChildObjFields= new Map<String,List<String>>();
        
        accountId = ApexPages.currentPage().getParameters().get('id');
            if(accountID != NULL){
                account = [SELECT Name,Phone,BillingStreet,BillingCity,BillingState,BillingCountry,
                           ShippingStreet,ShippingCity,ShippingState,ShippingCountry 
                           FROM Account WHERE Id=:accountId];
                lst_con = [SELECT id,Name,Phone__c,Designation__c,Age__c,BirthDate__c,Salary__c 
                            FROM Contact where AccountId =: account.id];
                lst_opp = [SELECT id,Name,Account.Name,Type,StageName,LeadSource,CloseDate 
                           FROM Opportunity where AccountId =: account.id];
                lst_case = [SELECT id,Account.Name,Type,Reason,Status,Priority,Origin
                            FROM Case where AccountId =: account.id];
                AccountTabs.add('Contacts');
                AccountTabs.add('Opportunities');
                AccountTabs.add('Cases');
                
                accChildObj.add('Name');
                accChildObj.add('Phone__c');
                accChildObj.add('Designation__c');
                accChildObj.add('BirthDate__c');
                accChildObj.add('Age__c');
                accChildObj.add('Salary__c');
                
                accChildObjFields.put('Contacts',accChildObj);
                accChildObj= new List<String>();
                
                accChildObj.add('Name');
                accChildObj.add('Account.Name');
                accChildObj.add('Type');
                accChildObj.add('StageName');
                accChildObj.add('LeadSource');
                accChildObj.add('CloseDate');
                accChildObjFields.put('Opportunities',accChildObj);
                
                accChildObj= new List<String>();
                accChildObj.add('Account.Name');
                accChildObj.add('Type');
                accChildObj.add('Reason');
                accChildObj.add('Status');
                accChildObj.add('Priority');
                accChildObj.add('Origin');
                accChildObjFields.put('Cases',accChildObj);
                accChildObjFieldsString= string.valueof(accChildObjFields.keyset()).replace('{', '').replace('{', '');
            }
        
    }
}