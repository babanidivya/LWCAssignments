/**
*/
public class AccountExtensionController{
    
    public Account acc{get;set;}
    
    public AccountExtensionController(ApexPages.StandardController controller){
        acc = (Account)controller.getRecord();
    }
    
    public void saveDetails(){
        acc.Phone = '1111111111';
        UPSERT acc;
    }
}