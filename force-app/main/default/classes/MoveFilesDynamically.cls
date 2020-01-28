public class MoveFilesDynamically {
    public void filesToMove(Id contentDocId, Id targetFolderId){
        ContentDocumentLink doc = new ContentDocumentLink();
        doc.ContentDocumentId = contentDocId;
        doc.Visibility = 'AllUSers';
        doc.LinkedEntityId = '0587F000000kyzYQAQ';
        doc.ShareType ='I';
        INSERT doc;
        
        if(doc.id != null){
            ContentDocumentLink doc1 = new ContentDocumentLink();
            doc1.ContentDocumentId = contentDocId;
            doc1.Visibility = 'AllUSers';
            doc1.LinkedEntityId = '0587F000000kz0WQAQ';
            doc1.ShareType ='I';
            INSERT doc1;
            
            If(doc1.id != null){
                //doc.ShareType = 'V';
                //update doc;
            	//DELETE doc;
                ContentFolder contentFolderIds = [Select Id from ContentFolder where Name =: doc1.LinkedEntityId limit 1];
        		//ContentFolder contentFolderIds = [];
                if(contentFolderIds.id != null){
                    system.debug(contentFolderIds);
                    List<ContentFolderMember> contentFolderMemeberList = [SELECT Id, ParentContentFolderId, ChildRecordId FROM ContentFolderMember WHERE ParentContentFolderId=:contentFolderIds.id];    
                    system.debug(contentFolderMemeberList);
                    if(contentFolderMemeberList.size() > 0){
                         for(ContentFolderMember cfm: contentFolderMemeberList) {
                            cfm.ParentContentFolderId = targetFolderId;    
                         }
                        update contentFolderMemeberList;
                    }
                }
            }
        }
    }
}