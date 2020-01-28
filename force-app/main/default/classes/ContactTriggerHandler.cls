public Class ContactTriggerHandler{

    public static void createContact( List<Account> accounts ){
        List<Contact> con = new List<contact>();
            for(Account ac : accounts ){
                String fullName  = ac.Name;
                
                Contact c = new Contact(AccountId = ac.id,
                                        Preferred_Location__c   = 'Ajmer',
                                        Designation__c = 'Developer',
                                        Salary__c = 23000
                                       );
               
               if( String.isNotEmpty( fullName ) ){
                   if( fullName.contains(' ') ){
                       c.LastName = fullName.right( fullName.length() - fullName.lastIndexOf(' ') );
                       c.FirstName = fullName.left( fullName.lastIndexOf(' ') );
                   }
                   else{
                       c.LastName = fullName;
                   }
               }
               con.add(c);
          }
            if(!con.isEmpty()){
                insert con;
            }
    }

}