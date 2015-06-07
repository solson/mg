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

_1_speed_bike           = g.band '1-Speed Bike'
_68                     = g.band "'68"
a7x                     = g.band 'Avenged Sevenfold'
akron_family            = g.band 'Akron/Family'
alice_cooper            = g.band 'Alice Cooper'
alice_in_chains         = g.band 'Alice in Chains'
angels_of_light         = g.band 'Angels of Light'
annihilator             = g.band 'Annihilator'
a_perfect_circle        = g.band 'A Perfect Circle'
arcade_fire             = g.band 'Arcade Fire'
as_cities_burn          = g.band 'As Cities Burn'
audioslave              = g.band 'Audioslave'
bastro                  = g.band 'Bastro'
big_black               = g.band 'Big Black'
black_flag              = g.band 'Black Flag'
black_ox_orkestar       = g.band 'Black Ox Orkestar'
black_sabbath           = g.band 'Black Sabbath'
bonnie_prince_billy     = g.band "Bonnie 'Prince' Billy"
broken_social_scene     = g.band 'Broken Social Scene'
chavez                  = g.band 'Chavez'
circus_mort             = g.band 'Circus Mort'
clipping                = g.band 'clipping.'
codeine                 = g.band 'Codeine'
coheed_and_cambria      = g.band 'Coheed and Cambria'
come                    = g.band 'Come'
deftones                = g.band 'Deftones'
devo                    = g.band 'Devo'
dirty_three             = g.band 'Dirty Three'
dream_theater           = g.band 'Dream Theater'
efrim_menuck            = g.band 'Efrim Manuel Menuck'
electric_sheep          = g.band 'Electric Sheep'
faith_no_more           = g.band 'Faith No More'
fear_factory            = g.band 'Fear Factory'
foo_fighters            = g.band 'Foo Fighters'
fugazi                  = g.band 'Fugazi'
gastr_del_sol           = g.band 'Gastr del Sol'
geology                 = g.band 'Geology'
guns_n_roses            = g.band "Guns N' Roses"
gybe                    = g.band 'Godspeed You! Black Emperor'
him                     = g.band 'HiM'
hoover                  = g.band 'Hoover'
hrsta                   = g.band 'HṚṢṬA'
in_the_fishtank_7       = g.band 'Low + Dirty Three'
intl_shades             = g.band "Int'l Shades"
isis                    = g.band 'Isis'
jarboe_solo             = g.band 'Jarboe'
june_of_44              = g.band 'June of 44'
linkin_park             = g.band 'Linkin Park'
listener                = g.band 'Listener'
live_skull              = g.band 'Live Skull'
low                     = g.band 'Low'
marilyn_manson          = g.band 'Marilyn Manson'
matana_roberts          = g.band 'Matana Roberts'
megadeth                = g.band 'Megadeth'
metallica               = g.band 'Metallica'
mission_of_burma        = g.band 'Mission of Burma'
molasses                = g.band 'Molasses'
mwy                     = g.band 'mewithoutYou'
nine_inch_nails         = g.band 'Nine Inch Nails'
nirvana                 = g.band 'Nirvana'
nmh                     = g.band 'Neutral Milk Hotel'
norma_jean              = g.band 'Norma Jean'
pantera                 = g.band 'Pantera'
paramore                = g.band 'Paramore'
pearl_jam               = g.band 'Pearl Jam'
primus                  = g.band 'Primus'
pullman                 = g.band 'Pullman'
puscifer                = g.band 'Puscifer'
queen                   = g.band 'Queen'
queens_club             = g.band 'Queens Club'
queens_of_the_stone_age = g.band 'Queens of the Stone Age'
rachels                 = g.band "Rachel's"
rapeman                 = g.band 'Rapeman'
ratm                    = g.band 'Rage Against The Machine'
rex                     = g.band 'Rex'
rhcp                    = g.band 'Red Hot Chili Peppers'
rodan                   = g.band 'Rodan'
run_dmc                 = g.band 'Run-DMC'
run_the_jewels          = g.band 'Run the Jewels'
savatage                = g.band 'Savatage'
scratch_acid            = g.band 'Scratch Acid'
serj_tankian            = g.band 'Serj Tankian'
sftf                    = g.band 'Set Fire To Flames'
shellac                 = g.band 'Shellac'
shipping_news           = g.band 'Shipping News'
slint                   = g.band 'Slint'
snoop_dogg              = g.band 'Snoop Dogg'
soad                    = g.band 'System of a Down'
sonic_youth             = g.band 'Sonic Youth'
soundgarden             = g.band 'Soundgarden'
squirrel_bait           = g.band 'Squirrel Bait'
sunny_day_real_estate   = g.band 'Sunny Day Real Estate'
superwolf               = g.band "Bonnie 'Prince' Billy + Matt Sweeney"
swans                   = g.band 'Swans'
tdep                    = g.band 'The Dillinger Escape Plan'
tenacious_d             = g.band 'Tenacious D'
the_brave_and_the_bold  = g.band "Bonnie 'Prince' Billy + Tortoise"
the_chariot             = g.band 'The Chariot'
the_for_carnation       = g.band 'The For Carnation'
the_jesus_lizard        = g.band 'The Jesus Lizard'
the_nightwatchman       = g.band 'The Nightwatchman'
the_offspring           = g.band 'The Offspring'
the_smashing_pumpkins   = g.band 'The Smashing Pumpkins'
the_sonora_pine         = g.band 'The Sonora Pine'
tony_iommi              = g.band 'Tony Iommi'
tool                    = g.band 'Tool'
tortoise                = g.band 'Tortoise'
tsmz                    = g.band 'Thee Silver Mt. Zion Memorial Orchestra'
tso                     = g.band 'Trans-Siberian Orchestra'
weezer                  = g.band 'Weezer'
wu_tang_clan            = g.band 'Wu-Tang Clan'
zwan                    = g.band 'Zwan'

