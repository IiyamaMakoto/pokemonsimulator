class Weather < ActiveHash::Base
  self.data = [
    {id: 1, name: "にほんばれ"},
    {id: 2, name: "あめ"},
    {id: 3, name: "すなあらし"},
    {id: 4, name: "あられ"}
  ]
end
