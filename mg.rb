# encoding: utf-8

class Node
  attr_reader :id

  def initialize(graph, id, label, style)
    @graph = graph
    @id = id
    @label = label
    @style = style
  end

  def generate_dot
    "#{@id} [label=#{@label.inspect} #{@style}];"
  end

  #
  # DSL methods
  #

  def edge(other_node, style)
    @graph.edge(self, other_node, style)
  end

  def member(person)
    person.edge(self, '')
  end

  def guest(person)
    person.edge(self, 'style=dashed label=guest')
  end
end

class Edge
  def initialize(graph, source, target, style)
    @graph = graph
    @source = source
    @target = target
    @style = style
  end

  def generate_dot
    "#{@source.id} -> #{@target.id} [#{@style}];"
  end
end

class Graph
  def initialize
    @next_id = 0
    @nodes = []
    @edges = []
  end

  def next_id
    id = "_#{@next_id}"
    @next_id += 1
    id
  end

  def generate_dot
    dot = "digraph {\n"

    attributes = {
      layout: 'sfdp',
      sep: '"+12"',
      overlap: 'scalexy',
      splines: 'true',
      repulsiveforce: '2.5',
    }

    attributes.each do |attr, val|
      dot.concat("  #{attr}=#{val};\n")
    end

    @nodes.each do |node|
      dot.concat("  #{node.generate_dot}\n")
    end

    @edges.each do |edge|
      dot.concat("  #{edge.generate_dot}\n")
    end

    dot.concat('}')
  end

  #
  # DSL methods
  #

  def node(label, style)
    node = Node.new(self, next_id, label, style)
    @nodes.push(node)
    node
  end

  def band(name)
    node(name, 'shape=box')
  end

  def person(name)
    node(name, '')
  end

  def edge(source, target, style)
    edge = Edge.new(self, source, target, style)
    @edges.push(edge)
    edge
  end
end

g = Graph.new

_68                     = g.band "'68"
akron_family            = g.band 'Akron/Family'
alice_cooper            = g.band 'Alice Cooper'
alice_in_chains         = g.band 'Alice in Chains'
angels_of_light         = g.band 'Angels of Light'
annihilator             = g.band 'Annihilator'
a_perfect_circle        = g.band 'A Perfect Circle'
arcade_fire             = g.band 'Arcade Fire'
as_cities_burn          = g.band 'As Cities Burn'
audioslave              = g.band 'Audioslave'
black_ox_orkestar       = g.band 'Black Ox Orkestar'
bonnie_prince_billy     = g.band "Bonnie 'Prince' Billy"
broken_social_scene     = g.band 'Broken Social Scene'
chavez                  = g.band 'Chavez'
clipping                = g.band 'clipping.'
codeine                 = g.band 'Codeine'
coheed_and_cambria      = g.band 'Coheed and Cambria'
deftones                = g.band 'Deftones'
dream_theater           = g.band 'Dream Theater'
efrim_menuck            = g.band 'Efrim Manuel Menuck'
foo_fighters            = g.band 'Foo Fighters'
fugazi                  = g.band 'Fugazi'
gastr_del_sol           = g.band 'Gastr del Sol'
geology                 = g.band 'Geology'
gybe                    = g.band 'Godspeed You! Black Emperor'
hrsta                   = g.band 'HṚṢṬA'
jarboe_solo             = g.band 'Jarboe'
june_of_44              = g.band 'June of 44'
linkin_park             = g.band 'Linkin Park'
listener                = g.band 'Listener'
low                     = g.band 'Low'
marilyn_manson          = g.band 'Marilyn Manson'
megadeth                = g.band 'Megadeth'
metallica               = g.band 'Metallica'
molasses                = g.band 'Molasses'
mwy                     = g.band 'mewithoutYou'
nine_inch_nails         = g.band 'Nine Inch Nails'
nirvana                 = g.band 'Nirvana'
nmh                     = g.band 'Neutral Milk Hotel'
norma_jean              = g.band 'Norma Jean'
palace_brothers         = g.band 'Palace Brothers'
paramore                = g.band 'Paramore'
pearl_jam               = g.band 'Pearl Jam'
queens_club             = g.band 'Queens Club'
queens_of_the_stone_age = g.band 'Queens of the Stone Age'
rachels                 = g.band "Rachel's"
ratm                    = g.band 'Rage Against The Machine'
rhcp                    = g.band 'Red Hot Chili Peppers'
rodan                   = g.band 'Rodan'
run_the_jewels          = g.band 'Run the Jewels'
savatage                = g.band 'Savatage'
sftf                    = g.band 'Set Fire To Flames'
shipping_news           = g.band 'Shipping News'
slint                   = g.band 'Slint'
sonic_youth             = g.band 'Sonic Youth'
soundgarden             = g.band 'Soundgarden'
squirrel_bait           = g.band 'Squirrel Bait'
sunny_day_real_estate   = g.band 'Sunny Day Real Estate'
superwolf               = g.band "Bonnie 'Prince' Billy + Matt Sweeney"
swans                   = g.band 'Swans'
tenacious_d             = g.band 'Tenacious D'
the_chariot             = g.band 'The Chariot'
the_for_carnation       = g.band 'The For Carnation'
the_smashing_pumpkins   = g.band 'The Smashing Pumpkins'
the_sonora_pine         = g.band 'The Sonora Pine'
tool                    = g.band 'Tool'
tortoise                = g.band 'Tortoise'
tsmz                    = g.band 'Thee Silver Mt. Zion Memorial Orchestra'
tso                     = g.band 'Trans-Siberian Orchestra'
zwan                    = g.band 'Zwan'

