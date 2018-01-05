[![Build Status](https://semaphoreci.com/api/v1/renderedtext/render_async/branches/master/shields_badge.svg)](https://semaphoreci.com/renderedtext/render_async)
[![All Contributors](https://img.shields.io/badge/all_contributors-10-orange.svg?style=flat-square)](#contributors)
[![Gem Version](https://badge.fury.io/rb/render_async.svg)](https://badge.fury.io/rb/render_async)
[![Code Climate](https://codeclimate.com/github/renderedtext/render_async/badges/gpa.svg)](https://codeclimate.com/github/renderedtext/render_async)
[![Test Coverage](https://codeclimate.com/github/renderedtext/render_async/badges/coverage.svg)](https://codeclimate.com/github/renderedtext/render_async/coverage)
[![Help Contribute to Open Source](https://www.codetriage.com/renderedtext/render_async/badges/users.svg)](https://www.codetriage.com/renderedtext/render_async)

![render_async](https://semaphoreci.com/blog/assets/images/2017-06-08/speed-up-rendering-rails-pages-with-render-async-6c40eb39.png)

# render_async

Speed up rendering Rails pages with this gem.

`render_async` renders partials to your views **asynchronously**. This is done
through adding Javascript code that does AJAX request to your controller which
then renders your partial into a Rails view.

Workflow:

1. user visits a Rails page
2. AJAX request on the controller action
3. controller renders a partial
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

1. Include `render_async` view helper somewhere in your views (e.g. `app/views/comments/show.html.erb`):
    ```erb
    <%= render_async comment_stats_path %>
    ```

2. Then create a route that will `config/routes.rb`:
    ```ruby
    get :comment_stats, :controller => :comments
    ```

3. Fill in the logic in your controller (e.g. `app/controllers/comments_controller.rb`):
    ```ruby
    def comment_stats
      @stats = Comment.get_stats

      render :partial => "comment_stats"
    end
    ```

4. Create a partial that will render (e.g. `app/views/comments/_comment_stats.html.erb`):
    ```erb
    <div class="col-md-6">
      <%= @stats %>
    </div>
    ```

5. Add `content_for` in your base view file (e.g. `app/views/layouts/application.html.erb`):
    ```erb
    <%= content_for :render_async %>
    ```

## Advanced usage

Advanced usage includes information on different options, such as:

  - [Passing in HTML options](#passing-in-html-options)
  - [Passing in a placeholder](#passing-in-a-placeholder)
  - [Passing in an event name](#passing-in-an-event-name)
  - [Caching](#caching)
  - [Using with Turbolinks](#using-with-turbolinks)
  - [Nested Async Renders](#nested-async-renders)

### Passing in HTML options

`render_async` takes two arguments, `path` and `html_options`.

* `path` is the AJAX-capable controller action you're looking to call via
  `GET`. e.g. `comments_stats_path`, `posts_path`, etc.
* `html_options` is an optional hash that gets passed to a rails
  `javascript_tag`, to drop html tags into the `script` element.

Example of utilizing `html_options` with a `nonce`:
```erb
<%= render_async users_path, nonce: 'lWaaV6eYicpt+oyOfcShYINsz0b70iR+Q1mohZqNaag=' %>
```

Rendered code in the view:
```html
<div id="render_async_18b8a6cd161499117471">
</div>

<script nonce="lWaaV6eYicpt+oyOfcShYINsz0b70iR+Q1mohZqNaag=">
//<![CDATA[
  ...
//]]>
</script>
```

### Passing in a placeholder

`render_async` can be called with a block that will act as a placeholder before
your AJAX call finishes.

Example of passing in a block:

```erb
<%= render_async users_path do %>
  <h1>Users are loading...</h1>
<% end %>
```

Rendered code in the view:
```html
<div id="render_async_14d7ac165d1505993721">
  <h1>Users are loading...</h1>
</div>

<script>
//<![CDATA[
  ...
//]]>
</script>
```

After AJAX is finished, placeholder will be replaced with the request's
response.

### Passing in an event name

`render_async` can receive `:event_name` option which will emit Javascript
event after it's done with fetching and rendering request content to HTML.

This can be useful to have if you want to add some Javascript functionality
after your partial is loaded through `render_async`.

Example of passing it to `render_async`:
```erb
<%= render_async users_path, :event_name => "users-loaded" %>
```

Rendered code in view:
```html
<div id="render_async_04229e7abe1507987376">
</div>

<script>
//<![CDATA[
  ...
    document.dispatchEvent(new Event("users-loaded"));
  ...
//]]>
</script>
```

Then, in your JS, you could do something like this:
```javascript
document.addEventListener("users-loaded", function() {
  console.log("Users have loaded!");
});
```

## Caching

`render_async` can utilize view fragment caching to avoid extra AJAX calls.

In your views (e.g. `app/views/comments/show.html.erb`):
```erb
# note 'render_async_cache' instead of standard 'render_async'
<%= render_async_cache comment_stats_path %>
```

Then, in the partial (e.g. `app/views/comments/_comment_stats.html.erb`):
```erb
<% cache render_async_cache_key(request.path), :skip_digest => true do %>
  <div class="col-md-6">
    <%= @stats %>
  </div>
<% end %>
```

* The first time the page renders, it will make the AJAX call.
* Any other times (until the cache expires), it will render from cache
  instantly, without making the AJAX call.
* You can expire cache simply by passing `:expires_in` in your view where
  you cache the partial

## Using with Turbolinks

On Turbolinks applications, you may experience caching issues when navigating
away from, and then back to, a page with a `render_async` call on it. This will
likely show up as an empty div.

To resolve, tell turbolinks to reload your `render_async` call as follows:

```erb
<%= render_async events_path, 'data-turbolinks-track': 'reload' %>
```

### Nested Async Renders

It is possible to nest async templates within other async templates. When doing
so, another `content_for` is required to ensure the JavaScript needed to load
nested templates is included.

For example:
```erb
<%# app/views/comments/show.html.erb %>

<%= render_async comment_stats_path %>
```

```erb
<%# app/views/comments/_comment_stats.html.erb %>

<div class="col-md-6">
  <%= @stats %>
</div>

<div class="col-md-6">
  <%= render_async comment_advanced_stats_path %>
</div>

<%= content_for :render_async %>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/renderedtext/render_async.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Contributors

Thanks goes to these wonderful people ([emoji key](https://github.com/kentcdodds/all-contributors#emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
| [<img src="https://avatars2.githubusercontent.com/u/3028124?v=4" width="100px;"/><br /><sub>Nikola Đuza</sub>](http://nikoladjuza.me/)<br />[💬](#question-nikolalsvk "Answering Questions") [🐛](https://github.com/renderedtext/render_async/issues?q=author%3Anikolalsvk "Bug reports") [💻](https://github.com/renderedtext/render_async/commits?author=nikolalsvk "Code") [📖](https://github.com/renderedtext/render_async/commits?author=nikolalsvk "Documentation") [💡](#example-nikolalsvk "Examples") [👀](#review-nikolalsvk "Reviewed Pull Requests") | [<img src="https://avatars0.githubusercontent.com/u/3866868?v=4" width="100px;"/><br /><sub>Colin</sub>](http://www.colinxfleming.com)<br />[💻](https://github.com/renderedtext/render_async/commits?author=colinxfleming "Code") [📖](https://github.com/renderedtext/render_async/commits?author=colinxfleming "Documentation") | [<img src="https://avatars2.githubusercontent.com/u/334273?v=4" width="100px;"/><br /><sub>Kasper Grubbe</sub>](http://kaspergrubbe.com)<br />[💻](https://github.com/renderedtext/render_async/commits?author=kaspergrubbe "Code") | [<img src="https://avatars2.githubusercontent.com/u/163584?v=4" width="100px;"/><br /><sub>Sai Ram Kunala</sub>](https://sairam.xyz/)<br />[📖](https://github.com/renderedtext/render_async/commits?author=sairam "Documentation") | [<img src="https://avatars2.githubusercontent.com/u/3065882?v=4" width="100px;"/><br /><sub>Josh Arnold</sub>](https://github.com/nightsurge)<br />[💻](https://github.com/renderedtext/render_async/commits?author=nightsurge "Code") [📖](https://github.com/renderedtext/render_async/commits?author=nightsurge "Documentation") | [<img src="https://avatars3.githubusercontent.com/u/107798?v=4" width="100px;"/><br /><sub>Elad Shahar</sub>](https://eladshahar.com)<br />[💻](https://github.com/renderedtext/render_async/commits?author=SaladFork "Code") | [<img src="https://avatars3.githubusercontent.com/u/232392?v=4" width="100px;"/><br /><sub>Sasha</sub>](http://www.revzin.co.il)<br />[💻](https://github.com/renderedtext/render_async/commits?author=sasharevzin "Code") [📖](https://github.com/renderedtext/render_async/commits?author=sasharevzin "Documentation") |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| [<img src="https://avatars3.githubusercontent.com/u/50223?v=4" width="100px;"/><br /><sub>Ernest Surudo</sub>](http://elsurudo.com)<br />[💻](https://github.com/renderedtext/render_async/commits?author=elsurudo "Code") | [<img src="https://avatars1.githubusercontent.com/u/334809?v=4" width="100px;"/><br /><sub>Kurtis Rainbolt-Greene</sub>](https://kurtis.rainbolt-greene.online)<br />[💻](https://github.com/renderedtext/render_async/commits?author=krainboltgreene "Code") | [<img src="https://avatars2.githubusercontent.com/u/59744?v=4" width="100px;"/><br /><sub>Richard Schneeman</sub>](https://www.schneems.com)<br />[📖](https://github.com/renderedtext/render_async/commits?author=schneems "Documentation") |
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/kentcdodds/all-contributors) specification. Contributions of any kind welcome!
