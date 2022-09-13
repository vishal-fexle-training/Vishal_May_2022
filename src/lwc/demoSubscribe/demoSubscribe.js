import { LightningElement, wire } from "lwc";
import {subscribe, unsubscribe, MessageContext} from "lightning/messageService";
import MY_MESSAGE_CHANNEL from "@salesforce/messageChannel/MyMessageChannel__c";

export default class SubscriberComponent extends LightningElement {

  @wire(MessageContext)messageContext;
  receivedMessage;
  subscription = null;

  handleMessage(message){
      this.receivedMessage = message? JSON.stringify(message, null, "\t"): "no message";
  }
  
  handleSubscribe(){
      if (this.subscription){
          return;
      }

      this.subscription = subscribe(this.messageContext,MY_MESSAGE_CHANNEL,(message) => {
          this.handleMessage(message);
      });
  }

  handleUnsubscribe(){
      unsubscribe(this.subscription);
      this.subscription = null;
  }

  handleClear(){
      this.receivedMessage = null;
  }
}