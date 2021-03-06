# This is a template for a Perl scraper on Morph (https://morph.io)
# including some code snippets below that you should find helpful

 use LWP::Simple;
 use HTML::TreeBuilder;
 use Database::DumpTruck;
 use JSON::XS;
 #use strict;
 use warnings;
 
#JSON->convert_blessed ( [ 1 ] );
#JSON::allow_nonref(1);
# # Read out and parse a web page
 my $tb = HTML::TreeBuilder->new_from_content(get('http://www.bratislava.sk/register/vismo/zobraz_dok.asp?id_org=700026&id_ktg=1020&sz=zmena%5Fformalni&sz=vznik%5Fformalni&sz=schvaleni%5Fdatum&sz=zruseni%5Fdatum&sz=nazev&sz=nazev%5Fplny&sz=strvlastnik&sz=zverejneno%5Fod&sz=zverejneno%5Fdo&sz=ucinnost%5Fod&sz=ucinnost%5Fdo&sz=ud%5Fod&sz=ud%5Fdo&p1=15333&archiv=1'));

 # Look for <tr>s of <table id="hello">
 my @rows = $tb->look_down(
     _tag => 'tr' #,
 #    sub { shift->parent->attr('class') eq 'seznam' }
 );

print "pocet riadkov je $#rows\n";
#print (@rows);
#print "@rows";
#print encode_json ( ($rows[1]->look_down(_tag => 'td'))[0]->content);

for my $i (1 .. $#rows) #skip 0th (header)
{
   print "riadok: $i\n"; 
  # print encode_json $rows[$i];
   $_ = $rows[$i];
   $tds=$_->find('td');
   if($#tds)
   {
   #print encode_json $tds;
     print  $tds[0];
     print  $tds[4];
   }
   #$dt->insert([(Datum => $tds[0]->content,     Nazov => $tds[4]->content)]);
}


# # Open a database handle
#my $dt = Database::DumpTruck->new({dbname => 'data.sqlite', table => 'data'});
#
 # Insert content of <td id="name"> and <td id="age"> into the database
# $dt->insert([map {{
##     Datum => $_->look_down(_tag => 'td', id => 'age')->content,
#     Datum => ($_->find('td'))[0]->content,
#     Nazov => ($_->look_down(_tag => 'td'))[4]->content,
# }} @rows]);

# You don't have to do things with the HTML::TreeBuilder and Database::DumpTruck
# libraries. You can use whatever libraries are installed on Morph for Perl
# (https://github.com/openaustralia/morph-docker-perl/blob/master/Dockerfile)
# and all that matters is that your final data is written to an Sqlite
# database called data.sqlite in the current working directory which has at
# least a table called data.
