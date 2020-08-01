declare module "@salesforce/apex/SetContactAsCommunityUserController.getContacts" {
  export default function getContacts(param: {privateFundId: any}): Promise<any>;
}
declare module "@salesforce/apex/SetContactAsCommunityUserController.getExistingUsers" {
  export default function getExistingUsers(param: {privateFundId: any}): Promise<any>;
}
declare module "@salesforce/apex/SetContactAsCommunityUserController.convertContactToUser" {
  export default function convertContactToUser(param: {contactId: any}): Promise<any>;
}
declare module "@salesforce/apex/SetContactAsCommunityUserController.activateOrDeactivateUser" {
  export default function activateOrDeactivateUser(param: {userId: any, option: any}): Promise<any>;
}
declare module "@salesforce/apex/SetContactAsCommunityUserController.getCommunityUsersReportId" {
  export default function getCommunityUsersReportId(): Promise<any>;
}
declare module "@salesforce/apex/SetContactAsCommunityUserController.hasUserPermissions" {
  export default function hasUserPermissions(): Promise<any>;
}
