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

    private

    def result_params
      params.require(:result).permit(:swim, :t1, :bike, :t2, :run)
    end
  end
end
