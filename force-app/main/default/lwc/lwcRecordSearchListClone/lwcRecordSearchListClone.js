import { LightningElement, track, api } from 'lwc';  
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
  
   @track accounts;  
   @track error;  
   @api currentpage;  
   @api pagesize;  
   @track searchKey;  
 /*@wire (getAccountsList,{ pagenumber: 1, 
       numberOfRecords: 10, 
       pageSize: 10, 
       searchString: 'a' } ) account2;*/
   totalpages;  
   localCurrentPage = null;  
   isSearchChangeExecuted = false;  
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
  renderedCallback() {   
    if (this.isSearchChangeExecuted && (this.localCurrentPage === this.currentpage)) {  
      return;  
    }  
    this.isSearchChangeExecuted = true;  
    this.localCurrentPage = this.currentpage;  
    getAccountsCount({ searchString: this.searchKey })  
      .then(recordsCount => {  
        this.totalrecords = recordsCount;  
        if (recordsCount !== 0 && !isNaN(recordsCount)) {  
          this.totalpages = Math.ceil(recordsCount / this.pagesize);  
          getAccountsList({ pagenumber: this.currentpage, numberOfRecords: recordsCount, pageSize: this.pagesize, searchString: this.searchKey })  
            .then(accountList => {  
              this.accounts = accountList;  
              this.error = undefined;  
            })  
            .catch(error => {  
              this.error = error;  
              this.accounts = undefined;  
            });  
        } else {  
          this.accounts = [];  
          this.totalpages = 1;  
          this.totalrecords = 0;  
        }  
        const event = new CustomEvent('recordsload', {  
          detail: recordsCount  
        });  
        this.dispatchEvent(event);  
      })  
      .catch(error => {  
        this.error = error;  
        this.totalrecords = undefined;  
      });  
  }  

  handleSave(event) {
     const recordInputs =  event.detail.draftValues.slice().map(draft => {
         const fields = Object.assign({}, draft);
         return { fields };
     }); 

     const promises = recordInputs.map(recordInput => updateRecord(recordInput));
     Promise.all(promises).then(accountList => {
       this.accounts = accountList;
         this.dispatchEvent(
             new ShowToastEvent({
                 title: 'Success',
                 message: 'Contacts updated',
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