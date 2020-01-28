public class AccountListController{
    public List<Account> acc_list {get;set;}
    //constructor
    public AccountListController(){
       acc_list = [SELECT id,name,phone,annualrevenue,numberofemployees from Account];
        
    }
    public PageReference save(){
        List<Database.UpsertResult> resultList = Database.Upsert(acc_list, false );
        for( Database.UpsertResult res : resultList ){
            System.debug('####' + res );
        }
        return null;
    }
}