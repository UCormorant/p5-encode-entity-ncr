package Encode::Entity::NCR;

use strict;
our $VERSION = '0.0.1';

use base qw(Encode::Encoding);
use Encode qw(:fallbacks);

for my $name (qw/Entity-NCR Entity-NCR-Dec Entity-NCR-Hex/) {
    my $dec = $name eq 'Entity-NCR-Hex' ? 0 : 1;
    my $hex = $name eq 'Entity-NCR-Dec' ? 0 : 1;

    $Encode::Encoding{$name} = bless {
        Name => $name,
        dec  => $dec,
        hex  => $hex,
    } => __PACKAGE__;
}

sub decode($$;$){
    my ($obj, $buf, $chk) = @_;
    my ($dec, $hex) = @{$obj}{qw/dec hex/};
    $buf =~ s/&#(\d+);/chr $1/eg if $dec;
    $buf =~ s/&#[Xx]([\dA-Fa-f]+);/chr hex $1/eg if $hex;
    $_[1] = '' if $chk; # this is what in-place edit means
    return $buf;
}

sub encode($$;$){
    my ($obj, $str, $chk) = @_;
    my $hex = $obj->{hex};
    $str = Encode::encode("ascii", $str, $hex ? FB_XMLCREF : FB_HTMLCREF);
    $_[1] = '' if $chk; # this is what in-place edit means
    return $str;
}

1;
__END__

=head1 NAME

Encode::Entity::NCR - Numeric character reference encoding

=head1 SYNOPSIS

  use Encode qw(encode decode :fallbacks);
  use Encode::Entity::NCR;

  # encode
  my $ncr;
  my $utf8 = "\x{6570}\x{5024}\x{5b9f}\x{4f53}\x{53c2}\x{7167}";
  $ncr = encode("ascii", $utf8, FB_XMLCREF); # &#x6570;&#x5024;&#x5b9f;&#x4f53;&#x53c2;&#x7167;
  $ncr = encode("Entity-NCR", $utf8);        # &#x6570;&#x5024;&#x5b9f;&#x4f53;&#x53c2;&#x7167;
  $ncr = encode("Entity-NCR-Hex", $utf8);    # &#x6570;&#x5024;&#x5b9f;&#x4f53;&#x53c2;&#x7167;

  $ncr = encode("ascii", $utf8, FB_HTMLCREF); # &#25968;&#20516;&#23455;&#20307;&#21442;&#29031;
  $ncr = encode("Entity-NCR-Dec", $utf8);     # &#25968;&#20516;&#23455;&#20307;&#21442;&#29031;

  # decode
  $utf8 = $ncr = "&#x6570;&#x5024;&#x5b9f;&#20307;&#21442;&#29031;";
  $utf8 =~ s/&#([Xx])?([\dA-Fa-f]+);/chr($1?hex $2:$2)/eg; # 数値実体参照
  $utf8 = decode("Entity-NCR", $ncr);                      # 数値実体参照

  $utf8 = $ncr;
  $utf8 =~ s/&#(\d+);/chr $1/eg;          # &#x6570;&#x5024;&#x5b9f;体参照
  $utf8 = decode("Entity-NCR-Dec", $ncr); # &#x6570;&#x5024;&#x5b9f;体参照

  $utf8 = $ncr;
  $utf8 =~ s/&#[Xx]([\dA-Fa-f]+);/chr hex $1/eg; # 数値実&#20307;&#21442;&#29031;
  $utf8 = decode("Entity-NCR-Hex", $ncr);        # 数値実&#20307;&#21442;&#29031;


=head1 DESCRIPTION

Encode::Entity::NCR is an Encoding module to represent HTML/XML
character references like "&#x5b9f;" or "&#23455;".

=head1 AUTHOR

Uchimata E<lt>cheap.sheep.u@gmail.comE<gt>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<Encode>

=cut
