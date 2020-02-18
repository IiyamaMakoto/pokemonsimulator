json.id @pokemon.id
json.name @pokemon.name
json.hp @pokemon.hp
json.attack @pokemon.attack
json.defence @pokemon.defence
json.sp_atk @pokemon.sp_atk
json.sp_def @pokemon.sp_def
json.speed @pokemon.speed
json.abilities do
  json.array! @pokemon.abilities, :id, :name
end
json.types do
  json.array! @pokemon.types, :id, :name
end
