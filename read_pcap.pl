#!/usr/bin/perl
#
# extremely simple tcmdump parser
#
# list of IPv6 root server addresses
#
%roots = (
  "2001:503:ba3e::2:30"=>"A",
  "2001:500:84::b"=>"B",
  "2001:500:2::c"=>"C",
  "2001:500:2d::d"=>"D",
  "2001:500:a8::e"=>"E",
  "2001:500:2f::f"=>"F",
  "2001:500:12::d0d"=>"G",
  "2001:500:1::53"=>"H",
  "2001:7fe::53"=>"I",
  "2001:503:c27::2:30"=>"J",
  "2001:7fd::1"=>"K",
  "2001:500:9f::42"=>"L",
  "2001:dc3::35"=>"M") ;


while ($l = <>) {
  (@f) = split(/\s/,$l)  ;

  $time = $f[0] ;
  #
  # Fragmented packet - calc the full packet size (payload length + 40)
  # this gets the first packet fragment
  #
  if ($l =~ /Fragment.*\s(\d+)\)\s([a-f0-9\:]+)\s\>.*0\|\d+\)/) {
    $length = $1 ;
    $srv = $2 ;
    $length += 40 ;
    $root = $roots{$srv} ;
    print("$root $srv F $length $time\n") ;
    }
  #
  # Truncated packet = calc the full packet size
  #
  elsif ($l =~ /UDP.*\s(\d+)\)\s([a-f0-9\:]+).53\s\>.*\-\|\sq\:/) {
    $length = $1 ;
    $srv = $2 ;
    $length += 40 ;
    $root = $roots{$srv} ;
    print("$root $srv X $length $time\n") ;
    }
  #
  # unfragmented UDP packet
  #
  elsif ($l =~ /UDP.*\s(\d+)\)\s([a-f0-9\:]+).53\s\>/) {
    $length = $1 ;
    $srv = $2 ;
    $length += 40 ;
    $root = $roots{$srv} ;
    print("$root $srv U $length $time\n") ;
    }
  }





