@isTest
public with sharing class PokemonBatchTest {

    public static List<Pokemon__c> pkList = new List<Pokemon__c>();

    @isTest
    static void testGetAllPokemons() {
        
      List<Pokemon__c> pkPList = new List<Pokemon__c>();
      Test.startTest();
      pkPList = pokeController.getAllPokemons();
      Test.stopTest();
      
      try {
        System.assertEquals(pkPList[0].Name, 'Ho-oh', 'No coincide');
        System.assertEquals(pkPList[0].Photo_URL__c,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/250.png','No coincide');
        System.assertEquals(pkPList[0].Weight__c,'1990 lbs','No coincide el peso');
        System.assertEquals(pkPList[0].Height__c, '38 ft)', 'No coincide');
        System.assertEquals(pkPList[0].Generation__c,2,'No coincide la generacion');
        System.assertEquals(pkPList[0].Type__c,'Flying;Fire','No coincide el tipo');
        System.assertEquals(pkPList[0].PokeIndex__c,250,'No coincide el indice');
      } catch (Exception e) {
        System.debug('Sin Pokemons!');
      }
    }

    @isTest
    static void testFilter() {
        List<Pokemon__c> pkPList = new List<Pokemon__c>();
        String searchTerm = 'Entei';
        String type = 'Fire';
        Integer generation = 2;
        Test.startTest();
        pkPList = pokeController.searchPokemons(
            type,
            generation,
            searchTerm
        );
        Test.stopTest();

        try {
        System.assertEquals(pkPList[0].Name, 'Entei', 'No coincide');
        System.assertEquals(pkPList[0].Photo_URL__c,'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/244.png','La imagen no es la correcta');
        System.assertEquals(pkPList[0].Weight__c,'1980 lbs','No coincide el peso');
        System.assertEquals(pkPList[0].Height__c,'21 ft','No coincide la altura');
        System.assertEquals(pkPList[0].Generation__c,2,'No coincide la generacion');
        System.assertEquals(pkPList[0].Type__c,'Fire','No coincide el tipo');
        System.assertEquals(pkPList[0].PokeIndex__c,244,'No coincide el pokeindex');
        } catch (Exception e) {
            System.debug('Error en el filtro');
        }
    }

    @isTest
    static void PokemonTestGenOne() {
        pkList.add(new Pokemon__c(name ='https://pokeapi.co/api/v2/pokemon/1'));

        String body = '{"name": "charmander","height": 6,"weight": 85, "id": 5,"sprites":{"front_default": https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png}}';

        PokeMock fakeResponse = new PokeMock(200, 'Complete', body, null);

        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
            PokemonBatch Batch = new PokemonBatch(pkList);
            Database.executeBatch(Batch, 1);
        Test.stopTest();

        try {
            List<Pokemon__c> pkPList = [SELECT Name, Height__c, Weight__c, Photo_URL__c, Type__c, Generation__c, PokeIndex__c FROM Pokemon__c];

        System.assertEquals(pkPList[0].Name, 'Charmander', 'error');
        System.assertEquals(pkPList[0].Height__c, '6 ft');
        System.assertEquals(pkPList[0].Weight__c, '85 lbs');
        System.assertEquals(pkPList[0].Photo_URL__c, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png');
        System.assertEquals(pkPList[0].Type__c, 'fire');
        System.assertEquals(pkPList[0].Generation__c, 1);
        System.assertEquals(pkPList[0].PokeIndex__c, 4);
        } catch (Exception e) {
            System.debug('Error');
        }
    }

    @isTest 
    static void PokemonTestGenTwo(){
        pkList.add(new Pokemon__c(name = 'https://pokeapi.co/api/v2/pokemon/155'));

        String body = '{"name": "cyndaquil","height": 5,"weight": 79,"id": 155,"sprites":{"front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/155.png"}}';

        
        PokeMock fakeResponse = new PokeMock(200, 'Complete', body, null);

        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
            PokemonBatch Batch = new PokemonBatch(pkList);
            Database.executeBatch(Batch, 1);
        Test.stopTest();

        try {
            List<Pokemon__c> pkPList = [SELECT Name, Height__c, Weight__c, Photo_URL__c, Type__c, Generation__c, PokeIndex__c FROM Pokemon__c];

        System.assertEquals(pkPList[0].Name, 'Cyndaquil');
        System.assertEquals(pkPList[0].Height__c, '5 ft');
        System.assertEquals(pkPList[0].Weight__c, '79 lbs');
        System.assertEquals(pkPList[0].Photo_URL__c, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/155.png');
        System.assertEquals(pkPList[0].Type__c, 'fire');
        System.assertEquals(pkPList[0].Generation__c, 2);
        System.assertEquals(pkPList[0].PokeIndex__c, 155);
        } catch (Exception e) {
            System.debug('Error');
        }
    }
    @isTest 
    static void PokemonTestGenThree(){
        pkList.add(new Pokemon__c(name ='https://pokeapi.co/api/v2/pokemon/255'));

        String body = '{"name": "torchic","height": 4,"weight": 25,"id": 255,"sprites":{"front_default":"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/255.png"}}';

        PokeMock fakeResponse = new PokeMock(200, 'Complete', body, null);

        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
            PokemonBatch Batch = new PokemonBatch(pkList);
            Database.executeBatch(Batch, 1);
        Test.stopTest();

        try {
            List<Pokemon__c> pkPList = [SELECT Name, Height__c, Weight__c, Photo_URL__c, Type__c, Generation__c, PokeIndex__c FROM Pokemon__c];

        System.assertEquals(pkPList[0].Name, 'Torchic');
        System.assertEquals(pkPList[0].Height__c, '4 ft');
        System.assertEquals(pkPList[0].Weight__c, '25 lbs');
        System.assertEquals(pkPList[0].Photo_URL__c, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/255.png');
        System.assertEquals(pkPList[0].Type__c, 'fire');
        System.assertEquals(pkPList[0].Generation__c, 3);
        System.assertEquals(pkPList[0].PokeIndex__c, 255);
        } catch (Exception e) {
            System.debug('Error');
        }
    }

    @isTest 
    static void PokemonTestGenFour(){
        pkList.add(new Pokemon__c(name = 'https://pokeapi.co/api/v2/pokemon/390'));

        String body = '{"name": "chimchar","height": 5,"weight": 62,"id": 390,"sprites":{"front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/390.png"}}';

        PokeMock fakeResponse = new PokeMock(200, 'Complete', body, null);

        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
            PokemonBatch Batch = new PokemonBatch(pkList);
            Database.executeBatch(Batch, 1);
        Test.stopTest();

        try {
            List<Pokemon__c> pkPList = [SELECT Name, Height__c, Weight__c, Photo_URL__c, Type__c, Generation__c, PokeIndex__c FROM Pokemon__c];

        System.assertEquals(pkPList[0].Name, 'Chimchar');
        System.assertEquals(pkPList[0].Height__c, '5 ft');
        System.assertEquals(pkPList[0].Weight__c, '62 lbs');
        System.assertEquals(pkPList[0].Photo_URL__c, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/390.png');
        System.assertEquals(pkPList[0].Type__c, 'fire');
        System.assertEquals(pkPList[0].Generation__c, 4);
        System.assertEquals(pkPList[0].PokeIndex__c, 390);
        } catch (Exception e) {
            System.debug('Error');
        }
    }


    @isTest 
    static void PokemonTestGenFive(){
        pkList.add(new Pokemon__c(name = 'https://pokeapi.co/api/v2/pokemon/498'));

        String body = '{"name": "tepig","height": 5,"weight": 99,"sprites":{"front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/498.png"}}';

        PokeMock fakeResponse = new PokeMock(200, 'Complete', body, null);

        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
            PokemonBatch Batch = new PokemonBatch(pkList);
            Database.executeBatch(Batch, 1);
        Test.stopTest();

        try {
            List<Pokemon__c> pkPList = [SELECT Name, Height__c, Weight__c, Photo_URL__c, Type__c, Generation__c, PokeIndex__c FROM Pokemon__c];

        System.assertEquals(pkPList[0].Name, 'Tepig');
        System.assertEquals(pkPList[0].Height__c, '5 ft');
        System.assertEquals(pkPList[0].Weight__c, '99 lbs');
        System.assertEquals(pkPList[0].Photo_URL__c, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/498.png');
        System.assertEquals(pkPList[0].Type__c, 'fire');
        System.assertEquals(pkPList[0].Generation__c, 5);
        System.assertEquals(pkPList[0].PokeIndex__c, 498);
        } catch (Exception e) {
            System.debug('Error');
        }
    }


    @isTest 
    static void PokemonTestGenSix(){
        pkList.add(new Pokemon__c(name = 'https://pokeapi.co/api/v2/pokemon/653'));

        String body = '{"name": "fennekin","height": 4,"weight": 94,"sprites":{"front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/653.png"}}';

        PokeMock fakeResponse = new PokeMock(200, 'Complete', body, null);

        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
            PokemonBatch Batch = new PokemonBatch(pkList);
            Database.executeBatch(Batch, 1);
        Test.stopTest();

        try {
            List<Pokemon__c> pkPList = [SELECT Name, Height__c, Weight__c, Photo_URL__c, Type__c, Generation__c, PokeIndex__c FROM Pokemon__c];

        System.assertEquals(pkPList[0].Name, 'Fennekin');
        System.assertEquals(pkPList[0].Height__c, '4 ft');
        System.assertEquals(pkPList[0].Weight__c, '94 lbs');
        System.assertEquals(pkPList[0].Photo_URL__c, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/653.png');
        System.assertEquals(pkPList[0].Type__c, 'fire');
        System.assertEquals(pkPList[0].Generation__c, 6);
        System.assertEquals(pkPList[0].PokeIndex__c, 653);
        } catch (Exception e) {
            System.debug('Error');
        }
    }


    @isTest 
    static void PokemonTestGenSeven(){
        pkList.add(new Pokemon__c(name = 'https://pokeapi.co/api/v2/pokemon/725'));

        String body = '{"name": "litten","height": 4,"weight": 43,"sprites":{"front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/725.png"}}';

        PokeMock fakeResponse = new PokeMock(200, 'Complete', body, null);

        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
            PokemonBatch Batch = new PokemonBatch(pkList);
            Database.executeBatch(Batch, 1);
        Test.stopTest();

        try {
            List<Pokemon__c> pkPList = [SELECT Name, Height__c, Weight__c, Photo_URL__c, Type__c, Generation__c, PokeIndex__c FROM Pokemon__c];

        System.assertEquals(pkPList[0].Name, 'Litten');
        System.assertEquals(pkPList[0].Height__c, '4 ft');
        System.assertEquals(pkPList[0].Weight__c, '43 lbs');
        System.assertEquals(pkPList[0].Photo_URL__c, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/725.png');
        System.assertEquals(pkPList[0].Type__c, 'fire');
        System.assertEquals(pkPList[0].Generation__c, 7);
        System.assertEquals(pkPList[0].PokeIndex__c, 725);
        } catch (Exception e) {
            System.debug('Error');
        }
    }


    @isTest 
    static void PokemonTestGenEight(){
        pkList.add(new Pokemon__c(name = 'https://pokeapi.co/api/v2/pokemon/813'));

        String body = '{"name": "scorbunny","height": 3,"weight": 45,"sprites":{"front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/813.png"}}';

        PokeMock fakeResponse = new PokeMock(200, 'Complete', body, null);

        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
            PokemonBatch Batch = new PokemonBatch(pkList);
            Database.executeBatch(Batch, 1);
        Test.stopTest();

        try {
            List<Pokemon__c> pkPList = [SELECT Name, Height__c, Weight__c, Photo_URL__c, Type__c, Generation__c, PokeIndex__c FROM Pokemon__c];

        System.assertEquals(pkPList[0].Name, 'Scorbunny');
        System.assertEquals(pkPList[0].Height__c, '3 ft');
        System.assertEquals(pkPList[0].Weight__c, '45 lbs');
        System.assertEquals(pkPList[0].Photo_URL__c, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/813.png');
        System.assertEquals(pkPList[0].Type__c, 'fire');
        System.assertEquals(pkPList[0].Generation__c, 8);
        System.assertEquals(pkPList[0].PokeIndex__c, 813);
        } catch (Exception e) {
            System.debug('Error');
        }
    }
}