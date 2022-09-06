import { LightningElement, api } from 'lwc';

export default class ChildWebComponent extends LightningElement{
    displayName = 'World';
    
    @api updateDisplayName(){
        var inp = this.template.querySelector("lightning-input");
        this.displayName = inp.value;
    }
}