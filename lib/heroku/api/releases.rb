module Heroku
  class API
    def get_release_v3(app)
      request(
        :expects  => 200,
        :headers  => {
          'Accept' => 'application/vnd.heroku+json; version=3',
          'Range'  => 'version ..; order=desc,max=1;'
        },
        :method   => :get,
        :path     => "/apps/#{app}/releases"
      )
    end
  end
end
