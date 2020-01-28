public class DailyLeadProcessor implements Schedulable{
    public void execute(SchedulableContext sct){
    	List<Lead> leadLst = [SELECT Id,LeadSource FROM Lead where LeadSource =: '' LIMIT 200];
        List<Lead> lstToUpdate = new List<Lead>();
        if(leadLst.size() > 0){
            
            for(Lead lstToFetch : leadLst){
                lstToFetch.LeadSource = 'Dreamforce';
            	lstToUpdate.add(lstToFetch);
            }
        }
        if(lstToUpdate.size() > 0){
            UPDATE lstToUpdate;
        }
    }
}