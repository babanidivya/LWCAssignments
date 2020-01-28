global class LeadProcessor implements Database.Batchable<sObject>{
	global Integer recordsProcessed = 0;
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id,LeadSource FROM Lead');
    }
    global void execute(Database.BatchableContext bc,List<Lead> scope){
    	List<Lead> leadsToUpdate = new List<Lead>();
        for(Lead ld : scope){
            ld.LeadSource = 'Dreamforce';
            leadsToUpdate.add(ld);
            recordsProcessed = recordsProcessed + 1;
        }
        if(leadsToUpdate.size() > 0){
            update leadsToUpdate;
        }
    }
    global void finish(Database.BatchableContext bc){
    	System.debug(recordsProcessed);    
    }
}