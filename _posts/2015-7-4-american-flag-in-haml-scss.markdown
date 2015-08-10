---
layout: post
status: publish
published: true
title: American Flag in HAML/SCSS
author: Topher
date: '2015-08-09 22:14:25 -0700'
categories:
- CSS
- Code
tags:
- CSS
---

# Happy 4th of July!

Since I didn't have the ingredients to make an American flag cake this year, I thought I would whip one up in Codepen.

<p data-height="435" data-theme-id="0" data-slug-hash="QbmWmv" data-default-tab="result" data-user="topher6345" class='codepen'>See the Pen <a href='http://codepen.io/topher6345/pen/QbmWmv/'>Happy 4th of July #USA</a> by Christopher Saunders (<a href='http://codepen.io/topher6345'>@topher6345</a>) on <a href='http://codepen.io'>CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

## The markup

```haml
.flag
  - 13.times do |num|
    .stripe{:class => "stripe-#{num}"}
  .square
    - g_num = 0
    - [6,5,6,5,6,5,6].each do |num|
      .star-row
        - num.times do 
          .glyphicon.glyphicon-star.star{:class => "star-#{g_num}"}
          - g_num += 1
```


### Stripes

I use HAML's inline ruby syntax to procedurally generate the stripes


```ruby
  - 13.times do |num|
    .stripe{:class => "stripe-#{num}"}
```

Odd stripe classes can be styled using the SCSS `nth-child(odd)` selector

```scss
.stripe:nth-child(odd) {
  background-color: $red;
}
```

The resulting compiled markup from the procedurally generated stripes looks something like this

```html
<div class='flag'>
  <div class='stripe stripe-0'></div>
  <div class='stripe stripe-1'></div>
  ...
</div>
```

each stripe has a 'handle' that I can use to target individual stripes.

Using a SCSS `@for` loop, I can add an animation to some stripes to make it appear that the flag is waving in the wind.

[http://sass-lang.com/documentation/file.SASS_REFERENCE.html#_10](SASS @for loop)

```scss
@for $i from 1 through 11 {
  .stripe-#{$i} {
    animation: stripes 8s infinite linear;
    animation-delay: #{.2 * $i}s;    
  }
  @keyframes stripes {
    0% {transform: scaleY(1)}
    25% {transform: scaleY(.9)}
    50% {transform: scaleY(1.1)}
    100% {transform: scaleY(1)}
  }  
}
```

This lets me stagger the `animation-delay` property, so I can reuse the same animation to get a sublte ripple effect across the surface of the flag.

### Stars

```haml
.square
  - g_num = 0
  - [6,5,6,5,6,5,6].each do |num|
    .star-row
      - num.times do 
        .glyphicon.glyphicon-star.star{:class => "star-#{g_num}"}
        - g_num += 1
```

Procedurally laying out the stars was tricky. The solution I cam up with was to use nested iterators, and one global variable (gasp) `g_num` to give each of th 50 stars an individual class name.

The star icon itself is from the [http://getbootstrap.com/components/](bootstrap glyphicons) collection.

The 50 stars on the American flag are layed out in 7 rows of alternating sizes of 6 and 5.

One can express this in HAML/Ruby by using an array literal `[6,5,6,5,6,5,6]`.

Rows of 5 (even rows) can be styled to have an offset like so

```scss
.star-row:nth-child(even) {
  padding-left: 15px;
}
```

each star is given a unique classname so that we can have a cascading twinkling effect.


```scss
@for $i from 0 through 49 {
  .star-#{$i} {
    animation: fade-in 1s infinite ease-in-out;
    animation-delay: #{.22222 * $i}s;
  }
  @keyframes fade-in {
    0% {transform: scale(.6)}
    50% {transform: scale(1)}
  }
}
```

## Conclusion

Thanks to [http://www.hamptoncatlin.com/](Hampton Catlin), who wrote both SCSS and HAML (among other things, when does he sleep!?), I was able to use languages that compile to HTML and CSS to succinctly express a sophisticated layout. This may be beyond the original intention of what HTML and CSS were meant to do, but it sure was alot of fun working on this patriotic display!  


# Bonus - From San Francisco!

I recently moved to San Francisco and thought I'd like to express my appreciation for the new city and celebrate the ctiy's unofficial flag.

<p data-height="334" data-theme-id="0" data-slug-hash="aOYbrM" data-default-tab="result" data-user="topher6345" class='codepen'>See the Pen <a href='http://codepen.io/topher6345/pen/aOYbrM/'>Happy 4th of July from San Francisco!</a> by Christopher Saunders (<a href='http://codepen.io/topher6345'>@topher6345</a>) on <a href='http://codepen.io'>CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>
