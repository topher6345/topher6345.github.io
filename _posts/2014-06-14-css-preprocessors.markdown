---
layout: post
status: publish
published: true
title: CSS Preprocessors
author: Topher
date: '2014-06-14 15:24:00 -0800'
categories:
- Code
---

The following post was extracted from a presentation I gave at the [Santa Cruz Web Developers Meetup](http://www.meetup.com/Santa-Cruz-Web-Developers/)

Introduction
------------


## Why?

Css preprocessors make working with css *easier*

They accomplish this by providing features in addition to the css specification that help you:

* declare styles in a more convenient way
* keep your css D.R.Y. (an acronym for dont repeat yourself)
* keep your markup semantic
* leverage sophisiticated toolsets that tackle big problems such as responsive design

## Who?

The two most popular css preprocessors are LESS and SASS

### LESS

http://lesscss.org/

### SASS

http://sass-lang.com/


These languages are css-like and output regular, plain ol, css; meaning that:

* SASS and LESS are compatible across all browsers
* They are backwards compatible
* You can use these tools in any of your web projects!


CSS frameworks such as Bootstrap and Foundation are *built* in css preprocessors

Both these frameworks have css versions which dont require you to use css preprocessors.

But it helps if you do!

## How?

How do css preprocessors help me?

* Variables

Ex. Plain CSS

```css

.btn {
  background-color: #FF0000;
}

.title {
  color: #FF0000;
}

h1 a:hover {
  color: #FF0000;
}
```
What if we wanted to change the color of all these?

Search and replace? - There has to be a more elegant solution!

Ex. Using SASS variables

```sass

$brand_color: #FF0000;

.btn {
  background-color: $brand_color;
}

.title {
  color: $brand_color;
}

h1 a:hover {
  color: $brand_color;
}

```
After processing, the above code would be given to the browser like this:

```css
  .btn {
    background-color: #FF0000;
  }

  .title {
    color: #FF0000;
  }

  h1 a:hover {
    color: #FF0000;
  }
```

How do css preprocessors help me?

* Nesting

Ex. Plain CSS

```css

  h2 {
    font-size: 3em;
  }

  .sales-pitch h2 {
    font-size: 2em;
  }

  .sales-pitch h2 a{
    color: #0000DF;
  }
```

Ex. SASS

```sass

  h2 {
    font-size: 3em;
  }


  .sales-pitch {

    h2 {

      font-size: 2em;

      a {
        color: #0000DF;
      }
    }
  }
```

Lets check out the markup (HTML) for both of these styles - which one makes more sense

```html

  <h2>Bob's Biscuts</h2>

  <div class="sales-pitch">
    <h2>
      For Sale
    </h2>
    <h2>
      <a>
        View All
      </a>
    </h2>
  </div>
```

How do css preprocessors help me?

* Mixins

Are like functions or macros.

Ex.
CSS

```css

  .header
  {
    background: -webkit-linear-gradient(red, blue); /* For Safari */
    background: -o-linear-gradient(red, blue); /* For Opera 11.1 to 12.0 */
    background: -moz-linear-gradient(red, blue); /* For Firefox 3.6 to 15 */
    background: linear-gradient(red, blue); /* Standard syntax */
  }

  .footer
  {

    background: -webkit-linear-gradient(red, blue); /* For Safari */
    background: -o-linear-gradient(red, blue); /* For Opera 11.1 to 12.0 */
    background: -moz-linear-gradient(red, blue); /* For Firefox 3.6 to 15 */
    background: linear-gradient(red, blue); /* Standard syntax */

  }
```
Ex.

SASS

```sass

  @mixin brand_gradient($color1, $color2) {

    background: -webkit-linear-gradient($color1, $color2); /* For Safari */
    background: -o-linear-gradient($color1, $color2); /* For Opera 11.1 to 12.0 */
    background: -moz-linear-gradient($color1, $color2); /* For Firefox 3.6 to 15 */
    background: linear-gradient($color1, $color2); /* Standard syntax */
  }

  .header
  {
    @include brand_gradient(red,blue);
  }

  .footer
  {
    @include brand_gradient(red,blue);
  }

```

As far as vendor prefixes are concerned, we can "set it and forget it".
Much more D.R.Y.
Mixin libraries exist to make this even easier like Bourbon and Compass.


How do css preprocessors help me?

* Selector Inheritance

My favorite feature! Very powerful tool in keeping your markup semantic.

Ex. HTML using bootstrap

  <ul class="nav nav-pills">
    <li class="active"><a href="#">Home</a></li>
    <li><a href="#">Profile</a></li>
    <li><a href="#">Messages</a></li>
  </ul>

Not very semantic huh? This markup tells us nothing about what this navigation bar
is or what it does or how it relates to the content.

Ex.
HTML

```html

  <ul class="site-navigation">
    <li class="active"><a href="#">Home</a></li>
    <li><a href="#">Profile</a></li>
    <li><a href="#">Messages</a></li>
  </ul>
```

Ex.
CSS

```css

  @import 'bootstrap';

  .site-navigation {
    @extend .nav;
    @extend .nav-pills;
  }
```


This a much smarter way to let bootstrap do the hard work for us.

Another example

Ex.
HTML

```html
  <article class="col-md-6 col-md-4-offset">
    <p> Here is the text of my article </p>
  </article>
```

Ex. Using SASS

HTML -

```html
  <article>
    <p> Here is the text of my article </p>
  </article>
```

SASS -

```sass
  @import 'bootstrap';

  article {
    @extend .col-md-6;
    @extend .col-md-4-offset;
  }
```

This way we can apply responsive styles to semantic tags without writing a css media query!


## Getting Started

Hopefully by now I've got you at least interested, if not convinced you should be using css preprocessors.


The easiest way to get started is with a product called

### Codekit

[https://incident57.com/codekit/](https://incident57.com/codekit/)

It is an easy to use application that will translate your less or sass files into css.

However, this is a commercial product. Free for 30 days.

### Command line

If you are skilled with the command line or open to learning it, you can use
less and sass for free

#### Less


Download and install NPM

```

  sudo npm -g install less

```

[http://lesscss.org/#using-less](http://lesscss.org/#using-less)

### Sass

If you have Ruby installed (comes with OSX)

```

  gem install sass

```

[http://sass-lang.com/install](http://sass-lang.com/install)


# Links

* [Chris Coyier: A Modern Web Designer's Workflow](http://youtu.be/vsTrAfJFLXI?t=33m26s)

* [Ten Reasons You Should Be Using CSS Preprocessors](http://www.urbaninsight.com/2012/04/12/ten-reasons-you-should-be-using-css-preprocessor)

* [Lingering Misconceptions on CSS Preprocessors](http://css-tricks.com/lingering-misconceptions-on-css-preprocessors/)