public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer contNumToInsert,String contLastName){
    	List<Contact> conts = new List<Contact>(); 
        
        for(Integer i=0;i<contNumToInsert;i++){
            conts.add(new Contact(
                		FirstName = 'TestContact' + i,
                		LastName = contLastName
            		 ));
        }
        return conts;
    }
}