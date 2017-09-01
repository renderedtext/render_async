[![Build Status](https://semaphoreci.com/api/v1/renderedtext/render_async/branches/master/shields_badge.svg)](https://semaphoreci.com/renderedtext/render_async)
[![All Contributors](https://img.shields.io/badge/all_contributors-4-orange.svg?style=flat-square)](#contributors)
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

## Contributors

Thanks goes to these wonderful people ([emoji key](https://github.com/kentcdodds/all-contributors#emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
| [<img src="https://avatars2.githubusercontent.com/u/3028124?v=4" width="100px;"/><br /><sub>Nikola Đuza</sub>](http://nikoladjuza.me/)<br />[💬](#question-nikolalsvk "Answering Questions") [🐛](https://github.com/renderedtext/render_async/issues?q=author%3Anikolalsvk "Bug reports") [💻](https://github.com/renderedtext/render_async/commits?author=nikolalsvk "Code") [📖](https://github.com/renderedtext/render_async/commits?author=nikolalsvk "Documentation") [💡](#example-nikolalsvk "Examples") [👀](#review-nikolalsvk "Reviewed Pull Requests") | [<img src="https://avatars0.githubusercontent.com/u/3866868?v=4" width="100px;"/><br /><sub>Colin</sub>](http://www.colinxfleming.com)<br />[💻](https://github.com/renderedtext/render_async/commits?author=colinxfleming "Code") | [<img src="https://avatars2.githubusercontent.com/u/334273?v=4" width="100px;"/><br /><sub>Kasper Grubbe</sub>](http://kaspergrubbe.com)<br />[💻](https://github.com/renderedtext/render_async/commits?author=kaspergrubbe "Code") | [<img src="https://avatars2.githubusercontent.com/u/163584?v=4" width="100px;"/><br /><sub>Sai Ram Kunala</sub>](https://sairam.xyz/)<br />[📖](https://github.com/renderedtext/render_async/commits?author=sairam "Documentation") |
| :---: | :---: | :---: | :---: |
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/kentcdodds/all-contributors) specification. Contributions of any kind welcome!