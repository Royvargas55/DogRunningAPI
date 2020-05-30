class BreedsController < ApplicationController
  include BreedsCache
  
  def index
    @breeds = fetch_breeds
    json_response(@breeds)
  end

  def search
    limit = params[:limit] || 10
    page = params[:page] || 1
    offset = ((page.to_i - 1) * limit.to_i) || 0

    q = params[:q].downcase || nil
    @breeds = []
    @breeds = Breed.where('breed LIKE ? ', "%#{q}%").limit(limit).offset(offset) if q
    json_response(@breeds)
  end
end
