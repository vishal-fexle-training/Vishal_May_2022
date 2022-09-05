import { LightningElement} from 'lwc';

export default class HelloInput extends LightningElement {
    displayName = "World";

    handleClick(event) {
        var inp=this.template.querySelector("lightning-input");
        this.displayName=inp.value;
    }
}