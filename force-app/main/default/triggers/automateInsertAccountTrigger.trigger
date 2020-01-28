trigger automateInsertAccountTrigger on Candidate__c (before Insert,after Insert) {
    if(Trigger.isAfter){
        Map<Id,Account> mac = new Map<Id,Account>();
        Map<Id,String> managebroacc = new Map<ID,String>();
        Map<ID,Account> accManageBrok = new Map<ID,Account>();
        Map<ID,Contact> contactManageBrok = new Map<ID,Contact>();
        List<ID> successFirst = new List<ID>();
        List<ID> successSecond = new List<ID>();
        Database.SaveResult[] srList;
        Database.SaveResult[] secondSRList;
        if(Trigger.isInsert){
            for(Candidate__c can : Trigger.New){
                if(can.Brokerage__c != NULL){
                    String accountName = can.Brokerage__c;
                    Account ac = new Account(name=accountName);
                    //newAccounts.add(ac);
                    mac.put(can.id,ac);
                    system.debug('-====='+mac);
                    if(can.Manage_Broke__c != NULL){
                        String manageBrokAccName = can.Manage_Broke__c;
                        //Account ac1 = new Account(name=manageBrokAccName);
                        managebroacc.put(can.id,manageBrokAccName);
                    }
                }
            }
            if(mac.size()>0){
                List<Account> newAccounts = new List<Account>();
                for(Id canId : mac.keySet()){
                    newAccounts.add(mac.get(canId));
                }
                srList = Database.insert(newAccounts, false);
                //Database.insert(newAccounts, false);
                system.debug('................'+mac);
            }
            system.debug(srList);
            for (Database.SaveResult sr : srList) {
                if (sr.isSuccess()) {
                    successFirst.add(sr.getId());   
                }
            }
            if(managebroacc.size()>0){
                //List<Account> managBrokAccounts = new List<Account>();
                for(Id canId : managebroacc.keySet()){
                    if(mac.containsKey(canId)){
                        if(successFirst.contains(mac.get(canId).id)){
                            Account newAc = new Account(name = managebroacc.get(canId),
                                                 parentId = mac.get(canId).id
                                                );   
                            accManageBrok.put(canId,newAc);
                        }
                    } 
                }
                system.debug('manage brok'+managebroacc);
                system.debug('second account'+accManageBrok);
            }
            if(accManageBrok.size()>0){
                List<Account> secondAccounts = new List<Account>();
                for(Id canId : accManageBrok.keySet()){
                    secondAccounts.add(accManageBrok.get(canId));
                }
                secondSRList = Database.insert(secondAccounts, false);
                //Database.insert(newAccounts, false);
                system.debug('................'+mac);
            }
            system.debug('manage broke account'+accManageBrok);
            for (Database.SaveResult sr : secondSRList) {
                if (sr.isSuccess()) {
                    successSecond.add(sr.getId());   
                }
            }
            system.debug('second success'+successSecond);
            if(accManageBrok.size()>0){
                for(Id canId : accManageBrok.keySet()){
                    if(successSecond.contains(accManageBrok.get(canId).id)){
                        Contact newCon = new Contact(AccountId = accManageBrok.get(canId).id,
                                                    LastName  = accManageBrok.get(canId).Name,
                                                    Preferred_Location__c   = 'Ajmer',
                                                    Designation__c = 'Developer',
                                                    Salary__c = 23000
                                                );   
                            
                    }
                }
            }
            /*for (Database.SaveResult sr : srList) {
                system.debug(sr);
                if (sr.isSuccess()) {
                    if(managebroacc.size()>0){
                        system.debug(managebroacc);
                    }
                }
            }*/
        }
    }
}