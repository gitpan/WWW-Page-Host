use Test::More tests => 7;

my %urls =
(
    'http://www.wursthaus.com.au/'	=> qr/\.southcom\.com\.au.$/,
    'http://www.ontas.com.au/'		=> qr/\.southcom\.com\.au.$/,
    'http://www.global-online.com.au/'	=> qr/\.southcom\.com\.au.$/,
    'http://www.ontas.com.au/motors/'	=> qr/\.southcom\.com\.au.$/,
    'http://www.imask.com.au/'		=> qr/\.southcom\.com\.au.$/,
    'http://dragonlair.anu.edu.au/'	=> qr/\.anu\.edu\.au.$/,
);

BEGIN
{
    use_ok 'WWW::Page::Host';
}

foreach my $url (keys %urls)
{
    like get_host($url) => $urls{$url}, $url;
}
