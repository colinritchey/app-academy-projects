
json.extract! @pokemon, :id, :name, :attack, :defense, :moves, :poke_type
json.image_url asset_path(@pokemon.image_url)

json.items @pokemon.items do |item|
  json.name item.name
  json.pokemon_id item.pokemon_id
  json.price item.price
  json.happiness item.happiness
  json.image_url asset_path(item.image_url)
end
