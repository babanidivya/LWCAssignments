({
    checkValidation : function(component) {
        //Get Query Fields
        var urlCheck = component.get('v.url');
        var isValidURL = this.urlRegExp(urlCheck);
        component.set('v.urlValid',isValidURL);
        component.set("v.errorMessage","Please check the component configuration, As the provided fields are not valid.");
        component.set("v.errorType","error");
    },
    urlRegExp: function(urlCheck){
        var regularExpression; 
        var re = new RegExp('^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$');
        return re.test( urlCheck );
    },
})