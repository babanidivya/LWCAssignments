public with sharing class manageRecordsController {
    @AuraEnabled(cacheable = true)  
    public static List<Account> getAccountsList(Integer pagenumber, Integer numberOfRecords, Integer pageSize, String searchString) {  
        String searchKey = '%' + searchString + '%';  
        String query = 'select id, Name, Phone from Account ';  
        if (searchString != null && searchString != '') {  
        query += ' where name like \'%' + searchString + '%\' ';  
        }  
        query += ' limit ' + pageSize + ' offset ' + (pageSize * (pagenumber - 1));  
        return Database.query(query);  
    }  
    @AuraEnabled(cacheable = true)  
    public static Integer getAccountsCount(String searchString) {  
        String query = 'select count() from Account ';  
        if (searchString != null && searchString != '') {  
        query += ' where name like \'%' + searchString + '%\' ';  
        }  
        return Database.countQuery(query);  
    }  
    @AuraEnabled(cacheable=true)
    public static List<DataTableWrapper> getAllAccounts(Integer pagenumber, Integer numberOfRecords, Integer pageSize, String searchString) {
        String searchKey = '%' + searchString + '%';  
        String query = 'select id, Name, Phone, (Select Id, Name from contacts) from Account ';  
        if (searchString != null && searchString != '') {  
        query += ' where name like \'%' + searchString + '%\' ';  
        }  
        query += ' limit ' + pageSize + ' offset ' + (pageSize * (pagenumber - 1));  
        //return Database.query(query);  
        List<Account> listAcc = Database.query(query);
        List<DataTableWrapper> response = new List<DataTableWrapper>();
        for(Account acc : listAcc){
            DataTableWrapper obj = new DataTableWrapper();
            obj.accId = acc.Id;
            obj.accName = acc.Name;
            obj.accPhone = acc.Phone;
            if(acc.contacts.size() > 0){
                obj.accConList = acc.contacts; 
                List<String> lstSrting = new List<String>();
                for(Contact con : acc.contacts)
                {
                    lstSrting.add(con.name);
                }
            obj.accCon = String.join(lstSrting, ',');
            }
            response.add(obj);
        }
        return response;
    }

    private class DataTableWrapper {
        @AuraEnabled
        public Id accId {get;set;}
        @AuraEnabled
        public String accName {get;set;}
        @AuraEnabled
        public String accPhone {get;set;}
        @AuraEnabled
        public String accCon {get;set;}
        @AuraEnabled
        public List<Contact> accConList{get;set;}
    }



}