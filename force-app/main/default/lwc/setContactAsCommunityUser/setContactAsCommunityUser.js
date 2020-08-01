import { LightningElement, api, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import getContacts from '@salesforce/apex/SetContactAsCommunityUserController.getContacts';
import convertContactToUser from '@salesforce/apex/SetContactAsCommunityUserController.convertContactToUser';
import getExistingUsers from '@salesforce/apex/SetContactAsCommunityUserController.getExistingUsers';
import activateOrDeactivateUser from '@salesforce/apex/SetContactAsCommunityUserController.activateOrDeactivateUser';
import getCommunityUsersReportId from '@salesforce/apex/SetContactAsCommunityUserController.getCommunityUsersReportId';
import hasUserPermissions from '@salesforce/apex/SetContactAsCommunityUserController.hasUserPermissions';

const ACTIONS = [

    { label: 'Activate User', name: 'activate' },
    { label: 'Deactivate User', name: 'deactivate' },

];

const COLS = [
    
    { label: 'Name', fieldName: 'Name', type: 'text', editable: false, sortable: false },
    { label: 'Last login date', fieldName: 'LastLoginDate', type: 'date', editable: false, sortable: false },
    { label: 'Status', fieldName: 'IsActive', type: 'text', editable: false, sortable: false },
    { type: 'action',
        typeAttributes: { rowActions: ACTIONS },
    },    
    
];

export default class SetContactAsCommunityUser extends LightningElement {

    @api recordId;
    @api contacts = [];
    @api users = [];
    @api label = '';
    @api name = '';
    @api value = '';
    @api required;
    @api placeholder = '';
    @track currentRecordId;
    @track selectedContactName = '';
    @track selectedContactId = '';
    @track selectedContactEmail = '';
    @track columns = COLS;
    @track isLoading = false;
    @track usersFound = false;
    @track accountId = '';
    @track communityUsersReportId = '';
    @track enableAccessToComponent = false;
    initialized = false;

    connectedCallback() {
        this.currentRecordId = this.recordId;
        this.isLoading = true;

        hasUserPermissions()
        .then((data) => {
            this.enableAccessToComponent = data;
        })
        .catch(error => {
            console.log('Error in connectedCallback()');
            console.log(JSON.parse(JSON.stringify(error)));
            this.isLoading = false;
        });

        getContacts({privateFundId : this.currentRecordId})
        .then((data) => {
            this.contacts = data;
            let tempAccId;
            data.forEach(function(contact){
                tempAccId = contact.AccountId;
            });
            this.accountId = tempAccId;
            console.log('>>>> The account id here is ----> ' + this.accountId);
        })
        .catch(error => {
            console.log('Error in connectedCallback()');
            console.log(JSON.parse(JSON.stringify(error)));
            this.isLoading = false;
        });

        getExistingUsers({privateFundId : this.currentRecordId})
        .then((data) => {
            console.log('hello from getExistingUsers');
            this.users = this.normalizeFieldsOnData(data);
            this.isLoading = false;
            this.usersFound = this.users.length > 0 ? true : false;
        })
        .catch(error => {
            console.log('Error in connectedCallback()');
            console.log(JSON.parse(JSON.stringify(error)));
            console.log(error);
            this.isLoading = false;
        });            
        
        getCommunityUsersReportId()
        .then((data) => {
            this.communityUsersReportId = data;
        })
        .catch(error => {
            console.log('Error in connectedCallback()');
            console.log(JSON.parse(JSON.stringify(error)));
            console.log(error);
        });

    }

    renderedCallback() {
        if (this.enableAccessToComponent) {
            if (this.initialized) {
                return;
            }
            this.initialized = true;
            let listId = this.template.querySelector('datalist').id;
            this.template.querySelector("input").setAttribute("list", listId);
        }
        
    }

    handleChange(evt) {

        this.selectedContactName = evt.target.value;
        var tempId = '';
        var tempEmail = '';
        this.contacts.forEach(function(item) {
            if (item.Name == evt.target.value) {
                tempId = item.Id;
                tempEmail = item.Email;
            }
        });
        this.selectedContactId = tempId;
        this.selectedContactEmail = tempEmail;
        this.dispatchEvent(new CustomEvent('change', { bubbles: false, detail: { value: evt.target.value, target: this.name } }));
        
    }

    convertContact(evt){

        let isValid = true;
        if(this.selectedContactId === ''){
            isValid = false;
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'No contact selected', 
                    message: 'Please select a valid contact from the dropdown list before continue', 
                    variant: 'error'
                }),
            );
        }
        
        if ((this.selectedContactEmail === '' || this.selectedContactEmail == null) && this.selectedContactId != '') {
            isValid = false;
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Contact with no email', 
                    message: 'This contact can\'t be processed because it doesn\'t have an email. Add an email to this contact and try again', 
                    variant: 'error'
                }),
            );
        }

        if (isValid) {

            this.isLoading = true;
            convertContactToUser({contactId : this.selectedContactId})
            .then((data) => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: ' Community User Enabled', 
                        message: 'The contact ' + this.selectedContactName + ' was enabled as a Community User', 
                        variant: 'success'
                    }),
                );
                this.connectedCallback();
            })
            .catch(error => {
                this.isLoading = false;
                console.log('Error in connectedCallback()');
                console.log(JSON.parse(JSON.stringify(error)));
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error', 
                        message: 'An unexpected error has occured, please try again later or contact an administrator', 
                        variant: 'error'
                    }),
                );
            });
        }

    }

    normalizeFieldsOnData(data) {
        console.log('hello from normalizeFieldsOnData');
        let currentData = [];
        data.forEach((row) => {
            let rowData = {};
            rowData.Id = row.Id;
            rowData.Name = row.Name;
            rowData.Username = row.Username;
            rowData.LastLoginDate = row.LastLoginDate;
            rowData.IsActive = row.IsActive == true ? 'Active' : 'Deactivated';
            currentData.push(rowData);
        });
        return currentData;

    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const defaultRow = event.detail.row;
        const row = JSON.parse(JSON.stringify(defaultRow));
        
        let id;
        let property;
        for (property in row) {
            if (property === 'Id'){
                id = row[property];
            }
        }

        if (!this.enableAccessToComponent) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error', 
                    message: 'User doesn\'t have permissions to manage community users', 
                    variant: 'error'
                }),
            );            
        } else {
            switch (actionName) {
                case 'deactivate':
                    this.deactivateUser(row);
                    break;
                case 'activate':
                    this.activateUser(row);
                    break;
                default:
                    break;
            }
        }
        
    }

    deactivateUser(row){
        
        if (row.IsActive == 'Deactivated') {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error', 
                    message: 'This user has been already deactivated', 
                    variant: 'error'
                }),
            );
        } else {
            this.isLoading = true;
            activateOrDeactivateUser({userId : row.Id, option : 'Deactivate'})
            .then((data) => {
                this.connectedCallback();
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success', 
                        message: 'The user has been correctly deactivated', 
                        variant: 'success'
                    }),
                );
            })
            .catch(error => {
                this.isLoading = false;
                console.log('Error in connectedCallback()');
                console.log(JSON.parse(JSON.stringify(error)));
                this.isLoading = false;
            });
        }
    }

    activateUser(row){
        
        if (row.IsActive == 'Active') {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error', 
                    message: 'This user has been already activated', 
                    variant: 'error'
                }),
            );
        } else {
            this.isLoading = true;
            activateOrDeactivateUser({userId : row.Id, option : 'Activate'})
            .then((data) => {
                this.connectedCallback();
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success', 
                        message: 'The user has been correctly reactivated', 
                        variant: 'success'
                    }),
                );
            })
            .catch(error => {
                this.isLoading = false;
                console.log('Error in connectedCallback()');
                console.log(JSON.parse(JSON.stringify(error)));
                this.isLoading = false;
            });
        }
    }

    goToReport(){
                
        if(this.accountId !== '' && this.accountId != null){

            let finalUrl = window.location.origin + '/lightning/r/Report/' + this.communityUsersReportId + '/view?fv0=' + this.accountId;
            let tempLink = document.createElement('a');
            tempLink.style.display = 'none';
            document.body.appendChild(tempLink);
            tempLink.setAttribute('href', finalUrl);
            tempLink.setAttribute('target', '_blank');
            tempLink.click();

        }else{

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'No users to show', 
                    message: 'There are no users to show in the report for this account.', 
                    variant: 'info'
                }),
            );

        }
        
    }

}