module Api
  class ResultsController < ApplicationController

    def index
      if !request.accept || request.accept == '*/*'
        render plain: "/api/races/#{params[:race_id]}/results"
      else
        race     = Race.find(params[:race_id])
        entrants = race.entrants

        if stale? etag: entrants, last_modified: entrants.max(:updated_at)
          render template: 'api/results/index',
                 locals:   { entrants: entrants }
        end
      end
    end

    def show
      if !request.accept || request.accept == '*/*'
        render plain: "/api/races/#{params[:race_id]}/results/#{params[:id]}"
      else
        result = Race.find(params[:race_id]).entrants.where(id: params[:id]).first
        render partial: 'result', locals: { result: result }
      end
    end

    def update
      entrant = Race.find(params[:race_id]).entrants.where(id: params[:id]).first

      result_params.keys.each do |param|
        value = entrant.race.race.send("#{param}")
        entrant.send("#{param}=", value)
        entrant.send("#{param}_secs=", result_params[param].to_f)
      end

      entrant.save

      render nothing: true, status: :ok
    end

    # TODO: refactor common code
    rescue_from Mongoid::Errors::DocumentNotFound do |exception|
      if !request.accept || request.accept == '*/*'
        render plain: "woops: cannot find race[#{params[:race_id]}]", status: :not_found
      else
        render status:   :not_found,
               template: 'api/error_msg',
               locals:   { msg: "woops: cannot find race[#{params[:race_id]}]" }
      end
    end

    # TODO: refactor common code
    rescue_from ActionView::MissingTemplate do |exception|
      Rails.logger.warn exception
      render plain: "woops: we do not support that content-type[#{request.accept}]", status: :unsupported_media_type
    end

    private

    def result_params
      params.require(:result).permit(:swim, :t1, :bike, :t2, :run)
    end
  end
end
