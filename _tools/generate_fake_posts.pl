#!/usr/bin/env perl

use warnings;
use strict;

my @post_templates = ();

{
    open FILE, "<", "./post_template.md" or die $!;

    my $content = do { local $/; <FILE>; };
    push @post_templates, $content;

    close FILE;
}

my @chars = ();

push @chars, chr($_) foreach (ord('0')..ord('9'));
push @chars, chr($_) foreach (ord('a')..ord('z'));
push @chars, chr($_) foreach (ord('A')..ord('Z'));

sub generate_word {
    my $len = shift || 1;
    my $name = "";

    $name .= $chars[int(rand(@chars))] for (0..(5+$len));

    return $name;
}

sub generate_date() {
    my $year = 1990 + int(rand(2022 - 1990));
    my $month = int(rand(12)) + 1;
    my $day = int(rand(30)) + 1;

    return sprintf("%d-%02d-%02d", $year, $month, $day);
}

sub generate_time() {
    my $hours = int(rand(24));
    my $minutes = int(rand(60));
    my $seconds = int(rand(60));

    return sprintf("%02d:%02d:%02d", $hours, $minutes, $seconds);

}

sub generate_name() {
    my $name = generate_word(int(rand(6)));

    $name .= "-" . generate_word(int(rand(6))) for (0..int(rand(4)));

    return $name;
}

my @categories = qw / CateA CateB CateC CateD /;
my @subcategories = qw / SubCateA SubCateB SubCateC /;

for (0..100) {
    my $date = generate_date();

    for (1..int(rand(20))) {
        my $time = generate_time();
        my $name = generate_name();
        my $path = "../_posts/$date-$name.md";
        my $title = generate_word(5 + int(rand(3)));
        my @cates = ( $categories[int(rand(@categories))] );

        push @cates, $subcategories[int(rand(@subcategories))] if int(rand(2)) > 0;

        open FILE, ">", $path or die $!;
        print FILE "---", "\n";
        print FILE "title: $title", "\n";
        print FILE "date: $date $time", "\n";
        print FILE "categories: [".join(",", @cates)."]", "\n";
        print FILE "---", "\n";
        print FILE $post_templates[int(rand(@post_templates))];
        close FILE;
    }
}
