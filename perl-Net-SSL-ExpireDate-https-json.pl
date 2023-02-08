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

unless (@ARGV) {
  require File::Basename;
  my $basename = File::Basename::basename($0);
  die("Syntax: $basename [-p port] hostname\n");
}

my $host      = shift;
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

__END__

=head1 NAME

perl-Net-SSL-ExpireDate-https-json.pl - Obtain web site SSL certificate expiration date and return in JSON payload

=cut
