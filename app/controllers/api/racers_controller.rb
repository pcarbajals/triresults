module Api
  class RacersController < ApplicationController
    def index
      if !request.accept || request.accept == "*/*"
        render plain: '/api/racers'
      else
        #real implementation ...
      end
    end

    def show
      if !request.accept || request.accept == "*/*"
        render plain: "/api/racers/#{params[:racer_id]}"
      else
        #real implementation ...
      end
    end

    def entries
      if !request.accept || request.accept == "*/*"
        render plain: "/api/racers/#{params[:racer_id]}/entries"
      else
        #real implementation ...
      end
    end

    def entries_index
      if !request.accept || request.accept == "*/*"
        render plain: "/api/racers/#{params[:racer_id]}/entries/#{params[:id]}"
      else
        #real implementation ...
      end
    end
  end
end
