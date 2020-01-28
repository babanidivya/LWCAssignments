trigger AutomateInsertContactTrigger on Account (after Insert, after Update) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            ContactTriggerHandler.createContact( Trigger.New );
        }
    }
}