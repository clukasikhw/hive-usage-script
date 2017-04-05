#!/usr/bin/perl

use strict;
use Getopt::Long qw(GetOptions);

my $USAGE = "Usage: $0 --granularity <DAY|HOUR|MINUTE> --search <\"Starting command:|Parsing command:\"> <file list to search>\n";
my $GRAIN = "HOUR";
my $SEARCHING_FOR = "Starting command:";
my $HELP;

GetOptions(
    'granularity=s' => \$GRAIN,
    'search=s' => \$SEARCHING_FOR,
    'help' => \$HELP
) or die $USAGE;

die "$USAGE" if $HELP;
die "No files mentioned to search.\n$USAGE\n" if  (scalar(@ARGV) == 0);

my (%types, %results, $grain, $qtype, $hkey, $val, $year, $month, $day, $hour, $minute, $cur_idx, $grain_hdr, $curfilename);

# Search logs and build results map
for $curfilename (@ARGV) {
  my $file_command = ($curfilename =~ /gz$/) ? "gzcat $curfilename | " : "cat $curfilename | ";
  open FH, $file_command || die "Could not open $curfilename.\n$USAGE\n";
  while (<FH>) {
	next if !(/$SEARCHING_FOR/);
	chomp();
	my ($year, $month, $day, $hour, $minute, $p1, $p2) = /^(....).(..).(..) (..):(..).*$SEARCHING_FOR *([^ ]*) ([^ ]*).*/;
	$_ = s/.*Parsing Command: //;
	if ("$GRAIN" eq "HOUR") {
	  $grain = "${year}${month}${day},${hour}";
	  $grain_hdr = "Date,Hour,";
	} elsif ("$GRAIN" eq "DAY") {
	  $grain = "${year}${month}${day}";
	  $grain_hdr = "Date,";
	} elsif ("$GRAIN" eq "MINUTE") {
	  $grain = "${year}${month}${day},${hour},${minute}";
	  $grain_hdr = "Date,Hour,Minute,";
	}			
	if ($p1 =~ /create/i || $p1 =~ /drop/i || $p1 =~ /show/i) {
	  $qtype = "$p1 $p2";
	} else {
	  $qtype = $p1;
	}
	$qtype = uc $qtype;
    $val = $results{$grain}->{$qtype} + 0;
    $val = $val + 1;
    $results{$grain}->{$qtype} = $val;
    $types{$qtype} = 1;
  }
}

# Print headers
my $type_len = scalar(keys %types);
print "$grain_hdr";
$cur_idx = 0;
foreach $qtype (sort keys %types) {
  $cur_idx++;
  print "$qtype";
  print "," if ($cur_idx < $type_len);
}
print "\n";

# Print aggregate results
foreach $grain (sort keys %results) {
  print "$grain,";
  $cur_idx = 0;
  foreach $qtype (sort keys %types) {
    $cur_idx++;
    $val = ($results{$grain}->{$qtype}) + 0;
    print "$val";
    print "," if ($cur_idx < $type_len);
  }
  print "\n";
}
