<p align="center">
  <img src='http://s2blog.wpengine.com/wp-content/uploads/assets/images/2017-06-08/speed-up-rendering-rails-pages-with-render-async.png' alt='render_async' />

  <h1 align="center">👋 Welcome to render_async</h1>

  <h3 align="center">Let's make your Rails pages fast again :racehorse:</h3>

  <br />

  <p align="center">
    <a href="https://www.paypal.me/nikolalsvk/10" target="_blank">
     <img src="https://img.shields.io/badge/$-support-green.svg" alt="Donate" />
    </a>
    <a href="https://rubygems.org/gems/render_async" target="_blank">
      <img src="https://img.shields.io/gem/dt/render_async" alt="Downloads" />
    </a>
    <a href="#contributors" target="_blank">
     <img src="https://img.shields.io/github/all-contributors/renderedtext/render_async" alt="All contributors" />
    </a>
    <a href="https://badge.fury.io/rb/render_async" target="_blank">
     <img src="https://badge.fury.io/rb/render_async.svg" alt="Gem Version" />
    </a>
    <br />
    <a href="https://discord.gg/SPfbeRm" target="_blank">
      <img src="https://img.shields.io/discord/738783603214909521" alt="Discord Server" />
    </a>
    <a href="https://semaphoreci.com/renderedtext/render_async" target="_blank">
     <img src="https://semaphoreci.com/api/v1/renderedtext/render_async/branches/master/shields_badge.svg" alt="Build Status" />
    </a>
    <a href="https://codeclimate.com/github/renderedtext/render_async" target="_blank">
     <img src="https://img.shields.io/codeclimate/maintainability/renderedtext/render_async" alt="Code Climate Maintainablity" />
    </a>
    <a href="https://codeclimate.com/github/renderedtext/render_async/coverage" target="_blank">
     <img src="https://img.shields.io/codeclimate/coverage/renderedtext/render_async" alt="Test Coverage" />
    </a>
    <a href="https://github.com/renderedtext/render_async/blob/master/LICENSE" target="_blank">
      <img src="https://img.shields.io/github/license/renderedtext/render_async" alt="License" />
    </a>
    <a href="https://www.codetriage.com/renderedtext/render_async" target="_blank">
     <img src="https://www.codetriage.com/renderedtext/render_async/badges/users.svg" alt="Help Contribute to Open Source" />
    </a>
  </p>
</p>

### `render_async` is here to make your pages show faster to users.

Pages become faster seamlessly by rendering partials to your views.

Partials render **asynchronously** and let users see your page **faster**
than using regular rendering.

It works with Rails and its tools out of the box.

:sparkles:  A quick overview of how `render_async` does its magic:

1. user visits a page
2. `render_async` makes an AJAX request on the controller action
3. controller renders a partial
4. partial renders in the place where you put `render_async` view helper

JavaScript is injected straight into `<%= content_for :render_async %>` so you choose
where to put it.