# TODO: Factor some of this out.
akron_family.edge angels_of_light, 'label="guest + split" style=dashed'
gybe.edge low, 'label=live style=dotted'
molasses.edge swans, 'label="lyrical ref." style=dotted'
mwy.edge fugazi, 'label="lyrical ref." style=dotted'
mwy.edge nmh, 'label="lyrical ref." style=dotted'
mwy.edge norma_jean, 'label=split style=dashed dir=none'

albini_s        = g.person 'Steve Albini'
alexander_t     = g.person 'Tim Alexander'
amar_t          = g.person 'Thierry Amar'
anselmo_p       = g.person 'Phil Anselmo'
bert_b          = g.person 'Bob Bert'
boo_g           = g.person 'Gangsta Boo'
brashear_t      = g.person 'Todd Brashear'
braun_d         = g.person 'Dan Braun'
brokaw_c        = g.person 'Chris Brokaw'
brown_b         = g.person 'Bundy K. Brown'
bryant_d        = g.person 'David Bryant'
cameron_m       = g.person 'Matt Cameron'
cawdron_b       = g.person 'Bruce Cawdron'
chamberlin_j    = g.person 'Jimmy Chamberlin'
chernoff_s      = g.person 'Scott Chernoff'
c_m             = g.person 'Mark C.'
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
erskine_fl      = g.person 'Flüffy Erskine'
erskine_fr      = g.person 'Fred Erskine'
everman_j       = g.person 'Jason Everman'
finck_r         = g.person 'Robin Finck'
foon_b          = g.person 'Beckie Foon'
freese_j        = g.person 'Josh Freese'
gamble_l        = g.person 'Lisa Gamble'
gilmore_s       = g.person 'Scott Gilmore'
gira_m          = g.person 'Michael Gira'
girt_a          = g.person 'Aidan Girt'
goldsmith_w     = g.person 'William Goldsmith'
grimes_r        = g.person 'Rachel Grimes'
grohl_d         = g.person 'Dave Grohl'
grubbs_d        = g.person 'David Grubbs'
harris_t        = g.person 'Thor Harris'
hawkins_t       = g.person 'Taylor Hawkins'
heistek_g       = g.person 'Genevieve Heistek'
herndon_j       = g.person 'Johnny Herndon'
hetfield_j      = g.person 'James Hetfield'
iha_j           = g.person 'James Iha'
iommi_t         = g.person 'Tony Iommi'
irons_j         = g.person 'Jack Irons'
jarboe          = g.person 'Jarboe'
jehanian_g      = g.person 'Greg Jehanian'
johnson_n       = g.person 'Norsola Johnson'
jones_a         = g.person 'Adam Jones'
kane_j          = g.person 'Jonathan Kane'
keenan_m        = g.person 'Maynard James Keenan'
krieger_g       = g.person 'Gordon Krieger'
lawrence_k      = g.person 'Kate Lawrence'
leeuwen_t       = g.person 'Troy Van Leeuwen'
lenchantin_p    = g.person 'Paz Lenchantin'
lohner_d        = g.person 'Danny Lohner'
lo_j            = g.person 'James Lo'
mangini_m       = g.person 'Mike Mangini'
mangum_j        = g.person 'Jeff Mangum'
martin_j        = g.person 'Jim Martin'
may_b           = g.person 'Brian May'
mccombs_d       = g.person 'Doug McCombs'
mcentire_j      = g.person 'John McEntire'
mcmahan_b       = g.person 'Brian McMahan'
mcmahan_m       = g.person 'Michael McMahan'
mcneilly_m      = g.person 'Mac McNeilly'
meadows_s       = g.person 'Sean Meadows'
mendel_n        = g.person 'Nate Mendel'
menuck_e        = g.person 'Efrim Menuck'
morello_t       = g.person 'Tom Morello'
moss_j          = g.person 'Jessica Moss'
moss_n          = g.person 'Nadia Moss'
moya_m          = g.person 'Mike Moya'
mueller_j       = g.person 'Jeff Mueller'
mustaine_d      = g.person 'Dave Mustaine'
noble_j         = g.person 'Jason Noble'
novoselic_k     = g.person 'Krist Novoselic'
oldham_w        = g.person 'Will Oldham'
oneil_t         = g.person "Tara Jane O'Neil"
orourke_j       = g.person "Jim O'Rourke"
osbourne_o      = g.person 'Ozzy Osbourne'
pajo_d          = g.person 'David Pajo'
parker_j        = g.person 'Jeff Parker'
parker_m        = g.person 'Mimi Parker'
patton_m        = g.person 'Mike Patton'
payant_d        = g.person 'David Payant'
pitrelli_a      = g.person 'Al Pitrelli'
portnoy_m       = g.person 'Mike Portnoy'
pratt_t         = g.person 'Thea Pratt'
reznor_t        = g.person 'Trent Reznor'
roberts_m       = g.person 'Matana Roberts'
rocha_z         = g.person 'Zack de la Rocha'
rollins_h       = g.person 'Henry Rollins'
ryan_j          = g.person 'Jake Ryan'
scharin_d       = g.person 'Doug Scharin'
scogin_j        = g.person 'Josh Scogin'
shalabi_s       = g.person 'Sam Shalabi'
sherinian_d     = g.person 'Derek Sherinian'
sims_d          = g.person 'David William Sims'
smith_d         = g.person 'Dan Smith'
sparhawk_a      = g.person 'Alan Sparhawk'
sweeney_m       = g.person 'Matt Sweeney'
tankian_s       = g.person 'Serj Tankian'
tellier_craig_r = g.person 'Roger Tellier-Craig'
truchy_j        = g.person 'Jean-Sebastien Truchy'
trudeau_s       = g.person 'Sophie Trudeau'
vrenna_c        = g.person 'Chris Vrenna'
waits_t         = g.person 'Tom Waits'
walford_b       = g.person 'Britt Walford'
ward_b          = g.person 'Bill Ward'
washam_r        = g.person 'Rey Washam'
waters_j        = g.person 'Jeff Waters'
weiss_a         = g.person 'Aaron Weiss'
weston_b        = g.person 'Bob Weston'
white_j         = g.person 'Jeordie White'
wilk_b          = g.person 'Brad Wilk'
williams_h      = g.person 'Hayley Williams'
yow_d           = g.person 'David Yow'
zedek_t         = g.person 'Thalia Zedek'

