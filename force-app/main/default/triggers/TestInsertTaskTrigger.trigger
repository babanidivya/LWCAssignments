trigger TestInsertTaskTrigger on Event (after insert) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
        	TestInsertTaskTriggerHandler.insertBulkifyTask(trigger.new);
        }
    }
}