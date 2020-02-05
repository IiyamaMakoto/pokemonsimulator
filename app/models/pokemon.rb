class Pokemon < ApplicationRecord
  include ActiveHash::Associations
  has_many :types, throuth: :pokemon_types
  has_many :pokemon_types
end