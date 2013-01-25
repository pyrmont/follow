class TweetsController < ApplicationController
  respond_to :html, :json

  def combined
    @username = params[:username] || 'zeldman' # TODO: Explode, not Jeffrey.

    # TODO: Replace example with real Tweet-loader.
    respond_to do |f|
      f.json { render :json => FixtureLoader.load('combined.json') }
      f.html { render }
    end
  end
end
