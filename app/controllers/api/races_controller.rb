module Api
  class RacesController < ApplicationController
    
    rescue_from Mongoid::Errors::DocumentNotFound do |exception|
      render plain: "woops: cannot find race[#{params[:race_id]}]", status: :not_found
    end
    
    def index
      if !request.accept || request.accept == '*/*'
        render plain: "/api/races, offset=[#{params[:offset]}], limit=[#{params[:limit]}]"
      else
        #real implementation ...
      end
    end

    def show
      if !request.accept || request.accept == '*/*'
        render plain: "/api/races/#{params[:race_id]}"
      else
        race = Race.find(params[:race_id])
        render json: race
      end
    end

    def create
      if !request.accept || request.accept == '*/*'
        render plain: params[:race][:name], status: :ok
      else
        Race.create(race_params)
        render plain: params[:race][:name], status: :created
      end
    end

    def update
      race = Race.find(params[:race_id])
      race.update!(race_params)

      render json: race
    end
    
    def destroy
      Race.find(params[:race_id]).destroy
      render nothing: true, status: :no_content
    end

    def results
      if !request.accept || request.accept == '*/*'
        render plain: "/api/races/#{params[:race_id]}/results"
      else
        #real implementation ...
      end
    end

    def results_index
      if !request.accept || request.accept == '*/*'
        render plain: "/api/races/#{params[:race_id]}/results/#{params[:id]}"
      else
        #real implementation ...
      end
    end
    
    private

    def race_params
      params.require(:race).permit(:name, :date, :city, :state, :swim_distance, :swim_units, :bike_distance, :bike_units, :run_distance, :run_units)
    end
  end
end
