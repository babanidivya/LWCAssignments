public class accMonthCtrl {
    public Id accId {get;set;}
     public Id accIdd {get;set;}
   
    public String mon;
    
    public String getMonth() {
        if(accId!=NULL)
        return [select toLabel(test_list__c) from Account where Id =: accId].test_list__c;
        else if(accIdd!=NULL)
        return [select toLabel(lang__c) from Account where Id =: accIdd].lang__c;
        return null;
    }
    
    
}