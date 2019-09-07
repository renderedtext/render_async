function loadAsyncContent(containerId) {
    console.log("aysn ", containerId);

    var element = document.querySelector(containerId);
    var data = element.dataset;

    var path = data.path;
    var method = data.method || 'GET';
    var interval = parseFloat(data.interval || 0);

    var successEvent = data.successEvent;
    var failedEvent = data.errorEvent;
    var retryEvent = data.retryEvent;

    var retryCount = parseInt(data.retryCount || 0);
    var errorMessage = data.errorMessage || '';
    var delayOnError = parseInt(data.delayOnError | 0);
    var lazy = data.lazyLoad;
    var threshold, root, rootMargin;
    var lazyLoadObserver;

    if (!! lazy) {
        lazy = JSON.parse(lazy);
        lazy = true == lazy ? {} : lazy

        threshold = lazy['threshold'] || 0;
        root = lazy['root'];
        rootMargin = lazy['margin'] || '0px';

        if (!! root) {
            root = document.querySelector(root);
        } else {
            root = document.body;
        }
    }

    var lazyLoaded = function (element) {
        element.dataset.lazyLoaded = true;

        if(lazyLoadObserver)
          lazyLoadObserver.unobserve(element);

        lazyLoadObserver=null;
    }

    var isLazyLoaded = function (element) {
        return 'true' === element.dataset.lazyLoaded;
    };

    var fireEvent = function (name) {
       if (name && name.length > 0) {
         var event;
         if (typeof (Event) === 'function')
           event = new Event(name);
         else {
           event = document.createEvent('Event');
           event.initEvent(name, true, true);
         }

         document.dispatchEvent(event);
       }
    }

    var success = function(response){
        if(!! lazy) lazyLoaded(element);

        element.classList.remove('render-async');

        //TODO: remove jquery dependency
        if (interval) {
            $(element).empty().append(response);
        } else {
            $(element).replaceWith(response)
        }
        fireEvent(successEvent);
    }

    var error = function (e) {
        fireEvent(failedEvent);

        if (retryCount > 0) {
            setTimeout(delayOnError, function () {
                retry(currentRetryCount)
            })
        }
        else
            element.html(errorMessage);
    }

    var _listener = function (currentRetryCount) {
        var headers = {};
        var csrfTokenElement = document.querySelector('meta[name="csrf-token"]')
        if (csrfTokenElement)
            headers['X-CSRF-Token'] = csrfTokenElement.content

        var requestOptions = {
            method: method,
            headers: headers
        }

        if('POST' == method)
          requestOptions.body =  JSON.stringify(data)

        fetch(path, requestOptions)
          .then(res => res.text().then(success))
          .catch(error);
    }

    if(interval > 0){
       retryCount = 0; // does interval and retry even make sense?
       setInterval(_listener, interval);
    }

    var _lazyListener = function () {
        lazyLoadObserver = new IntersectionObserver(function (entries) {
            if (entries[0].intersectionRatio) {
                if(!isLazyLoaded(element)){
                    _listener();
                }
            }
        }, {
            root: root,
            rootMargin: rootMargin,
            threshold: threshold
        });

        lazyLoadObserver.observe(element);
    }

    if (retryCount > 0) {
        var retry = function (currentRetryCount) {
            if (typeof (currentRetryCount) === 'number') {
                if (currentRetryCount >= retryCount)
                    return false;

                fireEvent(retryEvent);

                _listener(currentRetryCount + 1);
                return true;
            }

            _listener(1);
            return true;
        }
    }

    console.log(containerId, "is lazy?", !!lazy)
    !!lazy ? _lazyListener() : _listener();
}

function loadAllaAsync(asyncDomClass){
    $(asyncDomClass).each(function () {
        var id = $(this).attr('id');
        loadAsyncContent("#"+id);
    });
}

$(document).on('page:load.async turbolinks:load.async', function () {
    loadAllaAsync(".render-async");
});
