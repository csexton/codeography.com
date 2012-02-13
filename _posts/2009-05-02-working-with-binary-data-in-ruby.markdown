---
layout: post
title: Working with binary data in Ruby
---
Recently I found my self having to work with binary data in Ruby, but have found myself confused and frustrated by a few things.  Luckily this during recent experiment I discovers a few tricks that really help me.

View binary data in hex
-----------------------

When working in the Visual Studio debugger I prefer to view memory in hex, so I found it awkward to compare with the decimal escapes that Ruby uses.

But String#unpack has the H format.  Since the documentation described it as "extract hex nibbles from each character" I didn't expect it to do what I wanted, but it does. For example:

    >> "\322\204\371\225Q".unpack("H*")
    => ["d284f99551"]

Parsing data into structs
-------------------------

While you *can* do this with String#unpack and Array#pack, that frankly blows. Luckily I came across Dion Mendel's awesome [binutils gem](http://bindata.rubyforge.org/).

Where I was able to take this C struct:

    struct ServerData
    {
        WORD	 StructSize;     
        DWORD    ErrorCode;
        char	 ErrorMsg[100];  
        char	 ServerIPAddr[16];
        WORD	 ServerPort;     
        BYTE	 Reserved[100];  
        digest	 Signature;      
    };

And rewrite it in ruby:

    class ServerData < BinData::Record
      uint16le :struct_size, :value => lambda { num_bytes }
      uint32le :error_code
      string :error_msg, :length => 100
      string :server_ip_addr, :length => 16
      uint16le :server_port
      string :reserved, :length => 100
      string :signature, :length => 16
    end

The only hard part in the process was figuring out what datatypes to use for the windows types.  Here are a few I had to use:

 * WORD -> uint16le 
 * DWORD -> uint32le 
 * char&#91;n&#92; -> string (with length 'n')
 * BYTE&#91;n&#92; -> Binary data (with length 'n')
 * INT -> int32le 

As I was working my way thought the string I found it helpful to test the parsing one element at a time and make sure that is working.  I would comment out all the elements but the first and try 

    class LittleExample < BinData::Record
      uint16le :word_var
    end

    >> a = LittleExample.new
    >> a.read( "\370\000\364\001\000\000")
    => {"word_var"=>248}

One slick feature of BinData::Record is the ability to set default values.  You can see in the ServerData example above I need to report the size of the struct, and since there are not dynamic length elements I can simply call the num\_bytes method on the record:  

    class LengthData < BinData::Record
     uint16le :struct_size, :value => lambda { num_bytes }
    end

    >> len = LengthData.new
    => {"struct_size"=>2}

