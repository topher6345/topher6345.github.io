---
layout: post
status: publish
published: true
title: Build a Web Scraper in Rails
author: Topher
date: '2014-07-16 13:29:54 -0700'
categories:
- Code
tags:
- Ruby
---

In this post, I'll walk you through building a web scraper in Ruby on Rails. I'm assuming an intermediate skill level with Rails.

you can a completed version of this project here

<a href="https://github.com/topher6345/rails-jobscrape">github.com/topher6345/rails-jobscrape</a>

This application can be used to scrape job postings.

### Requirements

* ruby-2.1.1
* rails 4.1.1
* local instance of postgresql

### Create new rails project

`rails new jobscraper -d postgresql`

### Install gems

`bundle install`


### Create Database

`postgres -D /usr/local/pgsql/data`

`rake db:create`


### Create 'Job' Resource
`rails g scaffold job title:string location:string link:text haveapplied:boolean company:string interested:boolean referred:string`

Use scaffold generator to get .json API for free

`rake db:migrate`


### Add Active Admin

add these lines to your `Gemfile`
```ruby
gem 'devise'
gem 'activeadmin', github: 'gregbell/active_admin'
```
and run

`bundle install`

#### Install ActiveAdmin

`rails g active_admin:install`

#### Register Jobs with ActiveAdmin

`rails generate active_admin:resource job`

#### Customize ActiveAdmin Jobs View

```ruby
# app/admin/job.rb
ActiveAdmin.register Job do

  permit_params :title, :location, :haveapplied, :interested, :referred

  index do
    selectable_column
    id_column
    column :title do |s|
      a href: admin_job_path(s) do
        s.title
      end
    end
    column :location
    column :link do |s|
      a href: s.link do
        s.link
      end
    end
    column :haveapplied
    column :interested
    column :referred
    column :created_at
    column :updated_at
    actions
  end


end
```
#### Add Rake Task

`rails generate task jobs fetch prune clean`

```ruby
# lib/tasks/jobs.rake
namespace :jobs do
  desc "Fill database with Job listings"
  task fetch: :environment do
    require 'nokogiri'
    require 'open-uri'

    # clean database to avoid duplicates
    Job.all.each do |job|
      job.destroy!
    end

    # write your nokogiri scripts here or
    #
    # require 'lib/tasks/sites/santacruzjobs.rb'
    #
    # them from other files.

    # Throw away old jobs
    Job.destroy_all(['created_at < ?', 7.days.ago])
  end

  desc "Delete Jobs that are older than 7 days"
  task prune: :environment do
    Job.destroy_all(['created_at < ?', 7.days.ago])
  end

  desc "Delete all jobs."
  task clean: :environment do
    Job.all.each do |job|
      job.destroy!
    end
  end

end

```

If you run `rake -T` you can see these tasks are registered with rake.
```
rake jobs:clean                         # Delete all jobs
rake jobs:fetch                         # Fill database with Job listings
rake jobs:prune                         # Delete Jobs that are older than 7 days
```

Write custom [nokogiri](https://github.com/sparklemotion/nokogiri/tree/master#synopsis) scripts to populate ActiveRecord attributes.