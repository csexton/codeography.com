---
layout: post
title: "Define Your Inner Foo"
published: true
---

Recently attended a great talk by [Paul Berry](http://paulbarry.com/) at the [DCRUG](http://www.meetup.com/dcruby/). During his talk, he wondered off into defining a method in a method.

This was really cool.

I took some time playing with this, and after showing a few colleagues, I had to write this up. I encourage you to fire up IRB and try it your self. This is probably not something you would actually want to do in a project, but once you know about it then you will be tempted to find a problem for this solution.

define_your_inner_foo.rb:

    class DefineYourInnerFoo
      def foo
        def foo
          def foo
            "Zirbert"
          end
          "Zaz"
        end
        "Zing"
      end
    end

irb:

    >> load 'define_your_inner_foo.rb'
    >> f = DefineYourInnerFoo.new
    >> f.foo #=> 'Zing'
    >> f.foo #=> 'Zaz'
    >> f.foo #=> 'Zirbert'
    >> f.foo #=> 'Zirbert'
    >> g = DefineYourInnerFoo.new
    >> g.foo #=> 'Zirbert'
    >> g.foo #=> 'Zirbert'


A slightly more contrived example:

animal.rb:

    class Animal
      def speak
        "Hello, I am a Animal"
      end
      def be_dog
        def speak
          "Woof"
        end
      end
      def be_bird
        def speak
          "Tweet-a-leet"
        end
      end
      def be_whale
        def speak
          "HeeeeeeiiilllllllloooooooooOOOOOOooo....oooooOOOOoo"
        end
      end
    end

irb:

    >> load 'animal.rb' #=> true
    >> a = Animal.new #=> #<Animal:0x00000101126900>
    >> a.speak #=> "Hello, I am a Animal"
    >> a.be_dog #=> nil
    >> a.speak #=> "Woof"
    >> a.be_bird #=> nil
    >> a.speak #=> "Tweet-a-leet"
    >> b = Animal.new #=> #<Animal:0x000001010eeeb0>
    >> b.speak #=> "Tweet-a-leet"
    >> b.be_whale #=> nil
    >> a.speak #=> "HeeeeeeiiilllllllloooooooooOOOOOOooo....oooooOOOOoo"