bastro.member brown_b
bastro.member grubbs_d
bastro.member mcentire_j
big_black.member albini_s
bonnie_prince_billy.guest sweeney_m
chavez.member lo_j
circus_mort.member braun_d
circus_mort.member gira_m
circus_mort.member kane_j
codeine.member brokaw_c
come.guest brown_b
come.guest coultas_k
come.guest mcentire_j
come.guest mcneilly_m
come.guest oneil_t
come.member brokaw_c
come.member zedek_t
gastr_del_sol.member brown_b
gastr_del_sol.member mcentire_j
him.member brown_b
him.member erskine_fr
him.member parker_j
him.member scharin_d
hoover.member erskine_fr
intl_shades.member bert_b
intl_shades.member c_m
june_of_44.member erskine_fr
live_skull.member braun_d
live_skull.member c_m
live_skull.member lo_j
live_skull.member zedek_t
low.guest weston_b
mission_of_burma.member weston_b
pullman.member brokaw_c
pullman.member brown_b
pullman.member mccombs_d
rachels.guest weston_b
rapeman.member albini_s
rapeman.member sims_d
rapeman.member washam_r
rex.member scharin_d
scratch_acid.member sims_d
scratch_acid.member washam_r
scratch_acid.member yow_d
shellac.member albini_s
shellac.member weston_b
sonic_youth.member bert_b
swans.member braun_d
swans.member kane_j
the_jesus_lizard.member mcneilly_m
the_jesus_lizard.member sims_d
the_jesus_lizard.member yow_d
tortoise.member brown_b
tortoise.member mcentire_j
tortoise.member parker_j

