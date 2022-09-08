import { LightningElement } from 'lwc';

export default class ChildLwc extends LightningElement{
    handlePercentageChange(event){
        this.dispatchEvent(new CustomEvent('percent', {detail: event.target.value}));
    }
}