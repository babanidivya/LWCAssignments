import { LightningElement, track, api, wire } from 'lwc';  
import getAccountsList from '@salesforce/apex/manageRecordsController.getAccountsList';  
import getAccountsCount from '@salesforce/apex/manageRecordsController.getAccountsCount';

/*eslint no-console: "error"*/
//import NAME_FIELD from '@salesforce/schema/Account.Name';
//import ID_FIELD from '@salesforce/schema/Account.Id';

   const COLS = [
       { label: 'Name', fieldName: 'Name', editable: true}
   ];

export default class LwcCustomTable extends LightningElement {  
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
  handleClick(event){
    /*console.log(event);
    console.log(event.target.dataset.targetId);
    console.log(event.target.dataset);
    console.log(event.target);
    console.log(event.target.innerHTML);
    console.log(event.target.id);*/
    let el = (this.template.querySelectorAll('.custom-popover'));
    /*console.log(this.template.querySelectorAll('.custom-popover'));
    console.log(this.template.querySelectorAll('.custom-popover').length);*/
    el.forEach(e => { 
      e.style.display = 'none';
      console.log(e);
      //console.log(e.id);
      if( event.target.id === e.id ){
        e.style.display = 'block';
        console.log('done');
      }
    })
    
    console.log(this.template.querySelectorAll('.slds-col'));
    //let el1 = el.closest(".custom-popover");
    //el1.style.display = "block";
    //(event.target.dataset.targetId).classList.add('red');
    //console.log(component);
    //console.log(this.querySelector(".phone").closest(".custom-popover"));

  }
}