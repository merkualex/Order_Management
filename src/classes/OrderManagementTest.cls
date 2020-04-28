@IsTest
public class OrderManagementTest {
	@IsTest static void testTotalQuantity(){
		List<Product__c> temp = new List<Product__c>
				{
				new Product__c(Name='Product1',Price__c = 100, Type__c ='Type1', Family__c = 'Family1'),
				new Product__c(Name='Product2',Price__c = 500, Type__c ='Type2', Family__c = 'Family5'),
				new Product__c(Name='Product3',Price__c = 300, Type__c ='Type3', Family__c = 'Family5')
				};
		integer count = OrderManagement.countTotalQuantity(temp);
		System.assertEquals(3,count);
	}

	@IsTest static void testTotalSum(){
		List<Product__c> temp = new List<Product__c>
				{
				new Product__c(Name='Test1',Price__c = 100, Type__c ='Type1', Family__c = 'Family1'),
				new Product__c(Name='Test2',Price__c = 500, Type__c ='Type2', Family__c = 'Family5'),
				new Product__c(Name='Test3',Price__c = 300, Type__c ='Type3', Family__c = 'Family5')
				};
		decimal sum = OrderManagement.countTotalSum(temp);
		System.assertEquals(900,sum);
	}

	@IsTest static void getUserSettingsTest(){
		User usrexpected = [SELECT Id, Name, IsManager__c  FROM User WHERE Id = : UserInfo.getUserId()];
		User user = OrderManagement.getUserSettings();

		System.assertEquals(usrexpected,user);
	}

	@IsTest static void CreateOrderTriggerTest(){
		List<Product__c> prdList = new List<Product__c>
				{
				new Product__c(Name='Test1',Price__c = 100, Type__c ='Type1', Family__c = 'Family1'),
				new Product__c(Name='Test2',Price__c = 500, Type__c ='Type2', Family__c = 'Family5'),
				new Product__c(Name='Test3',Price__c = 300, Type__c ='Type3', Family__c = 'Family5')
				};
		OrderManagement.CreateOrder(prdList, '0015I000002mbv7QAA');
		Order__c result = [select TotalProductCount__c, totalprice__c from order__c where accountid__c = '0015I000002mbv7QAA' ];

		System.assertEquals(3, result.TotalProductCount__c);
		System.assertEquals(900, result.totalprice__c);

	}

	@IsTest static void CreateOrderTest(){
		List<Product__c> prdList = new List<Product__c>
				{
				new Product__c(Name='Test1',Price__c = 100, Type__c ='Type1', Family__c = 'Family1'),
				new Product__c(Name='Test2',Price__c = 500, Type__c ='Type2', Family__c = 'Family5'),
				new Product__c(Name='Test3',Price__c = 300, Type__c ='Type3', Family__c = 'Family5')
				};
		OrderManagement.CreateOrder(prdList, '0015I000002mbv7QAA');

		List<Orderitem__c> orderItem = [select id from orderitem__c];


		System.assertEquals(prdList.size(), orderItem.size());

	}

	@IsTest static void CreateOrderItemTest(){
		List<Product__c> prdList = new List<Product__c>
				{
				new Product__c(Name='Test1',Price__c = 100, Type__c ='Type1', Family__c = 'Family1'),
				new Product__c(Name='Test2',Price__c = 500, Type__c ='Type2', Family__c = 'Family5'),
				new Product__c(Name='Test3',Price__c = 300, Type__c ='Type3', Family__c = 'Family5'),
				new Product__c(Name='Test4',Price__c = 300, Type__c ='Type3', Family__c = 'Family5')
				};
		OrderManagement.CreateOrder(prdList, '0015I000002mbv7QAA');

		Order__c order = [select id from order__c];
		id orderid = order.Id;
		List<Orderitem__c> orderItem = [select id from orderitem__c where orderid__c =: orderid ];


		System.assertEquals(4, orderItem.size());


	}

}