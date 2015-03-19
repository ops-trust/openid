#! /usr/bin/env perl

# This file is part of the Ops-T Portal.
# Copyright: Operations Security Administration, Inc.
# All rights reserved.

use warnings;
use strict;

my $siteconfig = {};
my $file = undef;
my $filename = shift @ARGV;
open($file, "<$filename") || die "$filename: $!";
while (<$file>) {
	chomp;
	s/^\s+//go; # remove starting blanks
	s/\s+$//go; # remove ending blanks
	next if /^#/ || !length;
	die "siteconfig($_) syntax error" unless /=/o;
	$siteconfig->{$`} = eval $';
}
close($file);

while (<STDIN>) {
	my $n = 100;
	while (--$n > 0 && /\!(\w+)\!/) {
		if (!defined($siteconfig->{$1})) {
			die "Undefined siteconfig variable: $1";
		}
		$_ = $`.$siteconfig->{$1}.$';
	}
	die "expansion loop" if $n == 0;
	print;
}

exit 0;

