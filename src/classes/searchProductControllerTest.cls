@isTest
public class searchProductControllerTest {
    @IsTest static void TestFetchProductTypes(){
        List<Product__c> temp = new List<Product__c>
                {
                new Product__c(Name='Product1',Description__c='Desc1', Type__c ='Type1', Family__c = 'Family1'),
                new Product__c(Name='Product2',Description__c='Desc2', Type__c ='Type2', Family__c = 'Family5'),
                new Product__c(Name='Product3',Description__c='Desc3', Type__c ='Type3', Family__c = 'Family5'),
                new Product__c(Name='Product4',Description__c='Desc5', Type__c ='Type4', Family__c = 'Family4'),
                new Product__c(Name='Product5',Description__c='Desc6', Type__c ='Type3', Family__c = 'Family5')
                };
        List<String> stringList = searchProductController.fetchProductTypes(temp);

        List<String> expectedList = new List<String>{'Type1','Type2','Type3','Type4'};

        System.assertEquals(expectedList ,stringList);
    }
    
    @IsTest static void TestFetchProductFamilies(){
        List<Product__c> temp = new List<Product__c>
                {
                new Product__c(Name='Product1',Description__c='Desc1', Type__c ='Type1', Family__c = 'Family1'),
                new Product__c(Name='Product2',Description__c='Desc2', Type__c ='Type2', Family__c = 'Family5'),
                new Product__c(Name='Product3',Description__c='Desc3', Type__c ='Type3', Family__c = 'Family5'),
                new Product__c(Name='Product4',Description__c='Desc5', Type__c ='Type4', Family__c = 'Family4'),
                new Product__c(Name='Product5',Description__c='Desc6', Type__c ='Type3', Family__c = 'Family5')
                };
        List<String> stringList = searchProductController.fetchProductFamilies(temp);

        List<String> expectedList = new List<String>{'Family1','Family5','Family4'};

        System.assertEquals(expectedList ,stringList);
    }
    
    @IsTest static void fetchAllProductTest(){
        List<Product__c> expected = [select id, Name, Description__c, Type__c, Family__c, Price__c from Product__c];
        List<Product__c> productList = searchProductController.fetchAllProduct();           
        System.assertEquals(expected , productList);  
    }
    
    @IsTest static void filterProductTest(){
        
        List <Product__c> lstOfProduct = [select id, Name, Description__c, Price__c from Product__c];
        List<Product__c> productList = searchProductController.filterProduct('', '', '');
        
        System.assertEquals(lstOfProduct , productList);        
    }

    @IsTest static void filterProductTestUsingKeyWord(){

        List<Product__c> temp = new List<Product__c>
                {
                new Product__c(Name='Product15',Description__c='Desc1', Type__c ='Type1', Family__c = 'Family1'),
                new Product__c(Name='Product25',Description__c='Desc2', Type__c ='Type2', Family__c = 'Family5')
                };

        insert temp;

        List <Product__c> lstOfProduct = [select id, Name, Description__c, Price__c from Product__c where Name LIKE: 'Product15'];
        List<Product__c> productList = searchProductController.filterProduct('Product15', '', '');

        delete temp;

        System.assertEquals(lstOfProduct , productList);


    }



}