global class PokemonBatch implements Database.Batchable<Pokemon__c>, Database.AllowsCallouts, Database.Stateful {
    public List<Pokemon__c> pkList;
    //private String URL = 'https://pokeapi.co/api/v2/pokemon/';
    
    public PokemonBatch(List<Pokemon__c> pkList){
        this.pkList=pkList;
    }
    global Iterable<Pokemon__c> start(Database.BatchableContext BC){
        return pkList;
    }
    global void execute(Database.BatchableContext BC, List<Pokemon__c> ListPokemonToInsert){
        //try con minuscula
        try{
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndPoint('https://pokeapi.co/api/v2/pokemon/' + ListPokemonToInsert[0].PokeIndex__c);
            request.setMethod('GET');
            HttpResponse response = http.send(request);
            //request.setHeader('Content-Type', 'application/json');
            String body = response.getBody();
            Pokemon__C pokemonObject = new Pokemon__c();
            pokemon pk = pokemon.parse(body);
            pokemonObject.Name=pk.name.capitalize();
            pokemonObject.Weight__c=pk.weight + 'lbs.';
            pokemonObject.Height__c=pk.height.format() + 'ft.';
            pokemonObject.Photo_URL__c=pk.sprites.front_default;
            pokemonObject.PokeIndex__c=pk.id;
            
            if (pk.id > 0 && pk.id <= 151){
                pokemonObject.Generation__c = 1;
            }else if (pk.id > 151 && pk.id <= 251) {
                pokemonObject.Generation__c = 2;
            }else if (pk.id > 251 && pk.id <= 386) {
                pokemonObject.Generation__c = 3;
            }else if (pk.id > 386 && pk.id <= 493) {
               pokemonObject.Generation__c = 4;
            }else if (pk.id > 493 && pk.id <= 649) {
                pokemonObject.Generation__c = 5;
            }else if (pk.id > 649 && pk.id <= 721) {
                pokemonObject.Generation__c = 6;
            }else if (pk.id > 721 && pk.id <= 809) {
                pokemonObject.Generation__c = 7;
            }else if (pk.id > 809 && pk.id <= 898) {
                pokemonObject.Generation__c = 8;
            }
            
            for(Integer i = 0; i<pk.types.size(); i++){
                pokemonObject.Type__c = pokemonObject.Type__c == null ? pk.types[i].type.name : pokemonObject.Type__c + ';' + pk.types[i].type.name;
            }
            insert pokemonObject;
            
        } catch(Exception e){
          System.debug('Error : ' + e);
        }
    }
    global void finish(Database.BatchableContext BC){
        //System mayuscula
        System.debug('Terminó el batch');
    }
}