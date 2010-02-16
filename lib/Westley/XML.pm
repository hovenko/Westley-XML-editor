package Westley::XML;

use strict;
use warnings;

use Moose;


has 'domnode' => (
    is  => 'ro',
    isa => 'XML::DOM::Element',
    required => 1,
);


=head1 NAME

Westley::XML - Perl extension for modifying Westley XML files

=head1 DESCRIPTION


=cut



sub child_elements {
    my ($self) = @_;

    return grep { UNIVERSAL::isa($_, "XML::DOM::Element") } $self->child_nodes;
}


sub text_nodes {
    my ($self) = @_;

    return grep { UNIVERSAL::isa($_, "XML::DOM::Text") } $self->child_nodes;
}


sub child_nodes {
    my ($self) = @_;

    return $self->domnode->getChildNodes;
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

