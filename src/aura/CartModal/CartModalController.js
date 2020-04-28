({
    handleCancel: function(component) {
        component.set('v.isActive', false);
    },
    createOrder: function(component, event){
        var account = component.get("v.AccId");
        var addedproductlist = component.get("v.ProductList");
        
        var action = component.get('c.CreateOrder');
        action.setParams({
            "productList" : addedproductlist,
            "accountId": account
        });
        $A.enqueueAction(action);
        alert("Order created");
    }
})