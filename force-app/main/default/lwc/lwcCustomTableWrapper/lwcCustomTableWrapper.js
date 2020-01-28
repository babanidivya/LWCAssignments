import { LightningElement, track, api, wire } from 'lwc';  
import getAllAccounts from '@salesforce/apex/manageRecordsController.getAllAccounts';  
import getAccountsCount from '@salesforce/apex/manageRecordsController.getAccountsCount';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { updateRecord } from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Contact.LastName';
import ID_FIELD from '@salesforce/schema/Contact.Id';
import { refreshApex } from '@salesforce/apex';

/*eslint no-console: "error"*/

   const COLS = [
       { label: 'Name', fieldName: 'Name', editable: true}
   ];

   let popoverValuesMap;
   let listOfObjects;
  
export default class LwcCustomTableWrapper extends LightningElement {  
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
  
   @wire (getAllAccounts,{ pagenumber: '$currentpage', 
     numberOfRecords: '$totalrecords', 
     pageSize: '$pagesize', 
     searchString: '$searchKey'} ) accountsWrapper;
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

   handleClick(event){
    popoverValuesMap = new Map();
    
    let indexOfString = event.target.id.indexOf("-");
    let elOrgId = event.target.id.slice(0, indexOfString)
    let el = (this.template.querySelectorAll('.custom-popover1'));
    el.forEach(e => { 
      e.style.display = 'none';
      let indexOfString1 = e.id.indexOf("-");
      let elOrgId1 = e.id.slice(0, indexOfString1);
      if( elOrgId === elOrgId1 ){
        e.style.display = 'block';
      }
    })
  }
  handlePopOverCancel(event){
    let indexOfString = event.target.id.indexOf("-");
    let elOrgId = event.target.id.slice(0, indexOfString)
    let el = (this.template.querySelectorAll('.custom-popover1'));
    el.forEach(e => { 
      e.style.display = 'none';
      let indexOfString1 = e.id.indexOf("-");
      let elOrgId1 = e.id.slice(0, indexOfString1);
      if( elOrgId === elOrgId1 ){
        e.style.display = 'none';
      }
    })
  }
  handlePopOverInput(event){
      listOfObjects = [];
      let singleObj = {};
      singleObj.inputId = event.target.id;
      singleObj.inputContactId = event.target.dataset.contactid;
      singleObj.inputContactName = event.target.value;
      singleObj.inputContactOldName = event.target.dataset.contactoldval;
      listOfObjects.push(singleObj);

      popoverValuesMap.set(event.target.id,listOfObjects);
  }
  updateContact(event) {
    let btnDataContactAccId = event.target.dataset.contactaccid;
    if(popoverValuesMap.size > 0){
      popoverValuesMap.forEach( this.logMapElements, this );
      
    }
    let el = (this.template.querySelectorAll('.custom-popover1'));
    el.forEach(e => {
      if( e.dataset.contactaccid === btnDataContactAccId ){
        e.style.display = 'none';
      }
    })
  }

  logMapElements(value, key, map, obj) {
    const allValid = true;
    value.forEach(ele => { 
      const fields = {};
      fields[ID_FIELD.fieldApiName] = ele.inputContactId;
      fields[NAME_FIELD.fieldApiName] = ele.inputContactName;
      const recordInput = { fields };
  
      updateRecord(recordInput)
          .then(() => {
            this.dispatchEvent(
              new ShowToastEvent({
                  title: 'Success',
                  message: 'Contact updated',
                  variant: 'success'
              })
            );  
           return refreshApex(this.accountsWrapper);
          })
          .catch(error => {
            this.dispatchEvent(
              new ShowToastEvent({
                  title: 'error creating record',
                  message: error.body.message,
                  variant: 'error'
              })
            );  
          });
    })
    
  }
  
}