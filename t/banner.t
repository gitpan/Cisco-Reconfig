#!/usr/bin/perl -I. -w

use Cisco::Reconfig;
use Test;
use Carp qw(verbose);
use Scalar::Util qw(weaken);

use strict;

my $debugdump = 0;

if ($debugdump) {
	$Cisco::Reconfig::nonext = 1;
}

BEGIN { plan test => 2 };

sub wok
{
	my ($a, $b) = @_;
	require File::Slurp;
	import File::Slurp;
	write_file('x', $a);
	write_file('y', $b);
	return ok($a,$b);
}

my $config = readconfig(\*DATA);

if ($debugdump) {
	require File::Slurp;
	require Data::Dumper;
	import File::Slurp;
	import Data::Dumper;
	$Data::Dumper::Sortkeys = 1;
	$Data::Dumper::Sortkeys = 1;
	$Data::Dumper::Terse = 1;
	$Data::Dumper::Terse = 1;
	$Data::Dumper::Indent = 1;
	$Data::Dumper::Indent = 1;
	write_file("dumped", Dumper($config));
	exit(0);
}

ok(defined $config);

# -----------------------------------------------------------------
{

my $x = $config->get('banner motd');
#undef $config;
#use Data::Dumper;
#print Dumper($x);
#exit(0);
ok($x->subs->text, <<END);
 
                Company XXXX
 
Unauthorized use of this system is forbidden. Anyone's activities here may
be
monitored at any time; if monitoring yields evidence of criminal, unethical,
or unauthorized activity, University and/or law enforcement officials will
be
informed.  Note that in this process authorized activity may also be
revealed.
 
^C
END

}
# -----------------------------------------------------------------
# -----------------------------------------------------------------
# -----------------------------------------------------------------


__DATA__
!
! Last configuration change at 20:38:42 PDT Mon Jun 26 2000C
! NVRAM config last updated at 20:38:49 PDT Mon Jun 26 2000C
!
service tcp-small-servers
banner exec ^C
 
                XXXXX XXXXX Network Gateway
 
   This is a restricted network node.  Do NOT use this node if
   you do not work for UMMC Network Services.  Thank you.
 
^C
banner motd ^C
 
                Company XXXX
 
Unauthorized use of this system is forbidden. Anyone's activities here may
be
monitored at any time; if monitoring yields evidence of criminal, unethical,
or unauthorized activity, University and/or law enforcement officials will
be
informed.  Note that in this process authorized activity may also be
revealed.
 
^C
!
hostname humble
