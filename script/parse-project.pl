#!/usr/bin/perl

use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib";

use File::Slurp;
use Getopt::Long;
use Path::Class::Dir;
use Path::Class::File;
use XML::XPath;

use Westley;

my $work_dir        = undef;
my $project_file    = undef;
my $small_dir       = undef;
my $orig_dir        = undef;

GetOptions(
    'project=s'     => \$project_file,
    'workdir=s'     => \$work_dir,
    'small-dir=s'   => \$small_dir,
    'orig-dir=s'    => \$orig_dir,
) or die "Bad option: $!";


die "--workdir path to directory required"
    unless $work_dir;

die "--project path to XML required"
    unless $project_file;

die "--small-dir path to stub video files required"
    unless $small_dir;

die "--orig-dir path to original video files required"
    unless $orig_dir;

my %path_patterns = (
    "$small_dir"  => "$orig_dir",
);

my $p = Westley->project(
    projectfile     => Path::Class::File->new($project_file),
    workdir         => Path::Class::Dir->new($work_dir),
    pathpatterns    => \%path_patterns,
);

$p->work;

#$p->print;

