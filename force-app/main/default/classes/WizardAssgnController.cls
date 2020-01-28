public class WizardAssgnController{
    public Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();

    public String pageName{get;set;}
    public String selectedParentObject {get; set;}

    public List<ObjectsListWrapper> objectsList{get;set;}
    public List<SelectOption> allFeild{get;set;}
    public List<SelectOption> selectedFeild{get;set;}
    public List<String> objnames{get;set;}
    
    public List<FieldListWrapper> fieldList{get;set;}
    
    public WizardAssgnController(){
        //allObjectList = schema.getGlobalDescribe();
        //objnames= new List<string>();
        //objnames.addAll(allObjectList.keySet());
        //objnames.sort();  
        objectsList = new List<ObjectsListWrapper>();
        fieldList = new List<FieldListWrapper>();
        allFeild = new List<SelectOption>();
        selectedFeild = new List<SelectOption>();
        
        for ( Schema.SObjectType obj : Schema.getGlobalDescribe().values()){
            ObjectsListWrapper OLW = new ObjectsListWrapper();
            Schema.DescribeSObjectResult objResult = obj.getDescribe();
            OLW.Label = objResult.getLabel();
            OLW.Name = objResult.getName();
            objectsList.add(OLW);
        }
    }
    
    public void getFieldListPage(){
        fieldList.clear();
        Map <String, Schema.SObjectField> fieldMap = schemaMap.get(selectedParentObject).getDescribe().fields.getMap();
        for(Schema.SObjectField sfield : fieldMap.Values())
        {
            schema.describefieldresult dfield = sfield.getDescribe();
            FieldListWrapper fListWrapObj = new FieldListWrapper ();
            fListWrapObj .fieldLabel= dfield.getLabel ();
            fListWrapObj .fieldAPIName= dfield.getname();
            fieldList.add(fListWrapObj );
            allFeild.add( new SelectOption(dfield.getname (),dfield.getLabel ()) );
        }

    }
       
    public class ObjectsListWrapper{
        public string Label{get;set;}
        public string Name{get;set;}
    }
    
    public class FieldListWrapper{
        public string fieldLabel{get;set;}
        public string fieldAPIName{get;set;}
    }
}