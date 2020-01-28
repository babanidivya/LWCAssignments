/**
*/
public class StandardSetControllerDemo{
    
    public List<Account> accountList{get;set;}
    public List<Account_Fields__c> fields{get;set;}
    
    public StandardSetControllerDemo(ApexPages.StandardSetController controller) {
        Set<Id> accountId = new Set<Id>();
        fields = getFields(); 
        
        for( Account acc : (List<Account>)controller.getSelected() ){
            accountId.add( acc.Id );
        }
        if( fields != NULL && fields.size() > 0 ){
            String query = 'SELECT Id';
            for( Account_Fields__c field : fields ){
                query += ', ' + field.Field_API_Name__c;
            }
            query += ' FROM Account WHERE Id IN: accountId';
            accountList = Database.query( query );
        }
        
    }

    public List<Account_Fields__c> getFields(){
        return [SELECT Id, Name, Field_API_Name__c FROM Account_Fields__c];
    }
    
}