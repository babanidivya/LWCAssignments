/* eslint-disable no-console */
/**
* @author Divya Babani
* @date 26 Jan 2020
*
* 
*
* @description This is used to fetch user list and show it on component
*/
import { LightningElement, track, wire } from 'lwc';
import getUserList from '@salesforce/apex/ManageUserController.getUserList';  

export default class LwcContactsManagementScreen extends LightningElement {
    @track userList = [];
    @track userListToShow = [];
    @track searchKey = '';
    //filter list according to search keys : client side filtering
    handleKeyChange(event) { 
        if (this.searchKey !== event.target.value) {
            this.userListToShow = [];
            this.searchKey = event.target.value;
            if(this.userList != null && this.userList.length > 0){
                for (let valueUser of this.userList){
                    if((valueUser.Name != undefined && valueUser.Name 
                        && valueUser.Name.toUpperCase().indexOf(this.searchKey.toUpperCase()) != -1)){
                        this.userListToShow = [ ...this.userListToShow, valueUser ];
                    }
                }
            }
        } 
    } 
    
    //get all user from controller at once
    @wire (getUserList)
    wiredGetUserList({error, data }){
        if( data ){
            //let idx = 0;
            for( let valueUser of data ){
                this.userList = [ ...this.userList, valueUser ];
            }
            this.userListToShow = this.userList;
        }else if( error ){
            console.log(error);
        }
    }
}