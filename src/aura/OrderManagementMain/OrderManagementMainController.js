({
    handleOpenCart: function(component) {
        var action=component.get('c.countTotalSum');
        action.setParams({
            "productList" : component.get("v.addedProducts")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.totalSum", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
        component.set('v.showCart', true);
    },
    handleAddProductEvent: function(component, event){
        var productIdToAdd = event.getParam("ProductId");
        var addedproductlist = component.get("v.addedProducts");
        component.set("v.ProductId", productIdToAdd);
        var action=component.get('c.addtoCart');
        action.setParams({
            "productid" : productIdToAdd,
            "cart": addedproductlist
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            var response = response.getReturnValue();
            if(state==="SUCCESS")
            {
                component.set("v.addedProducts",response);
            }
        });
        $A.enqueueAction(action);  
    },
    
    showAddProductForm: function(component, event, helper){
          var check = component.get('v.showAddProductForm');
          if(!check){
              component.set('v.showAddProductForm', true);
          }else{
              component.set('v.showAddProductForm', false);
          }
        }
})