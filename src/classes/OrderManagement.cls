public class OrderManagement {
	@AuraEnabled
	public static Account getAccount(string accid){
		return [SELECT id, name, accountnumber FROM Account WHERE id=:accid ];
	}

	@AuraEnabled
	public static User getUserSettings(){
		User user = new User();
		user = [SELECT Id, Name, IsManager__c  FROM User WHERE Id = : UserInfo.getUserId()];
		return user;
	}

	@AuraEnabled
	public static List<Product__c> addtoCart(string productid, List<Product__c> cart){
		Product__c prd = new Product__c();
		prd = [SELECT id, name, Description__c, Price__c, Type__c, Family__c FROM Product__c WHERE id=:productid ];
		List<Product__c> updlist = cart;
		updlist.add(prd);
		return updlist;
	}

	@AuraEnabled
	public static Decimal countTotalSum (List<Product__c> productList){

		Decimal totalsum = 0;
		for (Product__c prd : productList){
			totalSum += prd.Price__c;
		}
		return totalSum;
	}


	@AuraEnabled
	public static Integer countTotalQuantity (List<Product__c> productList){
		return productList.size();
	}


	@AuraEnabled
	public static void CreateOrder(List<Product__c> productList, string accountId) {
		System.Debug('CreateOrderStart');

		Order__c order = new Order__c();
		order.AccountId__c = accountId;
		insert order;
		System.Debug('OrderInserted');

		Order__c orderid = [select id from Order__c WHERE TotalProductCount__c = null];
		List<OrderItem__c> orderItems = new List<OrderItem__c>();
		System.Debug('OrderITemsListCreated');

		for (Product__c prd : productList) {

			OrderItem__c orderItem = new OrderItem__c();
			System.Debug('OrderItem created');

			orderItem.OrderId__c = orderid.Id;
			orderItem.ProductId__c = prd.Id;
			orderItem.Price__c = prd.Price__c;
			orderItem.Quantity__c = 1;

			orderItems.add(orderItem);
			System.Debug('Add item to list');
		}

		insert orderItems;
		update order;
		System.Debug('Insert');
	}

}