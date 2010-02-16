package Westley::XML::Property;

use strict;
use warnings;

use Moose;
extends qw(Westley::XML);


=head1 NAME

Westley::XML::Property - Perl extension for modifying Westley XML files

=head1 DESCRIPTION


=cut


use overload
    q{""} => \&string_value,
    fallback => 1,
;

sub string_value {
    my ($self) = @_;

    my $str = "";
    for my $text ($self->text_nodes) {
        $str .= $text->getData;
    }

    return $str;
}


sub replace_text {
    my ($self, $text) = @_;

    my @delete = $self->text_nodes;
    for my $_ (@delete) {
        $self->domnode->removeChild($_);
    }

    $self->domnode->addText($text);
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

