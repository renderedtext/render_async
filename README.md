[![Build Status](https://semaphoreci.com/api/v1/renderedtext/render_async/branches/master/shields_badge.svg)](https://semaphoreci.com/renderedtext/render_async)
[![Gem Version](https://badge.fury.io/rb/render_async.svg)](https://badge.fury.io/rb/render_async)

![render_async](https://semaphoreci.com/blog/assets/images/2017-06-08/speed-up-rendering-rails-pages-with-render-async-6c40eb39.png)

# render_async

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
gem 'render_async'
```

And then execute:

    $ bundle install

## Usage

1. Include `render_async` view helper somewhere in your views:

    ```erb
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

      render :partial => "comment_stats"
    end
    ```

4. Create a partial that will render
    ```erb
    # app/views/comments/_comment_stats.html.erb

    <div class="col-md-6">
      <%= @stats %>
    </div>
    ```

5. Add `content_for` in your base view file
    ```erb
    # application.html.erb

    <%= content_for :render_async %>
    ```

## Advanced usage

`render_async` takes two arguments, `path` and `html_options`.

* `path` is the ajax-capable controller action you're looking to call via `get`. e.g. `comments_stats_path`, `posts_path`, etc.
* `html_options` is an optional hash that gets passed to a rails `javascript_tag`, to drop html tags into the `script` element.

Example utilizing `html_options` with a `nonce`:
```erb
<%= render_async users_path, nonce: 'lWaaV6eYicpt+oyOfcShYINsz0b70iR+Q1mohZqNaag=' %>
```

Rendered code in the view:
```html
<div id="render_async_18b8a6cd161499117471">
  <div id="render_async_18b8a6cd161499117471_spinner" class="sk-spinner sk-spinner-double-bounce">
    <div class="sk-double-bounce1"></div>
    <div class="sk-double-bounce2"></div>
  </div>
</div>

<script nonce="lWaaV6eYicpt+oyOfcShYINsz0b70iR+Q1mohZqNaag=">
//<![CDATA[

    (function($){
      $.ajax({
          url: "/users",
        })
        .done(function(response, status) {
          $("#render_async_18b8a6cd161499117471").html(response);
        })
        .fail(function(response, status) {
          $("#render_async_18b8a6cd161499117471").html(response);
        })
        .always(function(response, status) {
          $("#render_async_18b8a6cd161499117471_spinner").hide();
        });
    }(jQuery));

//]]>
</script>
```

## Caching

`render_async` can utilize view fragment caching to avoid extra ajax calls on repeat page views.

In your views:
  ```erb
  # app/views/comments/show.html.erb

  # note 'render_async_cache' instead of standard 'render_async'
  <%= render_async_cache comment_stats_path %>
  ```

  ```erb
  # app/views/comments/_comment_stats.html.erb

  <% cache render_async_cache_key(path) do %>
    <div class="col-md-6">
      <%= @stats %>
    </div>
  <% end %>
  ```

* The first time the page renders, it will make the ajax call.
* Any other times (until the cache expires), it will render from cache instantly, without needing the page to load and make the ajax call.

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
