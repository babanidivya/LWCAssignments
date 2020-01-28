public class FieldSetController {
	public Map<String, Schema.FieldSet> getFieldSetMap() {
        return SObjectType.Account.FieldSets.getMap();
    }
}