#!/usr/bin/perl
use v5.10;
use strict;
use warnings;
use DateTime;
use DateTime::Format::ISO8601::Format;
use JSON qw{encode_json};

my $servername = shift or die("Syntax: $0 hostname\n");
my $formatter  = DateTime::Format::ISO8601::Format->new;

my $epoch      = qx{/usr/bin/openssl s_client -servername $servername -connect $servername:443 </dev/null 2>/dev/null | /usr/bin/openssl x509 -noout -enddate | /usr/bin/awk -F '=' '{print \$NF}' | /usr/bin/xargs -0 /usr/bin/date +"%s" -u -d};
chomp $epoch;

my $days       = ($epoch - time) / 60 / 60 / 24;
my $data       = {
                  enddate_epoch => $epoch,
                  enddate       => $formatter->format_datetime(DateTime->from_epoch(epoch=>$epoch, time_zone=>"UTC")),
                  days          => $days,
                 };

say encode_json($data);
