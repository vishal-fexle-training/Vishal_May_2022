import { LightningElement, api } from 'lwc';

export default class ParentLwc extends LightningElement{
    percentage = 50;
    barWidth = `width: ${this.percentage}%`;

    handleChangePercent(event){
        this.percentage = event.detail;
        this.barWidth = `width: ${this.percentage}%`;      
    }
}