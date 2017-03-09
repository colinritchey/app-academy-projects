import React from 'react';

class PokemonListItem extends React.Component{
  render() {
    const { poke } = this.props;

    return (
      <li>
        <p>{poke.name}</p>
         <img src={poke.image_url} />
      </li>
    );
  }
}

export default PokemonListItem;
