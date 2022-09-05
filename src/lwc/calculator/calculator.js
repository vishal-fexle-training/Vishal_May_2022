import { LightningElement, track } from 'lwc';

export default class Calculator extends LightningElement{
    answer;
    num1;
    num2;
    showNum1 = false;
    showNum2 = false;
    disableButton = true;

    handleInput(event) {
        const inputName = event.target.name;
  
        if(event.target.value != null && event.target.value != ''){
            if(inputName === 'firstNumber') {
                this.num1 = event.target.value;
                this.showNum1 = true;
            } else if(inputName === 'secondNumber') {
                this.num2 = event.target.value;
                this.showNum2 = true;
            }
        }
        else{
            this.showNum1 = false;
            this.showNum2 = false;
        }

        if(this.showNum1 && this.showNum2){
            this.disableButton = false;
        }
        else{
            this.disableButton = true;
        }
    }

    handleClick(event){
        const buttonName = event.target.label;

        if(!isNaN(this.num1) && !isNaN(this.num2)){
            if(buttonName === 'Add'){
                this.answer = parseInt(this.num1)+parseInt(this.num2);
            }
            else if(buttonName === 'Subtract'){
                this.answer = parseInt(this.num1)-parseInt(this.num2);
            }
            else if(buttonName === 'Multiply'){
                this.answer = parseInt(this.num1)*parseInt(this.num2);
            }
            else if(buttonName === 'Divide'){
                this.answer = parseInt(this.num1)/parseInt(this.num2);
            }
        }
    }    
}