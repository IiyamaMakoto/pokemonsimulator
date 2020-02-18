class Ability < ApplicationRecord
  has_many :pokemon_abilities
  has_many :pokemons, through: :pokemon_abilities
end
