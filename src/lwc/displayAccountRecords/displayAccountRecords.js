import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/GetRecordsForLWC.getAccount';

export default class DisplayAccountRecords extends LightningElement{
    cols = [{label:'Name', fieldName: 'Name'}, {label:'Status', fieldName: 'Status__c'}, {label:'Phone', fieldName: 'Phone'}];

    listAcc;

    @wire(getAccounts) wiredAccounts({data,error}){
        if(data){
            this.listAcc = data;
        }
        else if(error){
            this.listAcc = error;
        }
    }
}