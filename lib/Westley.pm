package Westley;

use 5.010000;
use strict;
use warnings;

our $VERSION = '0.01';

use Moose;
use XML::DOM;

use Westley::Project;


has 'projectfile' => (
    is  => 'ro',
    isa => 'Path::Class::File',
    required => 1,
);

has 'workdir' => (
    is  => 'ro',
    isa => 'Path::Class::Dir',
    required => 1,
);

has 'pathpatterns' => (
    is  => 'ro',
    isa => 'HashRef[Str]',
    required => 1,
);


sub project {
    my ($class, @rest) = @_;

    my $self = $class->SUPER::new(@rest);

    my $parser = XML::DOM::Parser->new();

    my $dom = $parser->parsefile($self->projectfile);

    my $project = Westley::Project->new(%$self, dom => $dom);

    return $project;
}



1;
__END__

=head1 NAME

Westley - Perl extension for modifying Westley XML files

=head1 SYNOPSIS

  use File::Class qw(dir file);
  use Westley;

  my $p = Westley->project(
    projectfile => file('path/to/westley-project.xml'),
    workdir     => dir('path/to/workdir'),
    pathpatterns    => {
        'my/stubfiles/' => 'my/originals/'.
    },
  );

  $p->write('to/modified-project.xml');


=head1 DESCRIPTION

This module alters a Westley XML project from using small video stub files
to use the original video files.

It creates a workdir of choice, to store all altered project files in.

It rewrites the path of the video files.
It must know the path pattern to the smaller video (proxy) files
and the path pattern to the original video files.

For project that uses westley XML files, new westley XML files are created
that points to the original video files. These will be created in the workdir.

The parent westley XML file is then rewritten
to use the new westley XML files from the workdir. This works recursively

The project westley XML file is finally written to a file of choice.


=head2 EXPORT

None by default.


=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

Knut-Olav Hoven, E<lt>hovenko@E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Knut-Olav Hoven

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.0 or,
at your option, any later version of Perl 5 you may have available.


=cut
