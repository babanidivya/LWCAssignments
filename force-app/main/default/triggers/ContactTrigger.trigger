trigger ContactTrigger on Contact ( before Insert, before Update, before delete, after insert, after delete ) {
    
    if( Trigger.isBefore ){
        if( Trigger.isInsert || Trigger.isUpdate ){
            for( Contact con : Trigger.New ){
                if( con.Age__c != NULL && con.Age__c > 25 && con.isMarried__c == false ){
                    //con.addError('Person must be married if age is greater than 25');
                    con.isMarried__c = TRUE;
                } 
            }
        }
    }
    
}