({
    doInit: function(component, event, helper) {
        var action=component.get('c.fetchAllProduct');
        
        action.setCallback(this,function(response){
            var state = response.getState();
            var response = response.getReturnValue();
            if(state==="SUCCESS")
            {
                component.set("v.productListFull",response);
                component.set("v.productList",response);
            }
        });
        $A.enqueueAction(action);
        
    },
    
    filterproduct : function(component, event, helper) {
        
        var action=component.get('c.filterProduct');
        
        action.setParams({
            searchKeyWord : component.get("v.keywordHolder"),
            ntype: component.find("typeFilter").get("v.value"),
            nfamily: component.find("familyFilter").get("v.value")
            
        });
        
        action.setCallback(this,function(response){
            var state = response.getState();
            var response = response.getReturnValue();
            if(state==="SUCCESS")
            {
                component.set("v.productList",response);
            }
            
        });
        $A.enqueueAction(action);
        
    },

    fetchFilter: function(component, event, helper){
        var action=component.get('c.fetchProductTypes');
        action.setParams({
            productList : component.get("v.productListFull")
            
        });
        
        action.setCallback(this,function(response){
            var state = response.getState();
            var response = response.getReturnValue();
            if(state==="SUCCESS")
            {
                component.set("v.productTypes",response);
            }
            
        });
        $A.enqueueAction(action);
        
        var action=component.get('c.fetchProductFamilies');
        action.setParams({
            productList : component.get("v.productListFull")
            
        });
        
        action.setCallback(this,function(response){
            var state = response.getState();
            var response = response.getReturnValue();
            if(state==="SUCCESS")
            {
                component.set("v.productFamilies",response);
            }
            
        });
        $A.enqueueAction(action);
    },

    addToCart: function(component, event, helper){
      var productIdToAdd = event.getSource().get('v.value');
      var addToCartEvent = component.getEvent("addToCartEvent");
      addToCartEvent.setParams({"ProductId" : productIdToAdd});
      addToCartEvent.fire();
    },

    showdescription: function(component, event, helper){
          var desccheck = component.get('v.description');
          if(!desccheck){
              component.set('v.description', true);
          }else{
              component.set('v.description', false);
          }
        }
    
})