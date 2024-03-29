$| = 1; # nicer to pipes
$\ = "\n"; # less to type?

my @test = ( # a series of test subs, which return true for success, 0 otherwise
	sub { require MPEG::Audio::Frame }, # see if it actually loads
	sub {
		my $frame = MPEG::Audio::Frame->read(\*DATA) || return undef; # read the next frame from the data bit
		
		return undef unless (
			$frame->bitrate() == 128 and
			$frame->sample() == 44100 and
			int($frame->seconds()*10000) == 261 and
			$frame->length() == 418 and
		1);
		
		return undef if MPEG::Audio::Frame->read(\*DATA);
		
		1; # we made it
	},
);

print "1..", scalar @test; # the number of tests we have

my $i = 0; # a counter

foreach (@test) { print (((&$_) ? "" : "not ") . "ok " . ++$i) } # test away

__DATA__
the following data is used to test the module.

and mp3 header and frame will follow this (text|garbage)
and will be parsed and munged and whatever.

here goes nothing...



���@     7�     �      �      �                                                                                                                                                                                                                                                                                                                                                                                                 



this is more garbage to be ignored
