package Westley::Avformat;

use strict;
use warnings;

use Moose;
extends qw(Westley::XML::Producer);


=head1 NAME

Westley::Avformat - Represents a path to a video or audio file

=head1 DESCRIPTION

Used to rewrite the path to stub video files to original video files.

=cut


sub rewrite_resource {
    my ($self, %patterns) = @_;

    my $resource    = $self->resource;
    my $path        = "$resource";

    while (my ($from, $to) = each %patterns) {
        my $tmp = $path;
        $tmp =~ s{\Q$from\E}{$to};
        if (!-f $tmp) {
            print STDERR "Path $path rewritten does not exist: $tmp\n";
        }
        else {
            $resource->replace_text($tmp);
        }
    }
}



=head1 AUTHOR

 Knut-Olav Hoven, E<lt>knutolav@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Knut-Olav Hoven

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.0 or,
at your option, any later version of Perl 5 you may have available.

=cut

1;

