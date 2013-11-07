# NAME

Encode::Entity::NCR - Numeric character reference encoding

# SYNOPSIS

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



# DESCRIPTION

Encode::Entity::NCR is an Encoding module to represent HTML/XML
numeric character references like "&\#x5b9f;" or "&\#23455;".

# BUGS AND LIMITATIONS

Please report any bugs or feature requests to
[https://github.com/UCormorant/p5-encode-entitiy-ncr/issues](https://github.com/UCormorant/p5-encode-entitiy-ncr/issues)

# AUTHOR

U=Cormorant <u@chimata.org>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. See [perlartistic](http://search.cpan.org/perldoc?perlartistic).

# SEE ALSO

[Encode](http://search.cpan.org/perldoc?Encode)
