#!/usr/bin/perl
#
# simple root test routine
# Geoff Huston, APNIC
#
# perform this for 100,000 queries

foreach $i (1..100000) {
  foreach $root ('a'..'m') {
    #
    # generate a lengthy and unique query name
    #
    $val = int(3000000000 + rand(1000000000)) ;
    $name = $val . "DxyMw.WTzEWrfJOe0ppIEfTqP.wgH49qJbmewhFBcJd8a.9euvKw1S1FQFxY2EWWKMIIsP.ObvciODBAjRB2eHZ5zFVEVVNTNmdrBumgI.mQlebyAwnrO79kVpE7lo.Z4U4o4Azh0z4RpDxyMwEl6JUn7ggke42Yya.wecadc341asd.rbHgNH0CshUyZHPy.uNk2Le45btZ2Sndu.JN8Q6GmQlebyAwnrO79kpVplo.Kpp8.BQ." ;
    #
    # use 'dig to direct the query to a root server over IPv6
    # set DNSSEC to ON and use an EDNS(0) UDP buffer size of 4096
    #
    $cmd6 =  "dig +dnssec +bufsize=4096 -6 \@$root.root-servers.net. ds $name";
    #
    # collect the response
    #
    @l6 = `$cmd6` ;
    #
    # and print it to stdout
    #
    $lines = join('      ',@l6) ;
    $rs = $root . ".root-servers.net" ;
    $rs =~ tr/a-z/A-Z/ ;
    print("$rs\n    $lines\n") ;
    #
    # pace the queries do we are not jamming the root servers
    #
    sleep(2) ;
    }
  }
