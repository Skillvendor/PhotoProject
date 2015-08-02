# Angular Picture

Angular directive for the [Picturefill](http://scottjehl.github.io/picturefill/) responsive image polyfill.

## Installation

1. `bower install angular-picture`
2. Include `ngPicturefill` in your Angular module.

## Usage

```html
<!-- Avoid including an `src` attribute, as it would unnecessarily get read by all browsers -->
<img picturefill srcset="images/logo.png, logo_2x.png 2x"/>
<img picturefill ng-srcset="{{ logo }}, {{ logo_2x }} 2x"/>
```

### Using a `picture` element

```html
<picture picturefill>
    <!--[if IE 9]><video style="display: none;"><![endif]-->
    <!-- Displays with 2 device pixels per CSS pixel -->
    <source srcset="images/logo.png, images/logo_2x.png 2x"/>
    <!-- Preset media queries -->
    <source srcset="images/logo_4x.png" pf-media="screen-lg"/>
    <source srcset="images/logo_3x.png" pf-media="screen-md"/>
    <source srcset="images/logo_2x.png" pf-media="screen-sm"/>
    <source srcset="images/logo_1x.png" pf-media="screen-xs"/>
    <!-- Custom media query -->
    <source srcset="images/logo_3x.png" pf-media="(min-width: 1000px)"/>
    <!--[if IE 9]></video><![endif]-->
    <img srcset="images/logo.png"/>
</picture>
```

#### Preset media queries

* `screen-xs`: Extra small devices (phones, less than 768px).
	* Alias: `phone`
* `screen-sm`: Small devices (tablets, 768px and up).
	* Alias: `tablet`
* `screen-md`: Medium devices (desktops, 992px and up).
	* Alias: `desktop`
* `screen-lg`: Large devices (large desktops, 1200px and up).
	* Alias: `lg-desktop`
* `landscape`: Landscape mode.
* `portrait`: Portrait mode.
* `retina`: Retina display.

## Read more

* [Responsive Images Community Group](http://responsiveimages.org/)
* [Responsive Images Done Right: A Guide To `picture` And `srcset` | Smashing Magazine](http://www.smashingmagazine.com/2014/05/14/responsive-images-done-right-guide-picture-srcset/)
* [The `srcset` attribute](http://www.webkit.org/demos/srcset/)