# TODO: Factor some of this out.
morello_t.edge tool, 'label=live style=dotted'
tankian_s.edge tool, 'label=live style=dotted'
tankian_s.edge fear_factory, 'label=live style=dotted'
tankian_s.edge metallica, 'label=live style=dotted'
tankian_s.edge foo_fighters, 'label=live style=dotted'
g.edge cook_t, slint, 'label=touring style=dashed'
g.edge mcmahan_m, slint, 'label=touring style=dashed'
g.edge freese_j, paramore, 'label=touring style=dashed'
g.edge freese_j, weezer, 'label=touring style=dashed'
g.edge freese_j, nine_inch_nails, 'label=touring style=dashed'
g.edge lohner_d, nine_inch_nails, 'label=touring style=dashed'
g.edge white_j, nine_inch_nails, 'label=touring style=dashed'
g.edge vrenna_c, nine_inch_nails, 'label=touring style=dashed'
g.edge portnoy_m, a7x, 'label=touring style=dashed'
g.edge freese_j, the_offspring, 'label=session style=dashed'
g.edge wilk_b, black_sabbath, 'label=session style=dashed'

_1_speed_bike.member girt_a
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
a_perfect_circle.guest alexander_t
a_perfect_circle.guest jarboe
a_perfect_circle.guest reznor_t
a_perfect_circle.member freese_j
a_perfect_circle.member iha_j
a_perfect_circle.member keenan_m
a_perfect_circle.member leeuwen_t
a_perfect_circle.member lenchantin_p
a_perfect_circle.member lohner_d
a_perfect_circle.member white_j
arcade_fire.guest moss_j
arcade_fire.guest trudeau_s
as_cities_burn.guest scogin_j
audioslave.member commerford_t
audioslave.member cornell_c
audioslave.member morello_t
audioslave.member wilk_b
black_flag.member rollins_h
black_ox_orkestar.member amar_t
black_ox_orkestar.member gilmore_s
black_ox_orkestar.member moss_j
black_sabbath.member iommi_t
black_sabbath.member osbourne_o
black_sabbath.member ward_b
bonnie_prince_billy.member brashear_t
bonnie_prince_billy.member mcmahan_b
bonnie_prince_billy.member oldham_w
bonnie_prince_billy.member walford_b
broken_social_scene.guest moss_j
chavez.member sweeney_m
clipping.guest boo_g
codeine.guest grubbs_d
codeine.member scharin_d
coheed_and_cambria.member hawkins_t
deftones.guest keenan_m
deftones.guest tankian_s
devo.member freese_j
dream_theater.member mangini_m
dream_theater.member portnoy_m
dream_theater.member sherinian_d
efrim_menuck.guest amar_t
efrim_menuck.guest moss_j
efrim_menuck.guest moss_n
efrim_menuck.guest payant_d
efrim_menuck.member menuck_e
electric_sheep.member jones_a
electric_sheep.member morello_t
faith_no_more.member martin_j
faith_no_more.member patton_m
foo_fighters.guest novoselic_k
foo_fighters.member goldsmith_w
foo_fighters.member grohl_d
foo_fighters.member hawkins_t
foo_fighters.member mendel_n
gastr_del_sol.member grubbs_d
gastr_del_sol.member orourke_j
geology.member jehanian_g
guns_n_roses.member finck_r
guns_n_roses.member freese_j
gybe.guest roberts_m
gybe.member amar_t
gybe.member bryant_d
gybe.member cawdron_b
gybe.member girt_a
gybe.member johnson_n
gybe.member menuck_e
gybe.member moya_m
gybe.member pratt_t
gybe.member tellier_craig_r
gybe.member trudeau_s
hrsta.member moya_m
hrsta.member trudeau_s
in_the_fishtank_7.member dirty_three
in_the_fishtank_7.member low
isis.guest jones_a
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
marilyn_manson.guest finck_r
marilyn_manson.guest lohner_d
marilyn_manson.guest reznor_t
marilyn_manson.member vrenna_c
marilyn_manson.member white_j
matana_roberts.member roberts_m
megadeth.member degrasso_j
megadeth.member mustaine_d
megadeth.member pitrelli_a
metallica.guest martin_j
metallica.member hetfield_j
metallica.member mustaine_d
molasses.guest cawdron_b
molasses.guest gamble_l
molasses.guest krieger_g
molasses.guest menuck_e
molasses.guest shalabi_s
molasses.guest truchy_j
molasses.member amar_t
molasses.member chernoff_s
molasses.member erskine_fl
molasses.member johnson_n
molasses.member lawrence_k
molasses.member moya_m
mwy.guest enigk_j
mwy.guest williams_h
mwy.member jehanian_g
mwy.member weiss_a
nine_inch_nails.guest grohl_d
nine_inch_nails.member finck_r
nine_inch_nails.member reznor_t
nirvana.member cobain_k
nirvana.member everman_j
nirvana.member grohl_d
nirvana.member novoselic_k
nmh.member mangum_j
norma_jean.guest weiss_a
norma_jean.member scogin_j
pantera.member anselmo_p
paramore.member williams_h
pearl_jam.member cameron_m
pearl_jam.member irons_j
primus.guest hetfield_j
primus.guest martin_j
primus.guest morello_t
primus.guest waits_t
primus.member alexander_t
puscifer.guest morello_t
puscifer.member alexander_t
puscifer.member keenan_m
puscifer.member lohner_d
queen.member may_b
queens_club.member eaton_d
queens_club.member ryan_j
queens_of_the_stone_age.guest freese_j
queens_of_the_stone_age.guest lenchantin_p
queens_of_the_stone_age.guest reznor_t
queens_of_the_stone_age.member grohl_d
queens_of_the_stone_age.member leeuwen_t
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
rodan.member oneil_t
run_dmc.guest morello_t
run_the_jewels.guest boo_g
run_the_jewels.guest rocha_z
run_the_jewels.guest sweeney_m
savatage.guest waters_j
savatage.member pitrelli_a
serj_tankian.guest morello_t
serj_tankian.member tankian_s
sftf.member bryant_d
sftf.member cawdron_b
sftf.member erskine_fl
sftf.member foon_b
sftf.member girt_a
sftf.member heistek_g
sftf.member krieger_g
sftf.member moya_m
sftf.member pratt_t
sftf.member tellier_craig_r
sftf.member truchy_j
sftf.member trudeau_s
shipping_news.member cook_t
shipping_news.member crabtree_k
shipping_news.member mueller_j
shipping_news.member noble_j
slint.member brashear_t
slint.member mcmahan_b
slint.member pajo_d
slint.member walford_b
snoop_dogg.guest morello_t
soad.member tankian_s
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
tdep.member patton_m
tenacious_d.guest grohl_d
the_brave_and_the_bold.member oldham_w
the_brave_and_the_bold.member tortoise
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
the_nightwatchman.guest tankian_s
the_nightwatchman.member morello_t
the_smashing_pumpkins.member chamberlin_j
the_smashing_pumpkins.member corgan_b
the_smashing_pumpkins.member iha_j
the_sonora_pine.guest grimes_r
the_sonora_pine.member coultas_k
the_sonora_pine.member meadows_s
the_sonora_pine.member oneil_t
tony_iommi.guest anselmo_p
tony_iommi.guest cameron_m
tony_iommi.guest corgan_b
tony_iommi.guest grohl_d
tony_iommi.guest may_b
tony_iommi.guest osbourne_o
tony_iommi.guest rollins_h
tony_iommi.guest tankian_s
tony_iommi.guest ward_b
tony_iommi.member iommi_t
tool.member jones_a
tool.member keenan_m
tortoise.member herndon_j
tortoise.member mccombs_d
tortoise.member pajo_d
tsmz.guest cawdron_b
tsmz.guest gamble_l
tsmz.guest girt_a
tsmz.guest heistek_g
tsmz.guest krieger_g
tsmz.guest lawrence_k
tsmz.guest moss_n
tsmz.guest pratt_t
tsmz.guest roberts_m
tsmz.guest shalabi_s
tsmz.member amar_t
tsmz.member foon_b
tsmz.member gilmore_s
tsmz.member menuck_e
tsmz.member moss_j
tsmz.member payant_d
tsmz.member trudeau_s
tso.member pitrelli_a
wu_tang_clan.guest morello_t
zwan.member chamberlin_j
zwan.member corgan_b
zwan.member lenchantin_p
zwan.member pajo_d
zwan.member sweeney_m

puts g.generate_dot
