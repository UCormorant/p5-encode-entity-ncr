use Test::Simple tests => 6;

use Encode;
use Encode::Entity::NCR;

  my $dec  = "&#25968;&#20516;&#23455;&#20307;&#21442;&#29031;";
  my $hex  = "&#x6570;&#x5024;&#x5b9f;&#x4f53;&#x53c2;&#x7167;";
  my $utf8 = "\x{6570}\x{5024}\x{5b9f}\x{4f53}\x{53c2}\x{7167}";
  my $hex_dec  = "&#x6570;&#x5024;&#x5b9f;&#20307;&#21442;&#29031;";
  my $hex_utf8 = "&#x6570;&#x5024;&#x5b9f;\x{4f53}\x{53c2}\x{7167}";
  my $utf8_dec = "\x{6570}\x{5024}\x{5b9f}&#20307;&#21442;&#29031;";

  # encode
  ok(encode("Entity-NCR", $utf8)     eq $hex, 'encode("Entity-NCR") works well');
  ok(encode("Entity-NCR-Dec", $utf8) eq $dec, 'encode("Entity-NCR-Dec") works well');
  ok(encode("Entity-NCR-Hex", $utf8) eq $hex, 'encode("Entity-NCR-Hex") works well');

  # decode
  ok(decode("Entity-NCR", $hex_dec)     eq $utf8,     'decode("Entity-NCR") works well');
  ok(decode("Entity-NCR-Dec", $hex_dec) eq $hex_utf8, 'decode("Entity-NCR-Dec") works well');
  ok(decode("Entity-NCR-Hex", $hex_dec) eq $utf8_dec, 'decode("Entity-NCR-Hex") works well');
