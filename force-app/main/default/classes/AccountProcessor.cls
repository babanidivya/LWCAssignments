public class AccountProcessor {
	@future
    public static void countContacts(List<Id> AccountId){
    		
    	List<AggregateResult> conts = [Select AccountId,Count(Id) cnt from Contact Where AccountId IN :AccountId group by AccountId];
        List<Account> acc = new List<Account>();
        for(AggregateResult ar: conts){
            acc.add( new Account( Id = (Id)ar.get('AccountId'),
                    Number_of_Contacts__c = (Integer)ar.get('cnt') ) );
        }
        if(!acc.isEmpty()){
        	update acc;
    	}

    }

}