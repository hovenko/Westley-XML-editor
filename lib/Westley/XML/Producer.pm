package Westley::XML::Producer;

use strict;
use warnings;

use Moose;
extends qw(Westley::XML);

use Westley::XML::Property;


=head1 NAME

Westley::XML::Producer - Perl extension for modifying Westley XML files

=head1 DESCRIPTION


=cut


sub is_westley {
    my ($self) = @_;

    return 1 if $self->mlt_service eq 'westley';
    return;
}


sub is_avformat {
    my ($self) = @_;

    return 1 if $self->mlt_service eq 'avformat';
    return;
}


sub resource {
    my ($self) = @_;

    return $self->property_by_name("resource");
}


sub mlt_service {
    my ($self) = @_;

    return $self->property_by_name("mlt_service");
}


sub rewrite_resource {
    my ($self, %patterns) = @_;

    my $resource    = $self->resource;
    my $path        = "$resource";

    while (my ($from, $to) = each %patterns) {
        my $tmp = $path;
        $tmp =~ s{\Q$from\E}{$to};

        if ($tmp ne $path) {
            $resource->replace_text($tmp);
            return 1;
        }
    }

    return;
}


sub replace_resource_text {
    my ($self, $text) = @_;
    my $resource = $self->resource;
    $resource->replace_text($text);
}




sub property_by_name {
    my ($self, $name) = @_;

    my ($element) = grep {
        $_->getAttribute('name') eq "$name"
    } $self->property_elements;

    return unless $element;

    my $property = Westley::XML::Property->new(domnode => $element);
    
    return $property;
}


sub property_elements {
    my ($self) = @_;

    return grep { $_->getTagName() eq 'property' } $self->child_elements;
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

