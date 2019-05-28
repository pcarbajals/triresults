module Api
  class RacesController < ApplicationController

    protect_from_forgery with: :null_session

    def index
      if !request.accept || request.accept == '*/*'
        render plain: "/api/races, offset=[#{params[:offset]}], limit=[#{params[:limit]}]"
      else
        #real implementation ...
      end
    end

    def show
      if !request.accept || request.accept == '*/*'
        render plain: "/api/races/#{params[:id]}"
      else
        render template: 'api/races/show',
               locals:   { race: Race.find(params[:id]) }
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
      race = Race.find(params[:id])
      race.update!(race_params)

      render json: race
    end

    def destroy
      Race.find(params[:id]).destroy
      render nothing: true, status: :no_content
    end

    # TODO: refactor common code
    rescue_from Mongoid::Errors::DocumentNotFound do |exception|
      if !request.accept || request.accept == '*/*'
        render plain: "woops: cannot find race[#{params[:id]}]", status: :not_found
      else
        render status:   :not_found,
               template: 'api/error_msg',
               locals:   { msg: "woops: cannot find race[#{params[:id]}]" }
      end
    end

    # TODO: refactor common code
    rescue_from ActionView::MissingTemplate do |exception|
      Rails.logger.warn exception
      render plain: "woops: we do not support that content-type[#{request.accept}]", status: :unsupported_media_type
    end

    private

    def race_params
      params.require(:race).permit(:name, :date, :city, :state, :swim_distance, :swim_units, :bike_distance, :bike_units, :run_distance, :run_units)
    end
  end
end
