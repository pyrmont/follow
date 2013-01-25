Follow::Application.routes.draw do

  # View the combined Tweets for a username
  match 'tweets/:username' => 'tweets#combined'

  # Temporarily point to "if I followed @zeldman" page.
  root :to => 'tweets#combined'

end
