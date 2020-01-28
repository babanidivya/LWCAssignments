public class IntegrationDemoController {
	//Instance Variable
    
    private Id accountId;
    public Account account{get;set;}
    //Constructor
    public IntegrationDemoController(){
        //Get Id
        accountId = ApexPages.currentPage().getParameters().get('id');
        if( accountId  != NULL ){
            account = [SELECT Id,Name,Phone,BillingStreet,BillingCity,BillingState,Type
                      FROM Account
                         WHERE Id=:accountId];
        }else{
            account = new Account();
        }
    }
	public PageReference saveAccount(){
        UPSERT account;
        return new PageReference('/' + account.Id );
    }
    public void callbackAction(){
        String name = ApexPages.currentPage().getParameters().get('name');
        String phone =  ApexPages.currentPage().getParameters().get('phone');
        if(String.isNotBlank(name) && String.isNotBlank(phone)){
            account.name = name;
             account.phone = phone;
        	UPSERT account;    
        }
    }
}