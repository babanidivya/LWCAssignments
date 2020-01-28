Trigger AccountAddressTrigger on Account (before insert,before update) {
    for(Account ac : Trigger.new){
        if(ac.BillingPostalCode != NULL && ac.Match_Billing_Address__c == true){
            ac.ShippingPostalCode = ac.BillingPostalCode;
        }
    }
}