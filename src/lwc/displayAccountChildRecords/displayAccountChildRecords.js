import { LightningElement } from 'lwc';
import getContact from '@salesforce/apex/AccountChildRecordsComponentHelper.getContact';
import getOpportunity from '@salesforce/apex/AccountChildRecordsComponentHelper.getOpportunity';
import getCase from '@salesforce/apex/AccountChildRecordsComponentHelper.getCase';

export default class DisplayAccountChildRecords extends LightningElement{
    colsConAndOpp = [{label:'Id', fieldName: 'Id'}, {label:'Name', fieldName: 'Name'}];
    colsCase = [{label:'Id', fieldName: 'Id'}, {label:'Case Number', fieldName: 'CaseNumber'}, {label:'Status', fieldName: 'Status'}];

    listCon;
    listOpp;
    listCase;
    idForAccount = '0015i00000POtrpAAD';

    connectedCallback(){
        this.displayRecords();
    }

    displayRecords(){
        getContact({
            accId : idForAccount
        })
        .then((resultCon) =>{
            this.listCon = resultCon;
            
            getOpportunity({
                accId : idForAccount
            })
            .then((resultOpp) =>{
                this.listOpp = resultOpp;

                getCase({
                    accId : idForAccount
                })
                .then((resultCase) =>{
                    this.listCase = resultCase;
                })
                .catch((error => {
                    this.listCase = error;
                }));
            })
            .catch((error => {
                this.listOpp = error;
            }));
        })
        .catch((error => {
            this.listCon = error;
        }));
    }
}