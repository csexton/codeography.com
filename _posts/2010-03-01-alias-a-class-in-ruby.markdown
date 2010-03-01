---
layout: post
title: "Alias a Class in Ruby"
published: true
---

I had a collegue looking for a way to alias a class in Ruby. Which I thought was a pretty interseting problem.

My first attempt was using eval, which really felt to clever:

    class Daddy; def speak() puts "No!" end; end
    %w{Leah Lars}.each {|k| eval "class #{k} < Daddy; end"}
    Leah.new.speak
    Lars.new.speak

Then it dawned on me, everything is an object, even classes. So could it be this simple? 

    class Daddy; def speak() puts "No!" end; end
    Leah = Daddy
    Lars = Daddy
    Leah.new.speak
    Lars.new.speak

It actually worked. Yes it is one line longer. But it is extremly readable and does not use `Evil`^H^H^H`Eval`
