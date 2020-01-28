public class BatchActive implements Database.Batchable<sObject>{
	public Date startDate;
    public Date endDate;
    public BatchActive(Date start_Date, Date end_Date) {
        startDate = start_Date;
        endDate = end_Date;
    }
    public Database.QueryLocator start(Database.BatchableContext BC){
        if(startDate != null && endDate != null){
            return Database.getQueryLocator('Select id from Course__c where Start_Date__c <=: startDate AND  End_Date__c >=: endDate');    
        }
        return null;
    }
    public void execute(Database.BatchableContext BC, List<Course__c> courseList){
        if(!courseList.isEmpty() ){
            List<Course__c> courseToUpdate = new List<Course__c>();
            for (Course__c course : courseList){
            	course.Active__c = true;  
                courseToUpdate.add(course);
            }
            if(!courseToUpdate.isEmpty()){
                update courseToUpdate;
            }
        }
        
    }
    public void finish(Database.BatchableContext BC) {
        System.debug('Finish');    
    }
}