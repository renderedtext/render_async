### 2.1.10 (2021/03/21)

* [#146](https://github.com/renderedtext/render_async/pull/146): Add comment when we check if container is present - [@nikolalsvk](https://github.com/nikolalsvk).
* [#145](https://github.com/renderedtext/render_async/pull/145): Wrap html_options for turbolinks - [@yhirano55](https://github.com/yhirano55).
* [#144](https://github.com/renderedtext/render_async/pull/144): Avoid TypeError if container has already disappear - [@yhirano55](https://github.com/yhirano55).

### 2.1.9 (2021/02/23)

* [#142](https://github.com/renderedtext/render_async/pull/142): Update Turbolinks docs - [@nikolalsvk](https://github.com/nikolalsvk).
* [#141](https://github.com/renderedtext/render_async/pull/141): Add Support for Turbo - [@MBuckley0](https://github.com/Mbuckley0).
* [#139](https://github.com/renderedtext/render_async/pull/139): Fix readme configuration-options anchor - [@richardvenneman](https://github.com/richardvenneman).
* [#138](https://github.com/renderedtext/render_async/pull/138): Add Rails 6 base app as a fixture - [@nikolalsvk](https://github.com/nikolalsvk).
* [#137](https://github.com/renderedtext/render_async/pull/137): Rename config - [@nikolalsvk](https://github.com/nikolalsvk).

### 2.1.8 (2020/10/24)

* [#134](https://github.com/renderedtext/render_async/pull/134): Add config option for setting nonce - [@nikolalsvk](https://github.com/nikolalsvk).
* [#132](https://github.com/renderedtext/render_async/pull/132): Refresh render_async with an event - [@nikolalsvk](https://github.com/nikolalsvk).
* [#131](https://github.com/renderedtext/render_async/pull/131): Start to poll on page load with toggle - [@nikolalsvk](https://github.com/nikolalsvk).
* [#130](https://github.com/renderedtext/render_async/pull/130): Set up control events after document loaded - [@nikolalsvk](https://github.com/nikolalsvk).
* [#127](https://github.com/renderedtext/render_async/pull/127): Update README.md, to reflect correct turbolinks configuration value - [@villu164](https://github.com/villu164).

### 2.1.7 (2020/8/1)

* [#125](https://github.com/renderedtext/render_async/pull/125): Implement retry after some time feature - [@nikolalsvk](https://github.com/nikolalsvk).
* [#124](https://github.com/renderedtext/render_async/pull/124): Add more info on how to control polling - [@nikolalsvk](https://github.com/nikolalsvk).
* [#123](https://github.com/renderedtext/render_async/pull/123): Simplify calling of start and stop event when interval is defined - [@nikolalsvk](https://github.com/nikolalsvk).
* [#119](https://github.com/renderedtext/render_async/pull/119): Add polling control start/stop events - [@vanboom](https://github.com/vanboom).
* [#120](https://github.com/renderedtext/render_async/pull/120): Fine tune custom content_for feature - [@nikolalsvk](https://github.com/nikolalsvk).
* [#117](https://github.com/renderedtext/render_async/pull/117): Allow a custom content_for name - [@vanboom](https://github.com/vanboom).

### 2.1.6 (2020/5/9)

* [#114](https://github.com/renderedtext/render_async/pull/114): Call render_async logic if document state is ready or interactive - [@nikolalsvk](https://github.com/nikolalsvk).
* [#113](https://github.com/renderedtext/render_async/pull/113): Remove interval after Turbolinks visit event - [@nikolalsvk](https://github.com/nikolalsvk).
* [#112](https://github.com/renderedtext/render_async/pull/112): Add X-Requested-With header in Vanilla JS - [@nikolalsvk](https://github.com/nikolalsvk).
* [#110](https://github.com/renderedtext/render_async/pull/110): Remove preventDefault, and load toggle in stream - [@vanboom](https://github.com/vanboom).

### 2.1.5 (2020/3/22)

* [#105](https://github.com/renderedtext/render_async/pull/105): Load toggle listeners after page loads - [@nikolalsvk](https://github.com/nikolalsvk).
* [#104](https://github.com/renderedtext/render_async/pull/104): Attach container to dispatched events - [@nikolalsvk](https://github.com/nikolalsvk).
* [#103](https://github.com/renderedtext/render_async/pull/103): Add generic "load" and "error" events - [@lipsumar](https://github.com/lipsumar).
* [#98](https://github.com/renderedtext/render_async/pull/98): Bump nonce pattern in the README to follow Rails CSP standard - [@colinxfleming](https://github.com/colinxfleming).

### 2.1.4 (2019/11/11)

* [#96](https://github.com/renderedtext/render_async/pull/96): Add once option to remove event once it's triggered #94 - [@fffx](https://github.com/fffx).

### 2.1.3 (2019/9/24)

* [#95](https://github.com/renderedtext/render_async/pull/95): Use double quotes for displaying error message - [@nikolalsvk](https://github.com/nikolalsvk).
* [#93](https://github.com/renderedtext/render_async/pull/93): Fix: "Uncaught ReferenceError: \_interval" #92 - [@fffx](https://github.com/fffx).

### 2.1.2 (2019/8/17)

* [#89](https://github.com/renderedtext/render_async/pull/89): Bump version to 2.1.2 - [@nikolalsvk](https://github.com/nikolalsvk).
* [#82](https://github.com/renderedtext/render_async/pull/88): When toggle true, do not fire `_renderAsyncFunc` on `turbolinks:load` - [@ThanhKhoaIT](https://github.com/ThanhKhoaIT).

### 2.1.1 (2019/8/17)

* [#85](https://github.com/renderedtext/render_async/pull/85): Rename main JS function and support toggle feature with other features - [@nikolalsvk](https://github.com/nikolalsvk).
* [#82](https://github.com/renderedtext/render_async/pull/82): Add toggle selector and event to render - [@ThanhKhoaIT](https://github.com/ThanhKhoaIT).
* DEPRECATION WARNING - html_options is now a hash that you pass to render_async instead of an argument. If you passed for example a nonce: '21312aas...', you will need to pass
  html_options: { nonce: '21312aas...' }

### 2.1.0 (2019/5/6)

* [#77](https://github.com/renderedtext/render_async/pull/77): Call render_async logic every N seconds - [@nikolalsvk](https://github.com/nikolalsvk).
* [#76](https://github.com/renderedtext/render_async/pull/76): Retry render_async on failure - [@nikolalsvk](https://github.com/nikolalsvk).

### 2.0.2 (2019/1/4)

* [#74](https://github.com/renderedtext/render_async/pull/74): Remove bundler as a dependency - [@nikolalsvk](https://github.com/nikolalsvk).

### 2.0.1 (2018/12/10)

* [#69](https://github.com/renderedtext/render_async/pull/69): Adding CHANGELOG.md - [@gil27](https://github.com/gil27).
* [#66](https://github.com/renderedtext/render_async/pull/66): Adding support for Turbolinks 5+ - [@eclemens](https://github.com/eclemens).
* [#65](https://github.com/renderedtext/render_async/pull/65): Invalid jQuery Promise method name - [@eclemens](https://github.com/eclemens).

### 2.0.0 (2018/10/06)

* [#64](https://github.com/renderedtext/render_async/pull/64): Document new features - [@nikolalsvk](https://github.com/nikolalsvk).
* [#63](https://github.com/renderedtext/render_async/pull/63): Configure gem - [@nikolalsvk](https://github.com/nikolalsvk).
* [#62](https://github.com/renderedtext/render_async/pull/62): Handle request errorss - [@nikolalsvk](https://github.com/nikolalsvk).
* [#61](https://github.com/renderedtext/render_async/pull/61): Add option to pass in container_class and container_id - [@nikolalsvk](https://github.com/nikolalsvk).
* [#60](https://github.com/renderedtext/render_async/pull/60): Support event creation in IE - [@nikolalsvk](https://github.com/nikolalsvk).

### 1.3.0 (2018/10/06)

* [#58](https://github.com/renderedtext/render_async/pull/58): Tune different method requests - [@nikolalsvk](https://github.com/nikolalsvk).
* [#52](https://github.com/renderedtext/render_async/pull/52): Configurable AJAX method, headers and body - [@reneklacan](https://github.com/reneklacan).
* [#54](https://github.com/renderedtext/render_async/pull/54): Add recipe for using with respond_to/format.js - [@filipewl](https://github.com/filipewl).
* [#50](https://github.com/renderedtext/render_async/pull/50): Add Turbolinks usage note- [@richardvenneman](https://github.com/richardvenneman).

### 1.2.0 (2018/01/25)

* [#49](https://github.com/renderedtext/render_async/pull/49): Pass in html_element_name - [@nikolalsvk](https://github.com/nikolalsvk).
* [#48](https://github.com/renderedtext/render_async/pull/48): Move JS code to a partial - [@nikolalsvk](https://github.com/nikolalsvk).
* [#47](https://github.com/renderedtext/render_async/pull/47): Trigger request when document is ready - [@nikolalsvk](https://github.com/nikolalsvk).
* [#36](https://github.com/renderedtext/render_async/pull/36): Update README with instructions for nested async - [@SaladFork](https://github.com/SaladFork).
* [#41](https://github.com/renderedtext/render_async/pull/41): Only bother when the dom is actually ready to be changed - [@krainboltgreene](https://github.com/nikolalsvk).
* [#43](https://github.com/renderedtext/render_async/pull/43): [ci skip] Get more Open Source Helpers - [@schneems](https://github.com/schneems).
* [#42](https://github.com/renderedtext/render_async/pull/42): Integration tests - [@nikolalsvk](https://github.com/nikolalsvk).

### 1.1.3 (2017/11/23)

* [#40](https://github.com/renderedtext/render_async/pull/40): Replace render_async's container with the response data - [@nikolalsvk](https://github.com/nikolalsvk).

### 1.1.2 (2017/11/17)

* [#35](https://github.com/renderedtext/render_async/pull/35): Fix async without jQuery - [@SaladFork](https://github.com/SaladFork).
* [#33](https://github.com/renderedtext/render_async/pull/33): Don't html-escape the path when outputting JS - [@elsurudo](https://github.com/elsurudo).
* [#31](https://github.com/renderedtext/render_async/pull/31): Allow `render_async_cache` to take a placeholder - [@elsurudo](https://github.com/elsurudo).

### 1.1.1 (2017/10/14)

* [#29](https://github.com/renderedtext/render_async/pull/29): Use jQuery if available - [@nikolalsvk](https://github.com/nikolalsvk).

### 1.1.0 (2017/10/14)

* [Fix event name explanation](https://github.com/renderedtext/render_async/commit/bd1ebb7011be6868dce9da76c5db9ca1133ec71d) - [@nikolalsvk](https://github.com/nikolalsvk).
* [#22](https://github.com/renderedtext/render_async/pull/22): Dispatch JS Event when AJAX is finished- [@nikolalsvk](https://github.com/nikolalsvk).

### 1.0.1 (2017/10/14)

* [#28](https://github.com/renderedtext/render_async/pull/28): Make vanilla JS more readable - [@nikolalsvk](https://github.com/nikolalsvk).
* [#25](https://github.com/renderedtext/render_async/pull/25): Convert to vanilla js - [@sasharevzin](https://github.com/sasharevzin).
* [#27](https://github.com/renderedtext/render_async/pull/27): Add turbolinks recipe - [@colinxfleming](https://github.com/colinxfleming).
* [#23](https://github.com/renderedtext/render_async/pull/23): Test placeholder - [@nikolalsvk](https://github.com/nikolalsvk).
* [#21](https://github.com/renderedtext/render_async/pull/21): Add specs for render_async_cache - [@nikolalsvk](https://github.com/nikolalsvk).

### 1.0.0 (2017/09/21)

* [#20](https://github.com/renderedtext/render_async/pull/20): Rename block to placeholder - [@nikolalsvk](https://github.com/nikolalsvk).

### 0.4.1 (2017/09/07)

* [#19](https://github.com/renderedtext/render_async/pull/19): Fix replace with - [@nikolalsvk](https://github.com/nikolalsvk).

### 0.4.0 (2017/09/07)

* [#18](https://github.com/renderedtext/render_async/pull/18): Use replaceWith instead of html - [@nikolalsvk](https://github.com/nikolalsvk).

### 0.3.3 (2017/09/04)

* [#17](https://github.com/renderedtext/render_async/pull/17): Prepare and test caching - [@nikolalsvk](https://github.com/nikolalsvk).
* [#16](https://github.com/renderedtext/render_async/pull/16): Improvements and fixes for cached view - [@nightsurge](https://github.com/nightsurge).
* [#15](https://github.com/renderedtext/render_async/pull/15): Add all contributors - [@nikolalsvk](https://github.com/nikolalsvk).
* [#14](https://github.com/renderedtext/render_async/pull/14): Add view caching support - [@nightsurge](https://github.com/nightsurge).

### 0.2.3 (2017/07/11)

* [#10](https://github.com/renderedtext/render_async/pull/10): Adjust to use javascript_tag and take html_options - [@colinxfleming](https://github.com/colinxfleming).

### 0.1.3 (2017/06/28)

* [#9](https://github.com/renderedtext/render_async/pull/9): Use commit history from kaspergrubbe/render_async - [@nikolalsvk](https://github.com/nikolalsvk).
* [#7](https://github.com/renderedtext/render_async/pull/7): Update README badges - [@nikolalsvk](https://github.com/nikolalsvk).
* [#5](https://github.com/renderedtext/render_async/pull/5): Update README.md - [@nikolalsvk](https://github.com/nikolalsvk).
* [#4](https://github.com/renderedtext/render_async/pull/4): Update installation info - [@nikolalsvk](https://github.com/nikolalsvk).
* [#3](https://github.com/renderedtext/render_async/pull/3): Allow push to rubygems.org - [@nikolalsvk](https://github.com/nikolalsvk).
* [#2](https://github.com/renderedtext/render_async/pull/2): Remove railtie and engine files - [@nikolalsvk](https://github.com/nikolalsvk).
* [#1](https://github.com/renderedtext/render_async/pull/1): Use commit history from kaspergrubbe/render_async - [@nikolalsvk](https://github.com/nikolalsvk).

### 0.0.2 (2013/08/23)

* It is now safe to call the method render_async instead of render_asynk (Billetto namespace issue) - [@kaspergrubbe](https://github.com/kaspergrubbe)

### 0.0.1 (2013/08/23)

* Add a webpage description to the Gemspec - [@kaspergrubbe](https://github.com/kaspergrubbe)
