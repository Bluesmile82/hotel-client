require 'rest-client'

class HotelsController < ApplicationController

  def index
    if params[:search].present?
      hotels = RestClient.get(ENV["api_url"], {params: params})
    else
      hotels = RestClient.get(ENV["api_url"])
    end
    @hotels = JSON.parse(hotels).map { |hotel_params| Hotel.new(hotel_params) }
  end

  def show
    hotel = RestClient.get(ENV["api_url"] + params[:id])
    @hotel = Hotel.new(JSON.parse(hotel))
  end

  def new
  end

  def edit
  end

  def create
    hotel = Hotel.new(params)
    RestClient.post( ENV["api_url"] , { hotel: hotel.to_json }){ |response, request, result, &block|
        if response.code == 201
          redirect_to hotels_path, notice: 'Hotel was successfully created.'
        else
          render :new
        end
      }
  end

  def update
    hotel = Hotel.new(params)
    RestClient.put( ENV["api_url"] + params[:id] , { hotel: hotel.to_json }){ |response, request, result, &block|
        if response.code == 200
          redirect_to hotel_path(hotel.id), notice: 'Hotel was successfully updated.'
        else
          redirect_to hotels_url, notice: 'There has been an error. Hotel was not successfully updated.'
        end
      }
  end

  def destroy
    RestClient.delete( ENV["api_url"] + params[:id]){ |response, request, result, &block|
        if response.code == 200
          redirect_to hotels_url, notice: 'Hotel was successfully destroyed.'
        else
          redirect_to hotels_url, notice: 'There has been an error. Hotel was not successfully destroyed.'
        end
      }
  end
end
