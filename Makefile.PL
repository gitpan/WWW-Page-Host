use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME		=> 'WWW::Page::Host',
    VERSION_FROM	=> 'lib/WWW/Page/Host.pm',
    PREREQ_PM => {
	'Getopt::Std'	=> 1.02,
	'Test::More'	=> 0.33,
	'Net::DNS::Resolver' => 0.12,
	'Carp'		=> 0,
    },
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'lib/WWW/Page/Host.pm', # retrieve abstract from module
      AUTHOR     => 'Iain Truskett <ict@eh.org>') : ()),
);
