# :pray: Contributing

Thank you for considering or deciding to contribute, this is much appreciated!
Any kind of bug reports and pull requests are encouraged and welcome on GitHub at
https://github.com/renderedtext/render_async.

## :inbox_tray: Installing dependencies

You can install all needed dependencies by running `bin/setup`.

## :runner: Running RSpec tests

You can run either `rake spec` or `bundle exec rspec` to run all the RSpec tests
in the project.

## :running_woman: Running integration tests

There is a simple command `bin/integration-tests` which sets up 2 submodules,
and runs Cucumber features in them.

There are 2 submodules for render_async. The submodules are Rails 5 and Rails 6
projects which are located in:

  - `spec/fixtures/rails-5-base-app`, and
  - `spec/fixtures/rails-6-base-app`.

You can find [Rails 5 base app here](https://github.com/nikolalsvk/rails-5-base-app/tree/render-async),
and the [Rails 6 base app here](https://github.com/nikolalsvk/rails-6-base-app/tree/render-async).

Each of them have different use cases of render_async defined in `app/views/render_asyncs/_use_cases.html.erb` in their repos.
All the feature tests are inside `features/render_async.feature` and `features/render_async_jquery.feature` files.

If you are adding one or more feature tests or use cases, make sure to make a
PR on those repos as well and include them in the PR on the render_async repo.

## :sos: Need help?

Got any issues or difficulties?
Join [render_async's Discord channel](https://discord.gg/SPfbeRm)
and ask questions there. We will try to respond to you as quickly as possible.
