[![Build Status](https://semaphoreci.com/api/v1/renderedtext/render_async/branches/master/badge.svg)](https://semaphoreci.com/renderedtext/render_async)

# RenderAsync

Renders partials to your views **asynchronously**. This is done through adding
Javascript code that does AJAX request to your controller which then renders
your partial.

Workflow:

1. user visits a page => 
2. AJAX request on the controller action => 
3. controller renders a partial => 
4. partials renders in the place where you put `render_async` helper

Javascript is injected into `<%= content_for :render_async %>` so you choose
where to put it.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'render_async', :source => "https://gem.fury.io/renderedtext/"
```

And then execute:

    $ bundle

## Usage

1. Include `render_async` view helper somewhere in your views:

    ```ruby
    # app/views/comments/show.html.erb

    <%= render_async comment_stats_path %>
    ```

2. Then create a route that will `config/routes.rb`
    ```ruby
    # config/routes.rb

    get :comment_stats, :controller => :comments
    ```

3. Fill in the logic in your controller
    ```ruby
    # app/controllers/comments_controller.rb

    def comment_stats
      @stats = Comment.get_stats

      render :patial => "comment_stats"
    end
    ```

4. Create a partial that will render
    ```ruby
    # app/views/comments/_comment_stats.html.erb

    <div class="col-md-6">
      <%= @stats %>
    </div>
    ```

5. Add `content_for` in your base view file
    ```ruby
    # application.html.erb

    <%= content_for :render_async %>
    ```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/renderedtext/render_async.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
