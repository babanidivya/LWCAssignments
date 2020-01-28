public class AccountController {

    public Account acc { get; set; }
    
    public AccountController() {
        this.acc = getAccount();
    }

    public List<Schema.FieldSetMember> getFields() {
        return SObjectType.Account.FieldSets.Builder_Sales_Representative.getFields();
    }
    public Map<String, Schema.FieldSet> getFieldSetMap() {
        return SObjectType.Account.FieldSets.getMap();
    }

    private Account getAccount() {
        String query = 'SELECT ';
        Map<String, Schema.FieldSet> fieldSetMap = getFieldSetMap();
        for(Schema.FieldSetMember f : fieldSetMap.get( 'Builder_Sales_Representative' ).getFields() ) {
            query += f.getFieldPath() + ', ';
        }
        for(Schema.FieldSetMember f : fieldSetMap.get( 'Builder_Company_Info' ).getFields() ) {
            query += f.getFieldPath() + ', ';
        }
        query += 'BillingState FROM Account LIMIT 1';
        return Database.query(query);
    }
    
    public void save(){
        
    }
}