# TODO: Factor some of this out.
akron_family.edge angels_of_light, 'label="guest + split" style=dashed'
low.edge gybe, 'label="live performance" style=dotted dir=none'
molasses.edge swans, 'label="lyrical ref." style=dotted'
mwy.edge fugazi, 'label="lyrical ref." style=dotted'
mwy.edge nmh, 'label="lyrical ref." style=dotted'
mwy.edge norma_jean, 'label=split style=dashed dir=none'

amar_t          = g.person 'Thierry Amar'
boo_g           = g.person 'Gangsta Boo'
brashear_t      = g.person 'Todd Brashear'
bryant_d        = g.person 'David Bryant'
cameron_m       = g.person 'Matt Cameron'
cawdron_b       = g.person 'Bruce Cawdron'
chamberlin_j    = g.person 'Jimmy Chamberlin'
cobain_k        = g.person 'Kurt Cobain'
commerford_t    = g.person 'Tim Commerford'
cook_t          = g.person 'Todd Cook'
corgan_b        = g.person 'Billy Corgan'
cornell_c       = g.person 'Chris Cornell'
coultas_k       = g.person 'Kevin Coultas'
crabtree_k      = g.person 'Kyle Crabtree'
degrasso_j      = g.person 'Jimmy DeGrasso'
eaton_d         = g.person 'Dan Eaton'
enigk_j         = g.person 'Jeremy Enigk'
everman_j       = g.person 'Jason Everman'
foon_b          = g.person 'Beckie Foon'
gilmore_s       = g.person 'Scott Gilmore'
gira_m          = g.person 'Michael Gira'
girt_a          = g.person 'Aidan Girt'
goldsmith_w     = g.person 'William Goldsmith'
grimes_r        = g.person 'Rachel Grimes'
grohl_d         = g.person 'Dave Grohl'
grubbs_d        = g.person 'David Grubbs'
harris_t        = g.person 'Thor Harris'
hawkins_t       = g.person 'Taylor Hawkins'
herndon_j       = g.person 'Johnny Herndon'
irons_j         = g.person 'Jack Irons'
jarboe          = g.person 'Jarboe'
jehanian_g      = g.person 'Greg Jehanian'
keenan_m        = g.person 'Maynard James Keenan'
lenchantin_p    = g.person 'Paz Lenchantin'
mangini_m       = g.person 'Mike Mangini'
mangum_j        = g.person 'Jeff Mangum'
mccombs_d       = g.person 'Doug McCombs'
mcmahan_b       = g.person 'Brian McMahan'
mcmahan_m       = g.person 'Michael McMahan'
meadows_s       = g.person 'Sean Meadows'
mendel_n        = g.person 'Nate Mendel'
menuck_e        = g.person 'Efrim Menuck'
morello_t       = g.person 'Tom Morello'
moss_j          = g.person 'Jessica Moss'
moya_m          = g.person 'Mike Moya'
mueller_j       = g.person 'Jeff Mueller'
mustaine_d      = g.person 'Dave Mustaine'
noble_j         = g.person 'Jason Noble'
novoselic_k     = g.person 'Krist Novoselic'
oldham_w        = g.person 'Will Oldham'
oneil_j         = g.person "Tara Jane O'Neil"
orourke_j       = g.person "Jim O'Rourke"
pajo_d          = g.person 'David Pajo'
parker_m        = g.person 'Mimi Parker'
payant_d        = g.person 'David Payant'
pitrelli_a      = g.person 'Al Pitrelli'
pratt_t         = g.person 'Thea Pratt'
reznor_t        = g.person 'Trent Reznor'
rocha_z         = g.person 'Zack de la Rocha'
ryan_j          = g.person 'Jake Ryan'
scharin_d       = g.person 'Doug Scharin'
scogin_j        = g.person 'Josh Scogin'
shalabi_s       = g.person 'Sam Shalabi'
sherinian_d     = g.person 'Derek Sherinian'
smith_d         = g.person 'Dan Smith'
sparhawk_a      = g.person 'Alan Sparhawk'
sweeney_m       = g.person 'Matt Sweeney'
tellier_craig_r = g.person 'Roger Tellier-Craig'
trudeau_s       = g.person 'Sophie Trudeau'
walford_b       = g.person 'Britt Walford'
waters_j        = g.person 'Jeff Waters'
weiss_a         = g.person 'Aaron Weiss'
wilk_b          = g.person 'Brad Wilk'
williams_h      = g.person 'Hayley Williams'

