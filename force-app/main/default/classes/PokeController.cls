public with sharing class PokeController {
    @AuraEnabled(Cacheable=true)
    public static Pokemon__c[] getAllPokemons() {
        return [
            SELECT
                Id,
                Name,
                Height__c,
                Weight__c,
                Generation__c,
                Type__c,
                Photo_URL__c,
                PokeIndex__c
            FROM Pokemon__c
            WITH SECURITY_ENFORCED
            ORDER BY PokeIndex__c
            LIMIT 898
        ];
    }

    @AuraEnabled(Cacheable=true)
    public static Pokemon__c[] searchPokemons(String type, Integer generation, String searchTerm) {
        // Devuelve pk
        searchTerm = searchTerm.trim();
        
            if(searchTerm == '' && type == 'All' && generation == 0){
                return getAllPokemons();
                
            }

        searchTerm = '%' + searchTerm + '%';

        String query = 'SELECT Id, Name, Height__c, Weight__c, Generation__c, Type__c, Photo_URL__c, PokeIndex__c FROM Pokemon__c';

        if(searchTerm != ''){
            query += ' WHERE Name LIKE :searchTerm ';
        } 
        if(type != 'All'){
            query += ' AND Type__c INCLUDES(:type) ';
        }
        if(generation != 0){
            query += ' AND Generation__c =:generation ';
        }
        query +=' ORDER BY PokeIndex__c';

        return Database.query(query);
    }
}