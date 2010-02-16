package Westley::Project;

use strict;
use warnings;

use Moose;
extends qw(Westley Westley::File);

use Westley::Avformat;


=head1 NAME

Westley::Project - Represents the Westley project file

=head1 DESCRIPTION


=cut


sub work {
    my ($self) = @_;

    $self->_prepare_workdir;

    my $root_node = $self->root_node;
    my @producers = $root_node->producers;

    my $counter = 0;

    for my $producer (@producers) {
        #printf(
        #    "%i %s %s\n",
        #    $producer->is_westley ? 1 : 0,
        #    $producer->mlt_service,
        #    $producer->resource
        #);

        if ($producer->is_westley) {
            $counter++;

            my $w = Westley->project(
                %$self,
                workdir     => $self->workdir->subdir("".$counter),
                projectfile => Path::Class::File->new($producer->resource),
            );

            $w->work;

            $producer->replace_resource_text($w->file_modified->absolute);
        }

        if ($producer->is_avformat) {
            my $avformat = Westley::Avformat->new(%$producer);
            $avformat->rewrite_resource(%{$self->pathpatterns});
        }

    }

    $self->write_modified;
}


sub _prepare_workdir {
    my ($self) = @_;

    my $workdir = $self->workdir;
    return if -d $workdir->absolute;
    $workdir->mkpath() or die "Failed to create workdir: ".$workdir->absolute;
}


sub write_modified {
    my ($self) = @_;

    my $newfile = $self->file_modified;
    my $path = $newfile->absolute;
    $self->write($path);
}


sub file_modified {
    my ($self) = @_;

    my $workdir = $self->workdir;
    my $file    = $self->projectfile;

    my $newfile = $workdir->file($file->basename);

    return $newfile;
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

