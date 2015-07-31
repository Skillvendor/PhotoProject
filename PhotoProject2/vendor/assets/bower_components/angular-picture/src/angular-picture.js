'use strict';

 // By default, Picturefill only works once the DOM is loaded.
 // This directive makes Picturefill load when Angular requests
 // a "picturefill" element.
angular.module('ngPicturefill', [])
  .directive('picturefill', [function () {
    return {
      restrict: 'A',
      controller: 'PictureFillCtrl',
    };
  }])
  .controller('PictureFillCtrl', ['$timeout', function ($timeout) {
    $timeout(picturefill);
  }])
  // Preset media queries, inspired by:
  // - https://github.com/twbs/bootstrap/blob/master/less/variables.less
  // - https://github.com/c0bra/angular-responsive-images/blob/master/src/bh-responsive-images.js
  .value('presetMediaQueries', {
    'default':    'only screen and (min-width: 1px)',
    'screen-xs':  'only screen and (min-width: 480px)',
    'phone':      'only screen and (min-width: 480px)',
    'screen-sm':  'only screen and (min-width: 768px)',
    'tablet':     'only screen and (min-width: 768px)',
    'screen-md':  'only screen and (min-width: 992px)',
    'desktop':    'only screen and (min-width: 992px)',
    'screen-lg':  'only screen and (min-width: 1200px)',
    'lg-desktop': 'only screen and (min-width: 1200px)',
    'landscape':  'only screen and (orientation: landscape)',
    'portrait':   'only screen and (orientation: portrait)',
    'retina':     'only screen and (-webkit-min-device-pixel-ratio: 2), ' +
                  'only screen and (min--moz-device-pixel-ratio: 2), ' +
                  'only screen and (-o-min-device-pixel-ratio: 2/1), ' +
                  'only screen and (min-device-pixel-ratio: 2), ' +
                  'only screen and (min-resolution: 192dpi), ' +
                  'only screen and (min-resolution: 2dppx)'
  })
  .directive('pfMedia', ['presetMediaQueries', function (presetMediaQueries) {
    return {
      restrict: 'A',
      link: function (scope, elem, attrs) {
        if (attrs.pfMedia in presetMediaQueries) {
          elem.attr('media', presetMediaQueries[attrs.pfMedia]);
        } else {
          elem.attr('media', attrs.pfMedia);
        }
      }
    };
  }]);