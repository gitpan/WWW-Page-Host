use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME		=> 'WWW::Page::Host',
    VERSION_FROM	=> 'lib/WWW/Page/Host.pm',
    PREREQ_PM => {
		'Carp' => 0,
		'Pod::Coverage' => 0.09,
		'Module::Info' => 0.12,
		'Net::DNS' => 0.12,
		'Test::More' => 0.41,
		'constant' => 1.02,
		'Data::Dumper' => 2.102,
		'URI::URL' => 5.02,
	    },
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'lib/WWW/Page/Host.pm', # retrieve abstract from module
      AUTHOR     => 'Iain Truskett <spoon@cpan.org>') : ()),
);


