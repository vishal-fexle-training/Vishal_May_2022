import { LightningElement, wire} from 'lwc';
import getTextMethod1 from '@salesforce/apex/ConnectedCallBackExample.getTextMethod1';
import getTextMethod2 from '@salesforce/apex/ConnectedCallBackExample.getTextMethod2';
import getTextMethod3 from '@salesforce/apex/ConnectedCallBackExample.getTextMethod3';

export default class MethodCalling extends LightningElement{
    
    //1
    m1;
    m2;
    m3;

    @wire(getTextMethod1) wiredMethod1({data,error}){
        if(data){
            this.m1 = data;
        }
        else if(error){
            this.m1 = error;
        }
    }

    @wire(getTextMethod2) wiredMethod2({data,error}){
        if(data){
            this.m2 = data;
        }
        else if(error){
            this.m2 = error;
        }
    }

    @wire(getTextMethod3) wiredMethod3({data,error}){
        if(data){
            this.m3 = data;
        }
        else if(error){
            this.m3 = error;
        }
    }

    //2
    m4;
    m5;
    m6;

    @wire(getTextMethod1) wiredMethod4({data,error}){
        if(data){
            this.m4 = data;
        }
        else if(error){
            this.m4 = error;
        }
    }

    @wire(getTextMethod2) wiredMethod5({data,error}){
        if(data){
            this.m5 = this.m4 +' '+ data;
        }
        else if(error){
            this.m5 = error;
        }
    }

    @wire(getTextMethod3) wiredMethod6({data,error}){
        if(data){
            this.m6 = this.m5 +' '+ data;
        }
        else if(error){
            this.m5 = error;
        }
    }
    

    //3
    m7;
    m8;
    m9;
    connectedCallback(){
        this.callApexMethods();
    }

    callApexMethods(){
        getTextMethod1()
        .then((result1) =>{
            this.m7 = result1;

            getTextMethod2()
            .then((result2) =>{
                this.m8 = result1 +' '+result2;

                getTextMethod3()
                .then((result3) =>{
                    this.m9 = result1 +' '+result2+' '+result3;
                })
            })
        })
    }
}