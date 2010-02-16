package Westley::XML::Westley;

use strict;
use warnings;

use Moose;
extends qw(Westley::XML);

use Westley::XML::Producer;


=head1 NAME

Westley::XML::Westley - Perl extension for modifying Westley XML files

=head1 DESCRIPTION


=cut



sub producers {
    my ($self) = @_;

    my @elements = $self->elements_by_name('producer');

    my @producers = ();

    for my $element (@elements) {
        my $p = Westley::XML::Producer->new(domnode => $element);
        push @producers, $p;
    }

    return @producers;
}


sub elements_by_name {
    my ($self, $name) = @_;

    return grep { $_->getTagName() eq $name } $self->child_elements;
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

