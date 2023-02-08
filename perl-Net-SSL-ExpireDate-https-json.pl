#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Std qw{getopts};
use JSON qw{encode_json};
use Net::SSL::ExpireDate;
use DateTime::Format::ISO8601::Format;

my $opt       = {};
getopts("p:", $opt);
my $port      = $opt->{"p"} || '443';
my $host      = shift or die("Syntax: $0 [-p port] hostname\n");
my $ed        = Net::SSL::ExpireDate->new( https => "$host:$port" );
my $dt        = $ed->expire_date;

exit 1 if not defined $dt;

my $formatter = DateTime::Format::ISO8601::Format->new;
my $epoch     = $dt->epoch;
my $days      = ($epoch - time) / 60 / 60 / 24;
my $data      = {
                 enddate_epoch => $epoch,
                 enddate       => $formatter->format_datetime($dt),
                 days          => $days,
                 host          => $host,
                 port          => $port,
                };

print encode_json($data), "\n";