g.edge cook_t, slint, 'label=touring style=dashed'
g.edge mcmahan_m, slint, 'label=touring style=dashed'

_68.member scogin_j
alice_cooper.guest cornell_c
alice_cooper.member degrasso_j
alice_cooper.member pitrelli_a
alice_cooper.member sherinian_d
alice_in_chains.guest cornell_c
angels_of_light.guest harris_t
angels_of_light.member gira_m
annihilator.member mangini_m
annihilator.member waters_j
a_perfect_circle.guest reznor_t
a_perfect_circle.member keenan_m
a_perfect_circle.member lenchantin_p
arcade_fire.guest moss_j
arcade_fire.guest trudeau_s
as_cities_burn.guest scogin_j
audioslave.member commerford_t
audioslave.member cornell_c
audioslave.member morello_t
audioslave.member wilk_b
black_ox_orkestar.member amar_t
black_ox_orkestar.member gilmore_s
black_ox_orkestar.member moss_j
bonnie_prince_billy.member oldham_w
broken_social_scene.guest moss_j
chavez.member sweeney_m
clipping.guest boo_g
codeine.guest grubbs_d
codeine.member scharin_d
coheed_and_cambria.member hawkins_t
deftones.guest keenan_m
dream_theater.member mangini_m
dream_theater.member sherinian_d
efrim_menuck.guest moss_j
efrim_menuck.guest payant_d
efrim_menuck.member menuck_e
foo_fighters.guest novoselic_k
foo_fighters.member goldsmith_w
foo_fighters.member grohl_d
foo_fighters.member hawkins_t
foo_fighters.member mendel_n
gastr_del_sol.member grubbs_d
gastr_del_sol.member orourke_j
geology.member jehanian_g
gybe.member amar_t
gybe.member bryant_d
gybe.member cawdron_b
gybe.member girt_a
gybe.member menuck_e
gybe.member moya_m
gybe.member pratt_t
gybe.member tellier_craig_r
hrsta.member moya_m
hrsta.member trudeau_s
jarboe_solo.guest lenchantin_p
jarboe_solo.member jarboe
june_of_44.member meadows_s
june_of_44.member mueller_j
june_of_44.member scharin_d
linkin_park.guest cornell_c
listener.member smith_d
low.member parker_m
low.member sparhawk_a
marilyn_manson.guest corgan_b
marilyn_manson.guest reznor_t
megadeth.member degrasso_j
megadeth.member mustaine_d
megadeth.member pitrelli_a
metallica.member mustaine_d
molasses.guest shalabi_s
molasses.member amar_t
molasses.member moya_m
mwy.guest enigk_j
mwy.guest williams_h
mwy.member jehanian_g
mwy.member weiss_a
nine_inch_nails.guest grohl_d
nine_inch_nails.member reznor_t
nirvana.member cobain_k
nirvana.member everman_j
nirvana.member grohl_d
nirvana.member novoselic_k
nmh.member mangum_j
norma_jean.guest weiss_a
norma_jean.member scogin_j
palace_brothers.member brashear_t
palace_brothers.member mcmahan_b
palace_brothers.member oldham_w
palace_brothers.member walford_b
paramore.member williams_h
pearl_jam.member cameron_m
pearl_jam.member irons_j
queens_club.member eaton_d
queens_club.member ryan_j
queens_of_the_stone_age.guest lenchantin_p
queens_of_the_stone_age.guest reznor_t
queens_of_the_stone_age.member grohl_d
rachels.guest mueller_j
rachels.member coultas_k
rachels.member crabtree_k
rachels.member grimes_r
rachels.member noble_j
ratm.guest keenan_m
ratm.member commerford_t
ratm.member morello_t
ratm.member rocha_z
ratm.member wilk_b
rhcp.member irons_j
rodan.member coultas_k
rodan.member mueller_j
rodan.member noble_j
rodan.member oneil_j
run_the_jewels.guest boo_g
run_the_jewels.guest rocha_z
run_the_jewels.guest sweeney_m
savatage.guest waters_j
savatage.member pitrelli_a
sftf.member bryant_d
sftf.member cawdron_b
sftf.member foon_b
sftf.member girt_a
sftf.member moya_m
sftf.member pratt_t
sftf.member tellier_craig_r
shipping_news.member cook_t
shipping_news.member crabtree_k
shipping_news.member mueller_j
shipping_news.member noble_j
slint.member brashear_t
slint.member mcmahan_b
slint.member pajo_d
slint.member walford_b
sonic_youth.member orourke_j
soundgarden.member cameron_m
soundgarden.member cornell_c
soundgarden.member everman_j
squirrel_bait.member grubbs_d
squirrel_bait.member mcmahan_b
squirrel_bait.member walford_b
sunny_day_real_estate.member enigk_j
sunny_day_real_estate.member goldsmith_w
sunny_day_real_estate.member mendel_n
superwolf.member oldham_w
superwolf.member sweeney_m
swans.guest parker_m
swans.guest sparhawk_a
swans.member gira_m
swans.member harris_t
swans.member jarboe
tenacious_d.guest grohl_d
the_chariot.guest smith_d
the_chariot.guest weiss_a
the_chariot.guest williams_h
the_chariot.member eaton_d
the_chariot.member ryan_j
the_chariot.member scogin_j
the_for_carnation.guest walford_b
the_for_carnation.member cook_t
the_for_carnation.member herndon_j
the_for_carnation.member mccombs_d
the_for_carnation.member mcmahan_b
the_for_carnation.member mcmahan_m
the_for_carnation.member pajo_d
the_smashing_pumpkins.member chamberlin_j
the_smashing_pumpkins.member corgan_b
the_sonora_pine.guest grimes_r
the_sonora_pine.member coultas_k
the_sonora_pine.member meadows_s
the_sonora_pine.member oneil_j
tool.member keenan_m
tortoise.member herndon_j
tortoise.member mccombs_d
tortoise.member pajo_d
tsmz.guest girt_a
tsmz.guest shalabi_s
tsmz.member amar_t
tsmz.member foon_b
tsmz.member gilmore_s
tsmz.member menuck_e
tsmz.member moss_j
tsmz.member payant_d
tsmz.member trudeau_s
tso.member pitrelli_a
zwan.member chamberlin_j
zwan.member corgan_b
zwan.member lenchantin_p
zwan.member pajo_d
zwan.member sweeney_m

puts g.generate_dot
