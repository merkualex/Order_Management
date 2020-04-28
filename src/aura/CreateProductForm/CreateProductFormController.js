({
    createProduct: function(component, event, helper) {                   
        
        var validproduct = component.find('productform').reduce(function (valid, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return valid && inputCmp.get('v.validity').valid;
        }, true);
        if(validproduct){
            var newproduct = component.get("v.newProduct");
            var action = component.get("c.saveProduct");
            action.setParams({
                "product": newproduct
            });
            $A.enqueueAction(action); 
            component.set("v.newProduct",{ 'sobjectType': 'Product__c',
                                          'Name': '',
                                          'Price__c': 0,
                                          'Description__c': '',
                                          'Type__c': '',
                                          'Family__c': ''});
            alert("Product created, please update the page");
        }
    }
})