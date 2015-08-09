---
layout: post
status: publish
published: true
title: American Flag in HAML/SCSS
author: Topher
date: '2015-08-9 22:14:25 -0700'
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

I use HAML's inline ruby syntax to procedurally generate the stripes


```ruby
  - 13.times do |num|
    .stripe{:class => "stripe-#{num}"}
```

Odd stripe classes can be styled using the SCSS `nth-child(odd)` selector

```scss
.stripe:nth-child(odd) {
  background-color: $red;
  /* box-shadow: 0px 1px 0px black; */
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





# From San Francisco!

<p data-height="334" data-theme-id="0" data-slug-hash="aOYbrM" data-default-tab="result" data-user="topher6345" class='codepen'>See the Pen <a href='http://codepen.io/topher6345/pen/aOYbrM/'>Happy 4th of July from San Francisco!</a> by Christopher Saunders (<a href='http://codepen.io/topher6345'>@topher6345</a>) on <a href='http://codepen.io'>CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>
