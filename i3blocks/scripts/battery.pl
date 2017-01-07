#!/usr/bin/perl

use strict;
use warnings;
use utf8;

my $acpi;
my $status;
my $percent;
my $remain;
my $full_text;
my $short_text;
my $bat_number = $ENV{BLOCK_INSTANCE} || 0;

# read the first line of the "acpi" command output
open (ACPI, "acpi -b | grep 'Battery $bat_number' |") or die;
$acpi = <ACPI>;
close(ACPI);

# fail on unexpected output
if ($acpi !~ /: (\w+), (\d+)%/) {
    die "$acpi\n";
}

$status = $1;
$percent = $2;
$remain = "";

if ($acpi =~ /(\d\d:\d\d):/) {
    $remain = "($1)";
}

# consider color and urgent flag only on discharge
if ($status eq 'Discharging') {
    if ($percent < 15) {
        $full_text = "  " . "$percent%";
    } elsif ($percent < 40) {
        $full_text = "  " . "$percent%"
    } elsif ($percent < 60) {
        $full_text = "  " . "$percent%";
    } elsif ($percent < 80) {
        $full_text = "  " . "$percent%";
    } else {
        $full_text = "  " . "$percent%";
    }
} elsif ($status eq 'Charging') {
    $full_text = "  " . "$percent%";
}

$full_text .= " $remain";
$short_text = $full_text;

# print text
print "$full_text\n";
print "$short_text\n";

# consider color and urgent flag only on discharge
if ($percent < 15) {
    print "#FF0000\n";
} elsif ($percent < 40) {
    print "#f9f0be\n";
} else {
    print "#a2e0e1\n";
}

exit(0);
