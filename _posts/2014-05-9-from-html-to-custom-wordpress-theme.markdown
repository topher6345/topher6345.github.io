---
layout: post
status: publish
published: true
title: From HTML to Custom Wordpress Theme
author: Topher
date: '2014-05-9 15:24:00 -0800'
categories:
- Code
---

The following post was extracted from a presentation I gave at the [Santa Cruz Web Developers Meetup](http://www.meetup.com/Santa-Cruz-Web-Developers/)

From HTML Site to Custom Wordpress Theme
----------------------------------------


In this brief tutorial, we will go over how to go from a handcoded html site to a wordpress theme.
Assuming we have done all styling, we are taking html and adding PHP code to either do stuff or show wordpress-managed data to us.

2. [Custom Theming](#custom-theming)

  2.1 [Metadata](#metadata-in-stylecss) in `styles.css`

  2.2 [Styles](#styles-in-stylecss) in `styles.css`

  2.3 [Index Page](#index-page-in-indexphp) in `index.php`

  2.4 [Header Template](#header-template-in-headerphp) `in header.php`

  2.5 [List Posts in](#list-posts-in-loopphp) `loop.php`

  2.6 [Footer Template](#footer-template-in-footerphp) in `footer.php`

  2.7 [Single Post](#single-post-in-loop-singlephp) in `loop-single.php`

3.[Snippets](#snippets)

## Custom Theming

Copy

`WordPress/wp-content/themes/twentyten`

And Rename

`WordPress/wp-content/themes/guitar_zen`

### Metadata in `style.css`

```php
/*
Theme Name: Guitar Zen
Theme URI:
Description: Guitar Zen theme
Author: Topher
Author URI: http://wordpress.org/
Version: 0.1
License: MIT
License URI:
Tags:
Text Domain: guitar_zen
*/
```

<img width="100%" src="http://i.imgur.com/zSXcRnh.png">

### Styles in `style.css`

Copy the content from our `style.css`

### Index Page in `index.php`

*it puts together the home page when no home.php file exists.*

http://codex.wordpress.org/Template_Hierarchy

replace WP10 theme's `div`'s with our `main`

The functions on this page are:

* `get_header()`
* `get_template_part( 'loop', 'index' )`
* `get_sidebar()`
* `get_footer()`

<img width="100%" src="http://i.imgur.com/sbJI67o.png">

### Header Template `in header.php`

Leave in everything inside `<head></head>`

`<body <?php body_class(); ?>>`  - a body tag that lets WordPress decide the class attribute.

inside `<body></body>` tags

`<?php echo get_header_image() ?>` - gives header image decided by WordPress

`<?php echo home_url(); ?>` - hold directory decided by WordPress

<img width="100%" src="http://i.imgur.com/yJBy1yG.png">

### List Posts in `loop.php`

http://codex.wordpress.org/The_Loop
http://codex.wordpress.org/Template_Tags

*Run the loop to output the posts.* - `index.php`

`<?php while ( have_posts() ) : the_post(); ?>`

Trust wordpress when you're in this block and you can use these functions -

  * `get_post_permalink()`
  * `get_the_time( 'F j, Y', $post )`
  * `get_the_title()`

`<?php endwhile; // End the loop. Whew. ?>`

<img width="100%" src="http://i.imgur.com/vbsTT3W.png">

### Footer Template in `footer.php`

add our Javascripts

`<script src="<?php bloginfo('template_url'); ?>/js/main.js"></script>`

<img width="100%" src="http://i.imgur.com/URoqLI7.png">

### Single Post in `loop-single.php`

`<?php if ( have_posts() ) while ( have_posts() ) : the_post(); ?>`

`<?php echo get_the_time( 'F j, Y', $post ); ?>`

`<?php echo get_the_title(); ?>`

`<?php echo the_content(); ?>`

`<?php endwhile; // end of the loop. ?>`

<img width="100%" src="http://i.imgur.com/nW1h4DQ.png">

### Clear out `sidebar.php` & `sidebar-footer.php`

photos taken using `git difftool HEAD^ style.css` and filemerge