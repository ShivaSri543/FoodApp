public class FoodAppController{   

    Public Food_Properties__c foodpro {get;set;}
    
    public String snapshot_attachment { get; set; }

    public Boolean openPanel{ get; set; }
    public Transient blob Attach {get;set;} 
     
    String CurrentId ;
    public PageReference Calculate() {
         foodpro = [select id,name,Calories__c,Weight__c from Food_Properties__c limit 1] ; 
         if(Attach != Null){
         Blob b = Attach;
         Attachment At = new Attachment(Name ='NewFile'+'.jpg',body = b,parentId= foodpro.id);
         insert At; 
         CurrentId  = At.Id; 
         // PageReference pg = new PageReference('/'+'0010K00001zj8gy');
         // pg.setRedirect(true);
         openPanel = true;
         }
         else{
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please Scan Product'));
         }
        return null; 
    }

    
    public Pagereference saveFile(){
        try{
            Food_Products__c FP = new Food_Products__c();
            fp.Product_Name__c = foodpro.Name;
            fp.Calories__c = foodpro.Calories__c;
            fp.Weight__c = foodpro.weight__c; 
            insert FP;
            
            Blob b = Attach;
            Attachment At1 = [Select id,name,body,ParentId from Attachment where Id=: CurrentId];
            Attachment Atnew = new Attachment();
            Atnew.ParentId = FP.ID;
            Atnew.Name = at1.name;
            Atnew.Body = at1.body;
            Insert Atnew; 
            
            FP.Product_Id__c = At1.id;
            update FP;
            
            PageReference pg = new PageReference('/'+FP.Id);
            pg.setRedirect(true);
            return pg;  
        }
        Catch(Exception ee){}
        return null;        
    }  
     public PageReference Cancel() {
        PageReference pg = new PageReference('/apex/FoodApp');
            pg.setRedirect(true);
            return pg;
    }
}