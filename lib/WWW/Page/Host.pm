package WWW::Page::Host;

=head1 NAME

WWW::Page::Host - return a uniform name for virtual hosts

=head1 SYNOPSIS

    use WWW::Page::Host;
    print get_host('http://www.apple.com/');

=head1 DESCRIPTION

The WWW::Page::Host module tries to return a canonicalish name for
a virtual host. It uses DNS to accomplish this.

This has its uses (or at least it must since the boss asked for
a program that does something like this).

=cut


use 5.006;
use strict;
use warnings;

use Carp;
use Data::Dumper;
use URI::URL;
use Net::DNS;

use constant DEBUG => 1;
use vars qw/$AUTOLOAD/;
our ( $VERSION ) = '$Revision: 1.2 $ ' =~ /\$Revision:\s+([^\s]+)/;
our @ISA = qw/Exporter/;

our %EXPORT_TAGS = ( 'all' => [ qw(get_host) ] );
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
our @EXPORT = qw(get_host);

# ========================================================================
#                                                                  Methods

=head1 EXPORTED FUNCTIONS

=over 4

=item my $canon = get_host($url);

Given a URL (either a string or a URI::URL object), this function plays
around with a DNS resolver to try to get to a reasonably canonical name
for the domain of the given URL.

=cut

sub get_host
{
    my ($url) = (@_);
    my $uri = URI::URL->new($url);
    my $host = $uri->netloc;
    my $answer = '';

    my $res = Net::DNS::Resolver->new;
    my $query = $res->search($host, 'A');
    if ($query)
    {
	foreach my $rr ($query->answer)
	{
	    if ($rr->type eq "A")
	    {
		$answer = $rr->rdatastr;
		$query = $res->search($answer);
		foreach my $rr ($query->answer)
		{
		    if ($rr->type eq "PTR")
		    {
			$answer = $rr->rdatastr;
		    }

		}
	    }
	}
    }
    else {
	print "query failed: ", $res->errorstring, "\n";
	undef $answer;
    }


#my $res = Net::DNS::Resolver->new();
#   my $result = $res->send($host);
#   print Dumper($result);
    return $answer;
	 
}

1;
__END__
#
# ========================================================================
#                                                Rest Of The Documentation

=head1 AUTHOR

Iain Truskett <spoon@cpan.org> L<http://eh.org/~koschei/>

Please report any bugs, or post any suggestions, to either the mailing
list at <perl-www@dellah.anu.edu.au> (email
<perl-www-subscribe@dellah.anu.edu.au> to subscribe) or directly to the
author at <spoon@cpan.org>

=head1 PLANS

It needs to cater for more weird and unusual ways of putting dates on
web pages.

=head1 COPYRIGHT

Copyright (c) 2001 Iain Truskett. All rights reserved. This program is
free software; you can redistribute it and/or modify it under the same
terms as Perl itself.

    $Id: Host.pm,v 1.2 2002/02/03 13:57:10 koschei Exp $

=head1 ACKNOWLEDGEMENTS

I would like to thank GRF for having me write this.

=head1 SEE ALSO

Um.

