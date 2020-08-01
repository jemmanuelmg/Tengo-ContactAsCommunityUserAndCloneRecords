import { LightningElement, api, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import cloneRecord from '@salesforce/apex/ClonePrivateFundRegistrationController.cloneRecord';

export default class ClonePrivateFundRegistration extends LightningElement {
    
    @api recordId;
    @track currentRecordId;
    @track isLoading = false;

    clonePrivateFundRegistration(event) {
        this.currentRecordId = this.recordId;
        this.isLoading = true;
        cloneRecord({privateFundId : this.currentRecordId})
        .then((data) => {
            this.isLoading = false;
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success', 
                    message: 'The record was successfully cloned', 
                    variant: 'success'
                }),
            );
            /*window.history.back();*/
            let finalUrl = window.location.origin + '/clientportal/s/cima-private-fund-registration-form?c__pfrId=' + data;
            let tempLink = document.createElement('a');
            tempLink.style.display = 'none';
            document.body.appendChild(tempLink);
            tempLink.setAttribute('href', finalUrl);
            tempLink.setAttribute('target', '_self');
            tempLink.click();
            
        })
        .catch(error => {
            this.isLoading = false;
            console.log('Error in connectedCallback()');
            console.log(JSON.parse(JSON.stringify(error)));
            this.isLoading = false;
        });

    }

}