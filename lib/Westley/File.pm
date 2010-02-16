package Westley::File;

use strict;
use warnings;

use Moose;
#extends qw(Westley::XML);

use Carp;

use Westley::XML::Westley;


has 'dom' => (
    is  => 'ro',
    isa => 'XML::DOM::Document',
    required => 1,
);


=head1 NAME

Westley::File - Represents a Westley file

=head1 DESCRIPTION


=cut


sub root_node {
    my ($self) = @_;

    my $w = Westley::XML::Westley->new(
        domnode => $self->dom->getDocumentElement,
    );

    return $w;
}


sub as_string {
    my ($self) = @_;

    my $dom = $self->dom;

    return $dom->toString;
}


sub write {
    my ($self, $file) = @_;

    $self->dom->printToFile($file)
        or croak "Failed to write file: $file";;
}


sub print {
    my ($self, $fh) = @_;

    if ($fh) {
        print { $fh } $self->as_string;
    }
    else {
        print $self->as_string;
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

