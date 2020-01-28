public class TestInsertTaskTriggerHandler {
    public static void insertBulkifyTask(List<Event> newEvent){
        if(newEvent.size()>0){
            Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
            Map <String, Schema.SObjectField> taskFieldMap = schemaMap.get('Task').getDescribe().fields.getMap();
            Map <String, Schema.SObjectField> eventFieldMap = schemaMap.get('Event').getDescribe().fields.getMap();
            List<Task> newTasks = new List<Task>();
            
            for (Event newEvt: newEvent){
                Task taskToCreate = new Task();
                for( String eventField : eventFieldMap.keySet() ){
                    if( taskFieldMap.containsKey( eventField ) && 
                       taskFieldMap.get( eventField ).getDescribe().isUpdateable() ){
                           taskToCreate.put( eventField ,newEvt.get( eventField ) );              
                       }
                }
                newTasks.add(taskToCreate);
            }
            insert newTasks; 
        }
    }
    
}