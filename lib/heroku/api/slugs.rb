module Heroku
  class API
    def get_slug_v3(app, slug_id)
      request(
        :expects  => 200,
        :headers  => {
          'Accept' => 'application/vnd.heroku+json; version=3'
        },
        :method   => :get,
        :path     => "/apps/#{app}/slugs/#{slug_id}"
      )
    end
  end
end
