---
layout: post
title: Working with FILETIME in Ruby
---

Recently I have had to deal with the windows FILETIME struct in ruby. 

MSDN defines this guy as "a 64-bit value representing the number of 100-nanosecond intervals since January 1, 1601 (UTC)."

Well, the easy thing to do is add a method to the Time class that can convert to the format:


    class Time
      # Convert the time to the FILETIME format, a 64-bit value representing the
      # number of 100-nanosecond intervals since January 1, 1601 (UTC).
      def wtime
        self.to_i * 10000000 + 116444736000000000
      end

      # Create a time object from the FILETIME format, a 64-bit value representing
      # the number of 100-nanosecond intervals since January 1, 1601 (UTC).
      def self.from_wtime(wtime)
        Time.at((wtime - 116444736000000000) / 10000000)
      end
    end

Now I can do fancy things like:

    some_bindata_struct.time = Time.now.wtime
