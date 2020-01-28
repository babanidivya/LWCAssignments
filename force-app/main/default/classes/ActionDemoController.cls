public class ActionDemoController{

        
    public String var1{get;set;}
    public String var2{get;set;}
    private String var4;
    
    public List<String> strList{get;set;}
    public List<SchoolWrapper> schools{get;set;}
    public Set<String> strSet{get;set;}
    public Map<String,String> strMap{get;set;}
    
    public String Var5{ 
                        get{ return 'var5';}
                        set;
                      }
    public String Var6{ 
                        get{ return Var6+ 'var5';}
                        set{ Var6 = value ;}
                      }
    
    public ActionDemoController(){
        var2 = 'var2';
        strList = new List<String>();
        strList.add('Diva');
        
        schools = new List<SchoolWrapper>();
        SchoolWrapper scl = new SchoolWrapper();
        scl.name = 'Nitin';
        scl.enrollNo = '12';
        schools.add( scl );
    }
    
    //Getter
    public String getVar3(){
        return 'var3';
    }
    
    public String getVar4() {
        return null;
    }

    
    //Setter
    public void setVar4( String var4 ){
       this.var4 = var4;
    }
    
    //actions
    public void changeValues(){
        var1 = 'T1';
        var2 = 'T2';
        var4 = 'T4';
    }
    
    public class SchoolWrapper{
        public string enrollNo{get;set;}
        public string name{get;set;}
    }
}