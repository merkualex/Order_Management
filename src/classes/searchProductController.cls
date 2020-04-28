public class searchProductController {    
    @AuraEnabled
    public static List <Product__c> fetchAllProduct() {
        List <Product__c> returnList = new List <Product__c> ();
        List <Product__c> lstOfProduct = [select id, Name, Description__c, Type__c, Family__c, Price__c from Product__c];
        
        for (Product__c prd: lstOfProduct) {
            returnList.add(prd);
        }
        return returnList;
    }
    @AuraEnabled
    public static Product__c saveProduct(Product__c product) {
        upsert product;
        return product;
    }
    
    @AuraEnabled
    public static List <Product__c> filterProduct(String searchKeyWord, string ntype, string nfamily) {
        
        if(ntype==null)
            ntype='';
        if(nfamily==null)
            ntype='';
        if(searchKeyWord==null)
            searchKeyWord='';
        
        String typeKey = '%' + ntype + '%';
        String familyKey = '%' + nfamily + '%';
        String searchKey = '%' + searchKeyWord + '%';
        List <Product__c> returnList = new List <Product__c> ();
        List <Product__c> lstOfProduct = [select id, Name, Description__c, Price__c from Product__c where Name LIKE: searchKey and Type__c LIKE: typeKey and Family__c LIKE: familyKey];
        
        for (Product__c prd: lstOfProduct) {
            returnList.add(prd);
        }
        return returnList;
    }
    @AuraEnabled
    public static List<String> fetchProductTypes(List<Product__c> productList){
        
        Set<String> temp = new Set<String>();
        String[]types = new String[]{};
            
            for (Product__c t : productList){
                temp.add(t.Type__c);
            }
        types.addAll(temp);
        
        return types;
    }

    
    @AuraEnabled
    public static List<String> fetchProductFamilies(List<Product__c> productList){
        
        Set<String> temp = new Set<String>();
        String[]families = new String[]{};
            
            for (Product__c t : productList){
                temp.add(t.Family__c);
            }
        families.addAll(temp);
        
        return families;
    }
}