import { LightningElement, track, api, wire } from 'lwc';  
 import getAccountsList from '@salesforce/apex/manageRecordsController.getAccountsList';  
 import getAccountsCount from '@salesforce/apex/manageRecordsController.getAccountsCount';
 import { updateRecord } from 'lightning/uiRecordApi';
 import { refreshApex } from '@salesforce/apex';
 import { ShowToastEvent } from 'lightning/platformShowToastEvent';  
 
//import NAME_FIELD from '@salesforce/schema/Account.Name';
//import ID_FIELD from '@salesforce/schema/Account.Id';

    const COLS = [
        { label: 'Name', fieldName: 'Name', editable: true}
    ];

 export default class lwcRecordSearchList extends LightningElement {  
    @track columns = COLS;
   
    //@track accounts;  
    @track error;  
    @api currentpage;  
    @api pagesize;  
    @track searchKey = '';   
    //@track totalrecords;

    totalpages;  
    localCurrentPage = null;  
    isSearchChangeExecuted = false;
    defaultSearchString = '';  
   // not yet implemented  
   pageSizeOptions =  
     [  
       { label: '5', value: 5 },  
       { label: '10', value: 10 },  
       { label: '25', value: 25 },  
       { label: '50', value: 50 },  
       { label: 'All', value: '' },  
     ];
     
    handleKeyChange(event) {  
      if (this.searchKey !== event.target.value) {  
        this.isSearchChangeExecuted = false;  
        this.searchKey = event.target.value;
        this.currentpage = 1;  
      } 
    }  
   
    @wire (getAccountsList,{ pagenumber: '$currentpage', 
      numberOfRecords: '$totalrecords', 
      pageSize: '$pagesize', 
      searchString: '$searchKey'} ) accounts;
    renderedCallback() {   
     if (this.isSearchChangeExecuted && (this.localCurrentPage === this.currentpage)) {  
       return;  
     }  
     this.isSearchChangeExecuted = true;  
     this.localCurrentPage = this.currentpage;  
     getAccountsCount({ searchString: this.searchKey })  
       .then(recordsCount => {  
         this.totalrecords = recordsCount;  
         if (recordsCount !== 0 && !isNaN(recordsCount)){
          this.totalpages = Math.ceil(recordsCount / this.pagesize);
         }else{
          this.totalpages = 1;  
          this.totalrecords = 0; }
          const event = new CustomEvent('recordsload', {  
            detail: recordsCount  
          });  
          this.dispatchEvent(event); 
         });
         
   } 

   handleSave(event) {
      const recordInputs =  event.detail.draftValues.slice().map(draft => {
          const fields = Object.assign({}, draft);
          return { fields };
      }); 

      const promises = recordInputs.map(recordInput => updateRecord(recordInput));
      Promise.all(promises).then(() => {
       // this.accounts = accountList;
          this.dispatchEvent(
              new ShowToastEvent({
                  title: 'Success',
                  message: 'Account updated',
                  variant: 'success'
              })
          );
          // Clear all draft values
          this.draftValues = [];

          // Display fresh data in the datatable
          
          return refreshApex(this.accounts);
      }).catch(error => {
        this.error = error;
          // Handle error
      });
   }
 }