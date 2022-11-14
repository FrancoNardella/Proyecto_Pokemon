import { NavigationMixin } from 'lightning/navigation';
import { LightningElement, wire } from 'lwc';
import searchPokemons from '@salesforce/apex/PokeController.searchPokemons';
export default class pokemon extends NavigationMixin(LightningElement) {
	type='All';
	generation='0'; 
	searchTerm = '';
	@wire(searchPokemons, {type: '$type', generation: '$generation', searchTerm: '$searchTerm'})	
	pokemons;	
	
	
    get types() {
        return [
            	{ label: 'All', value: 'All' },
				{ label: 'Normal', value: 'Normal' },
				{ label: 'Fighting', value: 'Fighting' },
				{ label: 'Flying', value: 'Flying' },
				{ label: 'Poison', value: 'Poison' },
				{ label: 'Ground', value: 'Ground' },
				{ label: 'Bug', value: 'Bug' },
				{ label: 'Ghost', value: 'Ghost' },
				{ label: 'Steel', value: 'Steel' },
				{ label: 'Fire', value: 'Fire' },
				{ label: 'Water', value: 'Water' },
				{ label: 'Grass', value: 'Grass' },
				{ label: 'Electric', value: 'Electric' },
				{ label: 'Psychic', value: 'Psychic' },
				{ label: 'Ice', value: 'Ice' },
				{ label: 'Dragon', value: 'Dragon' },
				{ label: 'Dark', value: 'Dark' },
				{ label: 'Fairy', value: 'Fairy' },
				{ label: 'Rock', value: 'Rock' },
        ];
    }  

    get generations() {
        return [
            { label: 'All', value: '0' },
            { label: 'First', value: '1' },
            { label: 'Second', value: '2' },
			{ label: 'Third', value: '3' },
			{ label: 'Fourth', value: '4' },
			{ label: 'Fifth', value: '5' },
			{ label: 'Sixth', value: '6' },
			{ label: 'Seventh', value: '7' },
			{ label: 'Eighth', value: '8' },
        ];
    }

	

	handleSearchTermChange(event) {
		
		window.clearTimeout(this.delayTimeout);
		const searchTerm = event.target.value;
		this.delayTimeout = setTimeout(() => {
			this.searchTerm = searchTerm;
		}, 300);

	}

	handleGenerationChange(event) {
		
		window.clearTimeout(this.delayTimeout);
		const generation = event.target.value;
		this.delayTimeout = setTimeout(() => {
			this.generation = generation;
		}, 300);
	}

	handleTypeChange(event) {
		
		window.clearTimeout(this.delayTimeout);
		const type = event.target.value;
		this.delayTimeout = setTimeout(() => {
			this.type = type;
		}, 300);
	}

	get hasResults() {
		console.log(this.pokemons)
		return (this.pokemons.data.length > 0);
	}
	
	handlePokemonView(event) {
		
		const pokemonId = event.detail;
		
		this[NavigationMixin.Navigate]({
			type: 'standard__recordPage',
			attributes: {
				recordId: pokemonId,
				objectApiName: 'Pokemon__c',
				actionName: 'view',
			},
		});
	}
	
}