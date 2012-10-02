require "spec_helper"
require "heroku/command/notifications"

module Heroku::Command
  describe Notifications do

    before(:each) do
      stub_core
      api.post_app("name" => "myapp", "stack" => "cedar")
    end

    after(:each) do
      api.delete_app("myapp")
    end

    it "shows an empty list when no notifications available" do
      stub_notifications.get_notifications.returns([])
      stderr, stdout = execute("notifications")
      stderr.should == ""
      stdout.should =~ /has no notifications/
    end

    it "shows notifications if they exist" do
      stub_notifications.get_notifications.returns(
        [
          {
            resource: 'flying-monkey-123',
            message:  'Database HEROKU_POSTGRESQL_BROWN is over row limits',
            url:      'https://devcenter.heroku.com/how-to-fix-problem',
            severity: 'info'
          },
          {
            resource: 'rising-cloud-42',
            message:  'High OOM rates',
            url:      'https://devcenter.heroku.com/oom',
            severity: 'fatal'
          }
        ]
      )
      stderr, stdout = execute("notifications")
      stderr.should == ""
      stdout.should == (<<-STDOUT)
flying-monkey-123
  info: Database HEROKU_POSTGRESQL_BROWN is over row limits
  More info: https://devcenter.heroku.com/how-to-fix-problem

rising-cloud-42
  fatal: High OOM rates
  More info: https://devcenter.heroku.com/oom
STDOUT
    end
  end
end
