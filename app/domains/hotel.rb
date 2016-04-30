class Hotel
  attr_reader :id, :name, :address, :star_rating ,:accomodation_type
  def initialize(hotel_params)
    @id = hotel_params["id"]
    @name = hotel_params["name"]
    @address = hotel_params["address"]
    @star_rating = hotel_params["starRating"]
    @accomodation_type = hotel_params["accomodationType"]
  end
end
