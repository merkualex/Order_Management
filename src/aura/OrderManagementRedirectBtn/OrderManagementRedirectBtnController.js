({
    doInit: function(component, event, helper) {
        
        var action = component.get("c.getAccount");        
        var accid = component.get("v.recordId");        
        action.setParams({"accid" : accid});
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.ac", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        
        $A.enqueueAction(action);
        
        var action = component.get("c.getUserSettings");
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.userSettings", response.getReturnValue());
            }
        });
        
        $A.enqueueAction(action);
        
    }, 
    goToCMP:function(component,event,helper){
        var evt = $A.get("e.force:navigateToComponent");      
        evt.setParams({
            componentDef:"c:OrderManagementMain",
            componentAttributes:{
                ac : component.get("v.ac"),
                userSettings : component.get("v.userSettings")
            }
        });
        
        evt.fire();
    }
})