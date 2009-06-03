---
layout: post
title: Working with binary data in irb
---

Since I have been workign on a ruby port of a windows program that has a binary format, I find myself having to examine the memory contents in Visual Studio and try to reproduce the same output in ruby.  Well, maybe it is years of pratice, but I find it much easier to read the hex output than the octal that ruby uses.  This is something I normally want when working in IRB or as fixture data in my tests. So to make this a little easier I extended Integer and String.  I wound up dumping this code into my .irbrc file so I could easily cut-n-paste the memory from windows.


    class Integer
      def to_binary_s
        bits = self.to_s(2)
        prepend = (8 - bits.length % 8)
        bits = ('0' * prepend) + bits
        return [bits].pack('B*')
      end
    end
    class String
      def read_hex_s
        self.gsub(" ", "").hex.to_binary_s
      end
      def to_hex_s
        self.unpack("H*")[0]
      end
    end


