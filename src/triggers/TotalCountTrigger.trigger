trigger TotalCountTrigger on Order__c (before update) {

	Id idorder;
    Decimal totalSum = 0;
	Decimal totalCount = 0;
    
	for (Order__c order : Trigger.new) {
		idorder = Trigger.oldMap.get(order.Id).Id;
	}    

	List<OrderItem__c> orderItemList = [select Price__C, Quantity__c from orderitem__c where OrderId__c =: idorder];
	
	for (OrderItem__c itm : orderItemList){
		totalSum += itm.Price__c;
		totalCount += itm.Quantity__c;
	}

	for (Order__c order : Trigger.new) {
		order.TotalPrice__c = totalSum;
		order.TotalProductCount__c = totalCount;
	}

}