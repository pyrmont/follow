require 'spec_helper'

describe TweetsController do

  context "JSON API" do
    it "returns a combined tweet stream" do
      get :combined, :username => 'zeldman', :format => :json
      json = JSON.parse(response.body)
      first = json.first

      # This string is huge. Make sure some required properties are there.
      # When Mike has locked down the front-end more, slim down the attributes
      # all the way.
      json.count.should == 20
      first['text'].should match /Training with @bodybyhannah/
      first['user']['screen_name'].should == 'zeldman'
    end
  end

  context "HTML front-end" do
    render_views

    it "shows us which user we're combining into our stream" do
      get :combined, :username => 'zorflax', :format => :html
      response.should render_template :combined
      response.body.should match /Your Tweets combined with @zorflax/
    end
  end
end
