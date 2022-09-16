import { LightningElement, api, wire, track } from 'lwc';
 import { NavigationMixin } from 'lightning/navigation'; 
import getContacts from '@salesforce/apex/ContactTileForLwc.getContacts';
export default class TileContactRecords extends NavigationMixin(LightningElement) {
    
    @wire(getContacts) listContacts;
    @api flexipageRegionWidth;
    @track numberOfComponents;

    connectedCallback(){
        if(this.flexipageRegionWidth == "MEDIUM"){
            this.numberOfComponents = 3;
        }
        else if(this.flexipageRegionWidth == "SMALL"){
            this.numberOfComponents = 12;
        }
        else if(this.flexipageRegionWidth == "LARGE"){
            this.numberOfComponents = 2;
        }
    }

    handleClick(event){
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                objectApiName: 'Contact',
                recordId:event.target.name,
                actionName: 'view'
            }
        });
    }
}