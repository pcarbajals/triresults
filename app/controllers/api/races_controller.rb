module Api
  class RacesController < ApplicationController

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
        render template: 'api/races/show',
               locals:   { race: Race.find(params[:race_id]) }
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
        race     = Race.find(params[:race_id])
        entrants = race.entrants

        render template: 'api/races/results',
               locals: { entrants: entrants }
      end
    end

    def results_index
      if !request.accept || request.accept == '*/*'
        render plain: "/api/races/#{params[:race_id]}/results/#{params[:id]}"
      else
        result = Race.find(params[:race_id]).entrants.where(id: params[:id]).first
        render partial: 'result', object: result
      end
    end

    def results_update
      entrant = Race.find(params[:race_id]).entrants.where(id: params[:id]).first

      result_params.keys.each do |param|
        value = entrant.race.race.send("#{param}")
        entrant.send("#{param}=", value)
        entrant.send("#{param}_secs=", result_params[param].to_f)
      end

      entrant.save

      render nothing: true, status: :ok
    end

    rescue_from Mongoid::Errors::DocumentNotFound do |exception|
      if !request.accept || request.accept == '*/*'
        render plain: "woops: cannot find race[#{params[:race_id]}]", status: :not_found
      else
        render status:   :not_found,
               template: 'api/error_msg',
               locals:   { msg: "woops: cannot find race[#{params[:race_id]}]" }
      end
    end

    rescue_from ActionView::MissingTemplate do |exception|
      Rails.logger.warn exception
      render plain: "woops: we do not support that content-type[#{request.accept}]", status: :unsupported_media_type
    end

    private

    def race_params
      params.require(:race).permit(:name, :date, :city, :state, :swim_distance, :swim_units, :bike_distance, :bike_units, :run_distance, :run_units)
    end

    def result_params
      params.require(:result).permit(:swim, :t1, :bike, :t2, :run)
    end
  end
end
