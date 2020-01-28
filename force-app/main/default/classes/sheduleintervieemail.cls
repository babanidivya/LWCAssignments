global class sheduleintervieemail implements Database.Batchable<sObject>{
	//Variable Section
    global FINAL String strQuery;
    global List<String> errorMessages = new List<String>();
    global Integer recordsProcessed = 0;
    

    
    //Batch Start method
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT Id, Designation__c, GmailId__c FROM Contact WHERE Designation__c  = \'Developer\'');
    }

    //Batch Execute method calls findCostForWoD method
    global void execute(Database.BatchableContext BC, List<sObject> scopeList) {
        System.debug(LoggingLevel.INFO, '== scopeList size ==' + scopeList.size());
        
        List<Contact> conList = (List<Contact>) scopeList;
        if(!conList.isEmpty()) { 
            List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
            for (Contact prod : conList)
            {               
                
                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                LIST<EmailTemplate> emt = [SELECT Id FROM EmailTemplate 
                                     where DeveloperName = 'Test_Template_Sheduler_Interview'];
                String emailTemplateId = '';
                if(emt.size() > 0){
                	emailTemplateId = emt[0].Id;	   
                }
                String[] toAddresses = new String[] {prod.GmailId__c};
                Message.setToAddresses(toAddresses); 
                Message.SaveAsActivity = false;
                Message.setTemplateId(emailTemplateId);
                mailList.add(Message);
                 recordsProcessed = recordsProcessed + 1;
                
            }
            if(!mailList.isEmpty()) {
                try{
                    Messaging.sendEmail(mailList);
                }
                catch (Exception ex) {
                    errorMessages.add('Unable to send email to Tech: '+ ex.getStackTraceString());
                }
            }
        }
    }  

    //Batch Finish method for after execution of batch work
    global void finish(Database.BatchableContext BC) { 
        System.debug(recordsProcessed);    
    }
    
}