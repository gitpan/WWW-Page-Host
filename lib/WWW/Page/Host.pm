package WWW::Page::Host;

use 5.006;
use strict;
use warnings;

use Carp;
use Data::Dumper;
use URI::URL;
use Net::DNS;

use constant DEBUG => 1;
use vars qw/$AUTOLOAD/;
our ( $VERSION ) = '$Revision: 1.1 $ ' =~ /\$Revision:\s+([^\s]+)/;
our @ISA = qw/Exporter/;

our %EXPORT_TAGS = ( 'all' => [ qw(get_host) ] );
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
our @EXPORT = qw(get_host);

# ========================================================================
# Methods

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
# Below is stub documentation for your module. You better edit it!

=head1 NAME

WWW::Page::Host - Perl extension for blah blah blah

=head1 SYNOPSIS

  use WWW::Page::Host;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for WWW::Page::Host, created by h2xs. It looks like
the author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head1 SEE ALSO

L<perl>

=head1 AUTHOR

Iain Truskett, <ict@eh.org>

Please report any bugs, or post any suggestions, to the
author at <perl-www_page_host@dellah.anu.edu.au>

=head1 COPYRIGHT

Copyright (c) 2001 Iain Truskett. All rights reserved.
This program is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

    $Id$

=cut
