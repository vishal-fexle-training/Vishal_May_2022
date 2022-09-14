import { LightningElement, wire } from "lwc";
import { publish, MessageContext } from "lightning/messageService";
import MY_MESSAGE_CHANNEL from "@salesforce/messageChannel/MyMessageChannel__c";

import TRAILHEAD_LOGO from '@salesforce/resourceUrl/trailhead_logo';

export default class PublisherComponent extends LightningElement {

    trailheadLogoUrl = TRAILHEAD_LOGO;
    @wire(MessageContext) messageContext;

    handleClick() {
        const messaage = {msg: "Sample Messaging Service"};
        publish(this.messageContext, MY_MESSAGE_CHANNEL, messaage);
    }
}