:mega:  P.S. Join our [Discord channel](https://discord.gg/SPfbeRm) for help and discussion, and let's make `render_async` even better!

## :package: Installation

Add this line to your application's Gemfile:

```ruby
gem 'render_async'
```

And then execute:

    $ bundle install

## :hammer: Usage

1. Include `render_async` view helper somewhere in your views (e.g. `app/views/comments/show.html.erb`):
    ```erb
    <%= render_async comment_stats_path %>
    ```

2. Then create a route for it `config/routes.rb`:
    ```ruby
    get :comment_stats, controller: :comments
    ```

3. Fill in the logic in your controller (e.g. `app/controllers/comments_controller.rb`):
    ```ruby
    def comment_stats
      @stats = Comment.get_stats

      render partial: "comment_stats"
    end
    ```

4. Create a partial that will render (e.g. `app/views/comments/_comment_stats.html.erb`):
    ```erb
    <div class="col-md-6">
      <%= @stats %>
    </div>
    ```

5. Add `content_for` in your base view file in the body part (e.g. `app/views/layouts/application.html.erb`):
    ```erb
    <%= content_for :render_async %>
    ```

## :hammer_and_wrench: Advanced usage

Advanced usage includes information on different options, such as:

  - [Passing in a container ID](#passing-in-a-container-id)
  - [Passing in a container class name](#passing-in-a-container-class-name)
  - [Passing in HTML options](#passing-in-html-options)
  - [Passing in an HTML element name](#passing-in-an-html-element-name)
  - [Passing in a placeholder](#passing-in-a-placeholder)
  - [Passing in an event name](#passing-in-an-event-name)
  - [Using default events](#using-default-events)
  - [Refreshing the partial](#refreshing-the-partial)
  - [Retry on failure](#retry-on-failure)
    - [Retry after some time](#retry-after-some-time)
  - [Toggle event](#toggle-event)
    - [Control polling with a toggle](#control-polling-with-a-toggle)
  - [Polling](#polling)
  - [Controlled polling](#controlled-polling)
  - [Handling errors](#handling-errors)
  - [Caching](#caching)
  - [Doing non-GET requests](#doing-non-get-requests)
  - [Using with Turbolinks](#using-with-turbolinks)
  - [Using with Turbo](#using-with-turbo)
  - [Using with respond_to and JS format](#using-with-respond_to-and-js-format)
  - [Nested async renders](#nested-async-renders)
  - [Customizing the content_for name](#customizing-the-content_for-name)
  - [Configuration options](#configuration-options)

### Passing in a container ID

`render_async` renders an element that gets replaced with the content
of your request response. In order to have more control over the element
that renders first (before the request), you can set the ID of that element.

To set ID of the container element, you can do the following:
```erb
<%= render_async users_path, container_id: 'users-container' %>
```

Rendered code in the view:
```html
<div id="users-container">
</div>

...
```

### Passing in a container class name

`render_async` renders an element that gets replaced with the content of your
request response. If you want to style that element, you can set the class name
on it.

```erb
<%= render_async users_path, container_class: 'users-container-class' %>
```

Rendered code in the view:
```html
<div id="render_async_18b8a6cd161499117471" class="users-container-class">
</div>

...
```

### Passing in HTML options

`render_async` can accept `html_options` as a hash.
`html_options` is an optional hash that gets passed to a Rails'
`javascript_tag`, to drop HTML tags into the `script` element.

Example of utilizing `html_options` with a [nonce](https://edgeguides.rubyonrails.org/security.html#content-security-policy):

```erb
<%= render_async users_path, html_options: { nonce: true } %>
```

Rendered code in the view:
```html
<script nonce="2x012CYGxKgM8qAApxRHxA==">
//<![CDATA[
  ...
//]]>
</script>

...

<div id="render_async_18b8a6cd161499117471" class="">
</div>
```

> :bulb:  You can enable `nonce` to be set everywhere by using [configuration option](#configuration-options) render_async provides.

### Passing in an HTML element name

`render_async` can take in an HTML element name, allowing you to control
what type of container gets rendered. This can be useful when you're using
[`render_async` inside a table](https://github.com/renderedtext/render_async/issues/12)
and you need it to render a `tr` element before your request gets loaded, so
your content doesn't get pushed out of the table.

Example of using HTML element name:
```erb
<%= render_async users_path, html_element_name: 'tr' %>
```

Rendered code in the view:
```html
<tr id="render_async_04229e7abe1507987376">
</tr>
...
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

`render_async` can receive `:event_name` option which will emit JavaScript
event after it's done with fetching and rendering request content to HTML.

This can be useful to have if you want to add some JavaScript functionality
after your partial is loaded through `render_async`.

You can also access the associated container (DOM node) in the event object
that gets emitted.

Example of passing it to `render_async`:
```erb
<%= render_async users_path, event_name: "users-loaded" %>
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

Then, in your JavaScript code, you could do something like this:
```javascript
document.addEventListener("users-loaded", function(event) {
  console.log("Users have loaded!", event.container); // Access the container which loaded the users
});
```

> :bulb: Dispatching events is also supported for older browsers that don't support Event constructor.

### Using default events

`render_async` will fire the event `render_async_load` when an async partial
has loaded and rendered on the page.

In case there is an error, the event `render_async_error` will fire instead.

This event will fire for all `render_async` partials on the page. For every
event, the associated container (DOM node) will be passed along.

This can be useful to apply JavaScript to content loaded after the page is
ready.

Example of using events:

```js
// Vanilla javascript
document.addEventListener('render_async_load', function(event) {
  console.log('Async partial loaded in this container:', event.container);
});
document.addEventListener('render_async_error', function(event) {
  console.log('Async partial could not load in this container:', event.container);
});

// with jQuery
$(document).on('render_async_load', function(event) {
  console.log('Async partial loaded in this container:', event.container);
});
$(document).on('render_async_error', function(event) {
  console.log('Async partial could not load in this container:', event.container);
});
```

### Refreshing the partial

`render_async` lets you refresh (reload) the partial by letting you dispatch
the 'refresh' event on the `render_async`'s container. An example:

```erb
<%= render_async comments_path,
                 container_id: 'refresh-me',
                 replace_container: false %>

<button id="refresh-button">Refresh comments</button>

<script>
  var button = document.getElementById('refresh-button')
  var container = document.getElementById('refresh-me');

  button.addEventListener('click', function() {
    var event = new Event('refresh');

    // Dispatch 'refresh' on the render_async container
    container.dispatchEvent(event)
  })
</script>
```

If you follow the example above, when you click "Refresh comments" button,
`render_async` will trigger again and reload the `comments_path`.

> :bulb:  Note that you need to pass `replace_container: false` so you can later dispatch an event on that container.

### Retry on failure

`render_async` can retry your requests if they fail for some reason.

If you want `render_async` to retry a request for number of times, you can do
this:
```erb
<%= render_async users_path, retry_count: 5, error_message: "Couldn't fetch it" %>
```

Now render_async will retry `users_path` for 5 times. If it succeeds in
between, it will stop with dispatching requests. If it fails after 5 times,
it will show an [error message](#handling-errors) which you need to specify.

This can show useful when you know your requests often fail, and you don't want
to refresh the whole page just to retry them.

#### Retry after some time

If you want to retry requests but with some delay in between the calls, you can
pass a `retry_delay` option together with `retry_count` like so:

```erb
<%= render_async users_path,
                 retry_count: 5,
                 retry_delay: 2000 %>
```

This will make `render_async` wait for 2 seconds before retrying after each
failure. In the end, if the request is still failing after 5th time, it will
dispatch a [default error event](#using-default-events).

> :candy:  If you are catching an event after an error, you can get `retryCount` from
the event. `retryCount` will have the number of retries it took before the event was dispatched.

Here is an example on how to get `retryCount`:

```erb
<%= render_async users_path,
                 retry_count: 5,
                 retry_delay: 2000,
                 error_event_name: 'it-failed-badly' %>

<script>
  document.addEventListener('it-failed-badly', function(event) {
    console.log("Request failed after " + event.retryCount + " tries!")
  });
</script>
```

If you need to pass retry count to the backend, you can pass `retry_count_header` in `render_async`'s options:

```erb
<%= render_async users_path,
                 retry_count: 5,
                 retry_count_header: 'Retry-Count-Current' %>
```

And then in controller you can read the value from request headers.

```
request.headers['Retry-Count-Current']&.to_i
```

### Toggle event

You can trigger `render_async` loading by clicking or doing another event to a
certain HTML element. You can do this by passing in a selector and an event
name which will trigger `render_async`. If you don't specify an event name, the
default event that will trigger `render_async` will be 'click' event. You can
do this by doing the following:

```erb
<a href='#' id='comments-button'>Load comments</a>
<%= render_async comments_path, toggle: { selector: '#comments-button', event: :click } %>
```

This will trigger `render_async` to load the `comments_path` when you click the `#comments-button` element.
If you want to remove an event once it's triggered, you can pass `once: true` in the toggle options.
The `once` option is false (`nil`) by default.

You can also pass in a placeholder before the `render_async` is triggered. That
way, the element that started `render_async` logic will be removed after the
request has been completed. You can achieve this behaviour with something like this:

```erb
<%= render_async comments_path, toggle: { selector: '#comments-button', event: :click } do %>
  <a href='#' id='comments-button'>Load comments</a>
<% end %>
```

#### Control polling with a toggle

Also, you can mix interval and toggle features. This way, you can turn polling
on, and off by clicking the "Load comments" button. In order to do this, you need to
pass `toggle` and `interval` arguments to `render_async` call like this:

```erb
<a href='#' id='comments-button'>Load comments</a>
<%= render_async comments_path, toggle: { selector: '#comments-button', event: :click }, interval: 2000 %>
```

If you want `render_async` to render the request on load, you can pass `start:
true`. Passing the `start` option inside the `toggle` hash will trigger
`render_async` on page load. You can then toggle off polling by interacting
with the element you specified. An example:

```erb
<a href='#' id='comments-button'>Toggle comments loading</a>
<%= render_async comments_path,
                 toggle: { selector: '#comments-button',
                           event: :click,
                           start: true },
                 interval: 2000 %>
```

In the example above, the comments will load as soon as the page is rendered.
Then, you can stop polling for comments by clicking the "Toggle comments
loading" button.

### Polling

You can call `render_async` with interval argument. This will make render_async
call specified path at the specified interval.

By doing this:
```erb
<%= render_async comments_path, interval: 5000 %>
```
You are telling `render_async` to fetch comments_path every 5 seconds.

This can be handy if you want to enable polling for a specific URL.

> :warning:  By passing interval to `render_async`, the initial container element
> will remain in the HTML tree and it will not be replaced with request response.
> You can handle how that container element is rendered and its style by
> [passing in an HTML element name](#passing-in-an-html-element-name) and
> [HTML element class](#passing-in-a-container-class-name).

### Controlled polling

You can controller `render_async` [polling](#polling) in 2 manners.
First one is pretty simple, and it involves using the [toggle](#toggle-event)
feature. To do this, you can follow instructions in the
[control polling with a toggle section](#control-polling-with-a-toggle).

The second option is more advanced and it involves emitting events to the `render_async`'s
container element. From your code, you can emit the following events:
  - 'async-stop' - this will stop polling
  - 'async-start' - this will start polling.

> :bulb:  Please note that events need to be dispatched to a render_async container.

An example of how you can do this looks like this:

```erb
<%= render_async wave_render_async_path,
                 container_id: 'controllable-interval', # set container_id so we can get it later easily
                 interval: 3000 %>

<button id='stop-polling'>Stop polling</button>
<button id='start-polling'>Start polling</button>

<script>
  var container = document.getElementById('controllable-interval')
  var stopPolling = document.getElementById('stop-polling')
  var startPolling = document.getElementById('start-polling')

  var triggerEventOnContainer = function(eventName) {
    var event = new Event(eventName);

    container.dispatchEvent(event)
  }

  stopPolling.addEventListener('click', function() {
    container.innerHTML = '<p>Polling stopped</p>'
    triggerEventOnContainer('async-stop')
  })
  startPolling.addEventListener('click', function() {
    triggerEventOnContainer('async-start')
  })
</script>
```

We are rendering two buttons - "Stop polling" and "Start polling". Then, we
attach an event listener to catch any clicking on the buttons. When the buttons
are clicked, we either stop the polling or start the polling, depending on which
button a user clicks.

### Handling errors

`render_async` lets you handle errors by allowing you to pass in `error_message`
and `error_event_name`.

- `error_message`

  passing an `error_message` will render a message if the AJAX requests fails for
  some reason
  ```erb
  <%= render_async users_path,
                   error_message: '<p>Sorry, users loading went wrong :(</p>' %>
  ```

- `error_event_name`

  calling `render_async` with `error_event_name` will dispatch event in the case
  of an error with your AJAX call.
  ```erb
  <%= render_asyc users_path, error_event_name: 'users-error-event' %>
  ```

  You can then catch the event in your code with:
  ```js
  document.addEventListener('users-error-event', function() {
    // I'm on it
  })
  ```

### Caching

`render_async` can utilize view fragment caching to avoid extra AJAX calls.

In your views (e.g. `app/views/comments/show.html.erb`):
```erb
# note 'render_async_cache' instead of standard 'render_async'
<%= render_async_cache comment_stats_path %>
```

Then, in the partial (e.g. `app/views/comments/_comment_stats.html.erb`):
```erb
<% cache render_async_cache_key(request.path), skip_digest: true do %>
  <div class="col-md-6">
    <%= @stats %>
  </div>
<% end %>
```

- The first time the page renders, it will make the AJAX call.
- Any other times (until the cache expires), it will render from cache
  instantly, without making the AJAX call.
- You can expire cache simply by passing `:expires_in` in your view where
  you cache the partial

### Doing non-GET requests

By default, `render_async` creates AJAX GET requests for the path you provide.
If you want to change this behaviour, you can pass in a `method` argument to
`render_async` view helper.

```erb
<%= render_async users_path, method: 'POST' %>
```

You can also set `body` and `headers` of the request if you need them.

```erb
<%= render_async users_path,
                 method: 'POST',
                 data: { fresh: 'AF' },
                 headers: { 'Content-Type': 'text' } %>
```

### Using with Turbolinks

On Turbolinks applications, you may experience caching issues when navigating
away from, and then back to, a page with a `render_async` call on it. This will
likely show up as an empty div.

If you're using Turbolinks 5 or higher, you can resolve this by setting Turbolinks
configuration of `render_async` to true:

```rb
RenderAsync.configure do |config|
  config.turbolinks = true # Enable this option if you are using Turbolinks 5+
end
```

This way, you're not breaking Turbolinks flow of loading or reloading a page.
It is more efficient than the next option below.

Another option:
If you want, you can tell Turbolinks to reload your `render_async` call as follows:

```erb
<%= render_async events_path, html_options: { 'data-turbolinks-track': 'reload' } %>
```

This will reload the whole page with Turbolinks.

> :bulb:  If Turbolinks is misbehaving in some way, make sure to put `<%= content_for :render_async %>` in your base view file in
the `<body>` and not the `<head>`.

### Using with Turbo

On Turbo applications, you may experience caching issues when navigating
away from, and then back to, a page with a `render_async` call on it. This will
likely show up as an empty div.

If you're using Turbo, you can resolve this by setting Turbo
configuration of `render_async` to true:

```rb
RenderAsync.configure do |config|
  config.turbo = true # Enable this option if you are using Turbo
end
```

This way, you're not breaking Turbos flow of loading or reloading a page.
It is more efficient than the next option below.

Another option:
If you want, you can tell Turbo to reload your `render_async` call as follows:

```erb
<%= render_async events_path, html_options: { 'data-turbo-track': 'reload' } %>
```

This will reload the whole page with Turbo.

> :bulb:  If Turbo is misbehaving in some way, make sure to put `<%= content_for :render_async %>` in your base view file in
the `<body>` and not the `<head>`.

### Using with respond_to and JS format

If you need to restrict the action to only respond to AJAX requests, you'll
likely wrap it inside `respond_to`/`format.js` blocks like this:

```ruby
def comment_stats
  respond_to do |format|
    format.js do
      @stats = Comment.get_stats

      render partial: "comment_stats"
    end
  end
end
```

When you do this, Rails will sometimes set the response's `Content-Type` header
to `text/javascript`. This causes the partial not to be rendered in the HTML.
This usually happens when there's browser caching.

You can get around it by specifying the content type to `text/html` in the
render call:

```ruby
render partial: "comment_stats", content_type: 'text/html'
```

### Nested async renders

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

### Customizing the content_for name

The `content_for` name may be customized by passing the `content_for_name`
option to `render_async`. This option is especially useful when doing [nested async
renders](#nested-async-renders) to better control the location of the injected JavaScript.

For example:
```erb
<%= render_async comment_stats_path, content_for_name: :render_async_comment_stats %>

<%= content_for :render_async_comment_stats %>
```

### Configuration options

`render_async` renders Vanilla JS (regular JavaScript, non-jQuery code)
**by default** in order to fetch the request from the server.

If you want `render_async` to use jQuery code, you need to configure it to do
so.

You can configure it by doing the following anywhere before you call
`render_async`:

```rb
RenderAsync.configure do |config|
  config.jquery = true # This will render jQuery code, and skip Vanilla JS code. The default value is false.
  config.turbolinks = true # Enable this option if you are using Turbolinks 5+. The default value is false.
  config.turbo = true # Enable this option if you are using Turbo. The default value is false.
  config.replace_container = false # Set to false if you want to keep the placeholder div element from render_async. The default value is true.
  config.nonces = true # Set to true if you want render_async's javascript_tag always to receive nonce: true. The default value is false.
end
```

Also, you can do it like this:
```rb
# This will render jQuery code, and skip Vanilla JS code
RenderAsync.configuration.jquery = true
```

Aside from configuring whether the gem relies on jQuery or VanillaJS, you can
configure other options:

- `turbolinks` option - If you are using Turbolinks 5+, you should enable this option since it supports Turbolinks way of loading data. The default value for this option is false.
- `turbo` option - If you are using Turbo, you should enable this option since it supports Turbo way of loading data. The default value for this option is false.
- `replace_container` option - If you want render_async to replace its container with the request response, turn this on. You can turn this on globally for all render_async calls, but if you use this option in a specific render_async call, it will override the global configuration. The default value is true.
- `nonces` - If you need to pass in `nonce: true` to the `javascript_tag` in your application, it might make sense for you to turn this on globally for all render_async calls. To read more about nonces, check out [Rails' official guide on security](https://edgeguides.rubyonrails.org/security.html). The default value is false.

## :hammer_and_pick: Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment. To run integration tests, use
`bin/integration-tests`. For more information, check out [CONTRIBUTING](.github/CONTRIBUTING.md) file, please.

Got any questions or comments about development (or anything else)?
Join [render_async's Discord channel](https://discord.gg/SPfbeRm)
and let's make `render_async` even better!

## :pray: Contributing

Check out [CONTRIBUTING](.github/CONTRIBUTING.md) file, please.

Got any issues or difficulties?
Join [render_async's Discord channel](https://discord.gg/SPfbeRm)
and let's make `render_async` even better!

## :memo: License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Contributors

Thanks goes to these wonderful people ([emoji key](https://github.com/kentcdodds/all-contributors#emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore -->
| [<img src="https://avatars2.githubusercontent.com/u/3028124?v=4" width="100px;"/><br /><sub><b>Nikola Đuza</b></sub>](https://nikolalsvk.github.io)<br />[💬](#question-nikolalsvk "Answering Questions") [💻](https://github.com/renderedtext/render_async/commits?author=nikolalsvk "Code") [📖](https://github.com/renderedtext/render_async/commits?author=nikolalsvk "Documentation") [👀](#review-nikolalsvk "Reviewed Pull Requests") | [<img src="https://avatars0.githubusercontent.com/u/3866868?v=4" width="100px;"/><br /><sub><b>Colin</b></sub>](http://www.colinxfleming.com)<br />[💻](https://github.com/renderedtext/render_async/commits?author=colinxfleming "Code") [📖](https://github.com/renderedtext/render_async/commits?author=colinxfleming "Documentation") [💡](#example-colinxfleming "Examples") | [<img src="https://avatars2.githubusercontent.com/u/334273?v=4" width="100px;"/><br /><sub><b>Kasper Grubbe</b></sub>](http://kaspergrubbe.com)<br />[💻](https://github.com/renderedtext/render_async/commits?author=kaspergrubbe "Code") | [<img src="https://avatars2.githubusercontent.com/u/163584?v=4" width="100px;"/><br /><sub><b>Sai Ram Kunala</b></sub>](https://sairam.xyz/)<br />[📖](https://github.com/renderedtext/render_async/commits?author=sairam "Documentation") | [<img src="https://avatars2.githubusercontent.com/u/3065882?v=4" width="100px;"/><br /><sub><b>Josh Arnold</b></sub>](https://github.com/nightsurge)<br />[💻](https://github.com/renderedtext/render_async/commits?author=nightsurge "Code") [📖](https://github.com/renderedtext/render_async/commits?author=nightsurge "Documentation") | [<img src="https://avatars3.githubusercontent.com/u/107798?v=4" width="100px;"/><br /><sub><b>Elad Shahar</b></sub>](https://eladshahar.com)<br />[💻](https://github.com/renderedtext/render_async/commits?author=SaladFork "Code") [💡](#example-SaladFork "Examples") | [<img src="https://avatars3.githubusercontent.com/u/232392?v=4" width="100px;"/><br /><sub><b>Sasha</b></sub>](http://www.revzin.co.il)<br />[💻](https://github.com/renderedtext/render_async/commits?author=sasharevzin "Code") [📖](https://github.com/renderedtext/render_async/commits?author=sasharevzin "Documentation") |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| [<img src="https://avatars3.githubusercontent.com/u/50223?v=4" width="100px;"/><br /><sub><b>Ernest Surudo</b></sub>](http://elsurudo.com)<br />[💻](https://github.com/renderedtext/render_async/commits?author=elsurudo "Code") | [<img src="https://avatars1.githubusercontent.com/u/334809?v=4" width="100px;"/><br /><sub><b>Kurtis Rainbolt-Greene</b></sub>](https://kurtis.rainbolt-greene.online)<br />[💻](https://github.com/renderedtext/render_async/commits?author=krainboltgreene "Code") | [<img src="https://avatars2.githubusercontent.com/u/59744?v=4" width="100px;"/><br /><sub><b>Richard Schneeman</b></sub>](https://www.schneems.com)<br />[📖](https://github.com/renderedtext/render_async/commits?author=schneems "Documentation") | [<img src="https://avatars1.githubusercontent.com/u/75705?v=4" width="100px;"/><br /><sub><b>Richard Venneman</b></sub>](https://www.cityspotters.com)<br />[📖](https://github.com/renderedtext/render_async/commits?author=richardvenneman "Documentation") | [<img src="https://avatars3.githubusercontent.com/u/381395?v=4" width="100px;"/><br /><sub><b>Filipe W. Lima</b></sub>](https://github.com/filipewl)<br />[📖](https://github.com/renderedtext/render_async/commits?author=filipewl "Documentation") | [<img src="https://avatars0.githubusercontent.com/u/3135638?v=4" width="100px;"/><br /><sub><b>Jesús Eduardo Clemens Chong</b></sub>](https://github.com/eclemens)<br />[💻](https://github.com/renderedtext/render_async/commits?author=eclemens "Code") | [<img src="https://avatars3.githubusercontent.com/u/1935686?v=4" width="100px;"/><br /><sub><b>René Klačan</b></sub>](https://github.com/reneklacan)<br />[💻](https://github.com/renderedtext/render_async/commits?author=reneklacan "Code") [📖](https://github.com/renderedtext/render_async/commits?author=reneklacan "Documentation") |
| [<img src="https://avatars1.githubusercontent.com/u/1313442?v=4" width="100px;"/><br /><sub><b>Gil Gomes</b></sub>](http://gilgomes.com.br)<br />[📖](https://github.com/renderedtext/render_async/commits?author=gil27 "Documentation") | [<img src="https://avatars0.githubusercontent.com/u/6081795?v=4" width="100px;"/><br /><sub><b>Khoa Nguyen</b></sub>](https://github.com/ThanhKhoaIT)<br />[💻](https://github.com/renderedtext/render_async/commits?author=ThanhKhoaIT "Code") [📖](https://github.com/renderedtext/render_async/commits?author=ThanhKhoaIT "Documentation") | [<img src="https://avatars2.githubusercontent.com/u/8645918?v=4" width="100px;"/><br /><sub><b>Preet Sethi</b></sub>](https://www.linkedin.com/in/preetsethila/)<br />[💻](https://github.com/renderedtext/render_async/commits?author=preetsethi "Code") | [<img src="https://avatars3.githubusercontent.com/u/11586335?v=4" width="100px;"/><br /><sub><b>fangxing</b></sub>](https://github.com/fffx)<br />[💻](https://github.com/renderedtext/render_async/commits?author=fffx "Code") | [<img src="https://avatars3.githubusercontent.com/u/1191418?v=4" width="100px;"/><br /><sub><b>Emmanuel Pire</b></sub>](http://blog.lipsumarium.com)<br />[💻](https://github.com/renderedtext/render_async/commits?author=lipsumar "Code") [📖](https://github.com/renderedtext/render_async/commits?author=lipsumar "Documentation") | [<img src="https://avatars1.githubusercontent.com/u/615509?v=4" width="100px;"/><br /><sub><b>Maxim Geerinck</b></sub>](https://github.com/maximgeerinck)<br />[💻](https://github.com/renderedtext/render_async/commits?author=maximgeerinck "Code") | [<img src="https://avatars1.githubusercontent.com/u/251706?v=4" width="100px;"/><br /><sub><b>Don</b></sub>](https://github.com/vanboom)<br />[💻](https://github.com/renderedtext/render_async/commits?author=vanboom "Code") |
| [<img src="https://avatars0.githubusercontent.com/u/998682?v=4" width="100px;"/><br /><sub><b>villu164</b></sub>](https://github.com/villu164)<br />[📖](https://github.com/renderedtext/render_async/commits?author=villu164 "Documentation") | [<img src="https://avatars.githubusercontent.com/u/11203679?v=4" width="100px;"/><br /><sub><b>Mitchell Buckley</b></sub>](https://github.com/Mbuckley0)<br />[💻](https://github.com/renderedtext/render_async/commits?author=Mbuckley0 "Code") [📖](https://github.com/renderedtext/render_async/commits?author=Mbuckley0 "Documentation") | [<img src="https://avatars.githubusercontent.com/u/15371677?v=4" width="100px;"/><br /><sub><b>yhirano55</b></sub>](https://github.com/yhirano55)<br />[💻](https://github.com/renderedtext/render_async/commits?author=yhirano55 "Code") [📖](https://github.com/renderedtext/render_async/commits?author=yhirano55 "Documentation") |
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/kentcdodds/all-contributors) specification. Contributions of any kind welcome!
