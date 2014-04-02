---
layout: post
title: Versioning in the URL?
---

After showing my friend [Guille](http://github.com/guillec) the API I was working on he said:

```
guillec: whats with the versioning in the URL?
guillec: dont talk to me
guillec: ever again
```

I love hypermedia APIs, so why do I have a version in the URL? Aren't we supposed to version resources and not the entire API?

Well, I have my reasons.

But first, I do agree. This feels like a smell. If I see an API that does this I normally would make snarky comments. My gut tells me it is the result of poorly thought out API, a dated approach, or some other anti-pattern.

So, why do I put the version in the URL?

Because: It is hard to do things right.

So a little back story. A few constraints I have to work within. I am working at a little company on a small system that is being integrated by partners, often contractors or junior developers who just want to check it off a list and move on. So they want to crank out something with the minimum amount of work necessary.

Lets think about how they are going to use the API.

* They will cut corners
* They will hard code URIs
* They will not set the headers properly
* They will assume the media type
* They will complain if the API is hard to use
* They will complain if something breaks (no matter how many corners they have cut)

That's all compleatly fair. I want to make their job easier, and I don't want them to push back on integrating (lest an important deal fall through).

So now I think about what my goals are.

* I want to make it easy to integrate
* I would prefer if the code behind it was clean and maintainable
* I want my API to appear to be well thought out and properly designed (For example if Guille was evaluating my service, I want him to be impressed)
* I need to be able to change the API as our product evolves

A few constraints

I have been told by a few very smart and accomplished developers that the solution is to control the API and the client. But given my "little company/small system" I don't have the cycles to create and maintain Ruby, Node, PHP, Java and ColdFusion libraries -- and that's just the clients we have now. So it needs to be a common denominator, which is the HTTP API.

The same goes for media types. I know I can correctly report the media type I support throught content negotiation, but by the time I get that far I've lost most developers. Also to save time and money I am only supporting one media type. Just dont' have time to build out the others. Much less keep them all up to date. So effectively forcing a Hypermedia api into single media type. Not really ideal, but pragmatically what can be supported for now.

The compromise

Be as progressive as I can in the Hypermedia API. Pick a solid media type and stick to it. The point is to not reinvent new problems. HAL, JSON+collection, JSON API -- just pick one that works for you.

Expect the consumer to cut corners. Plan for hard coded URLs. Resource IDs and URLs to be stored in their system. Improper use of headers such as content type, accepts, even authentication.

My Approach

* Handle the hardcoded URLs by versioning via the API
* Force the content type to be JSON
* Make it easy to Authorize
  * Authorization header (the documented and recomended way)
  * Session (logged in users can view the API in their browser)
  * Query Param (the It Just Works™ method, this way I email a url that will work for debugging or other support, but I don't publish this in the docs)

I hope I can find a middle ground that will make the 9-to-5er happy as well as appease the zealous hypermedia advocate.

Things would be differnent with different constraints. The API is not stable, things will need to change. I don't need many different representations of the resources. The clients consuming it will be the simpliset thing that works.

Are you using Hypermedia APIs in production and dealing with customers, zealots and unreasonable free loaders? I am curious how you handle this. Drop me a line or leave a comment.




