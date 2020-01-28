public class AddPrimaryContact implements Queueable{
	private Contact contToCreate;
    private String stateOfAcc;
    
    public AddPrimaryContact(Contact con, String state) {
        this.contToCreate = con;
        this.stateOfAcc = state;
    }
    
    public void execute(QueueableContext context){
    	LIST<Account> accList = [SELECT Id, name FROM Account WHERE BillingState =: stateOfAcc LIMIT 200];
        LIST<Contact> conToInsert = new LIST<Contact>();
        for(Account acc : accList){
        	Contact con = contToCreate.clone();
            con.AccountId = acc.Id;
            conToInsert.add(con);
        }
        insert conToInsert;
    }
}