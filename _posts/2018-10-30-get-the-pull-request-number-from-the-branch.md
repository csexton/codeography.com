---
layout: post
title: Get the pull request number from the branch
---

So started trying out Heroku CI and discovered it was missing a few things I had grown accustomed to with Travis. Most recently it didn't have the Pull Request number in an environment variable like Travis's `TRAVIS_PULL_REQUEST`

So, I needed to get the GitHub Pull Request number from the branch name.

Turns out you can pull this off with the API fairly easily.

If I wanted to use the [Octokit](https://github.com/octokit/octokit.rb) gem:

```ruby
require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'octokit'
  gem 'pry'
end

def find_pr(repo, branch)
  client = Octokit::Client.new(:access_token => ENV['GITHUB_ACCESS_TOKEN'])
  client.pull_requests(repo, {head: branch}).first&.number
end

# Find the pull request number on the csexton/codeography.com repo
# for 'my-branch':

puts find_pr('csexton/codeography.com', 'csexton:my-branch')
```

But it would be nice to have no dependencies, and could skip that bundler install overhead:

```ruby
require "net/https"
require "uri"
require "json"

def find_pr(org, repo, branch)
  uri = URI("https://api.github.com/repos/#{org}/#{repo}/pulls?head=#{org}:#{branch}")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  request = Net::HTTP::Get.new(uri.request_uri)
  request['Authorization'] = "token #{ENV['GITHUB_ACCESS_TOKEN']}"
  response = http.request(request)
  json = JSON.parse(response.body)
  if json.count == 1
    json.first["number"]
  else
    nil
  end
end

puts find_pr('csexton/codeography.com', 'csexton:my-branch')
```

Code is uglier (thanks Net::HTTP), but it just uses the standard library.

