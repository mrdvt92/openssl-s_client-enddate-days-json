#!/usr/bin/perl
use v5.10;
use strict;
use warnings;
use Getopt::Std qw{getopts};
use JSON qw{encode_json};
use DateTime;
use DateTime::Format::ISO8601::Format;

my $opt        = {};
getopts("p:", $opt);
my $port       = $opt->{"p"} || '443';
my $host       = shift or die("Syntax: $0 hostname\n");
my $formatter  = DateTime::Format::ISO8601::Format->new;

my $epoch      = qx{/usr/bin/openssl s_client -servername $host -connect $host:$port </dev/null 2>/dev/null | /usr/bin/openssl x509 -noout -enddate | /usr/bin/awk -F '=' '{print \$NF}' | /usr/bin/xargs -0 /usr/bin/date +"%s" -u -d};

my $error      = $?;
die("Error: openssl call returns error\n") if $error;

chomp $epoch;

my $days       = ($epoch - time) / 60 / 60 / 24;
my $data       = {
                  enddate_epoch => $epoch,
                  enddate       => $formatter->format_datetime(DateTime->from_epoch(epoch=>$epoch, time_zone=>"UTC")),
                  days          => $days,
                  host          => $host,
                  port          => $port,
                 };

say encode_json($data);
