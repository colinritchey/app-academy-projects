import React from 'react';
import PokemonListItem from './pokemon_list_item';

class PokemonIndex extends React.Component {
  componentDidMount() {
    this.props.requestAllPokemon();
  }

  render() {
    const { pokemon } = this.props;
    const pokemonItems = pokemon.map((poke, idx) => (
      <PokemonListItem key={idx} poke={poke} />
    ));

    return (
      <div>
        <ul>
          {pokemonItems}
        </ul>
      </div>
    );
  }
}

export default PokemonIndex;
