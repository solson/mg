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

_1_speed_bike                             = g.band '1-Speed Bike'
_68                                       = g.band "'68"
a7x                                       = g.band 'Avenged Sevenfold'
akron_family                              = g.band 'Akron/Family'
alanis_morissette                         = g.band 'Alanis Morissette'
alexisonfire                              = g.band 'Alexisonfire'
alice_cooper                              = g.band 'Alice Cooper'
alice_in_chains                           = g.band 'Alice in Chains'
angels_of_light                           = g.band 'Angels of Light'
annihilator                               = g.band 'Annihilator'
anthrax                                   = g.band 'Anthrax'
a_perfect_circle                          = g.band 'A Perfect Circle'
arcade_fire                               = g.band 'Arcade Fire'
as_cities_burn                            = g.band 'As Cities Burn'
audioslave                                = g.band 'Audioslave'
bastro                                    = g.band 'Bastro'
between_the_buried_and_me                 = g.band 'Between The Buried And Me'
big_black                                 = g.band 'Big Black'
black_flag                                = g.band 'Black Flag'
black_ox_orkestar                         = g.band 'Black Ox Orkestar'
black_sabbath                             = g.band 'Black Sabbath'
bonnie_prince_billy                       = g.band "Bonnie 'Prince' Billy"
brian_eno                                 = g.band 'Brian Eno'
broken_social_scene                       = g.band 'Broken Social Scene'
chavez                                    = g.band 'Chavez'
circus_mort                               = g.band 'Circus Mort'
city_and_colour                           = g.band 'City and Colour'
clipping                                  = g.band 'clipping.'
coalesce                                  = g.band 'Coalesce'
codeine                                   = g.band 'Codeine'
coheed_and_cambria                        = g.band 'Coheed and Cambria'
come                                      = g.band 'Come'
david_bowie                               = g.band 'David Bowie'
death_grips                               = g.band 'Death Grips'
deftones                                  = g.band 'Deftones'
devo                                      = g.band 'Devo'
dirty_three                               = g.band 'Dirty Three'
dream_theater                             = g.band 'Dream Theater'
efrim_menuck                              = g.band 'Efrim Manuel Menuck'
electric_sheep                            = g.band 'Electric Sheep'
every_time_i_die                          = g.band 'Every Time I Die'
faith_no_more                             = g.band 'Faith No More'
fall_out_boy                              = g.band 'Fall Out Boy'
fear_factory                              = g.band 'Fear Factory'
foo_fighters                              = g.band 'Foo Fighters'
fripp_eno                                 = g.band 'Fripp & Eno'
fugazi                                    = g.band 'Fugazi'
gastr_del_sol                             = g.band 'Gastr del Sol'
geology                                   = g.band 'Geology'
guns_n_roses                              = g.band "Guns N' Roses"
gybe                                      = g.band 'Godspeed You! Black Emperor'
hella                                     = g.band 'Hella'
him                                       = g.band 'HiM'
hoover                                    = g.band 'Hoover'
how_to_destroy_angels                     = g.band 'How To Destroy Angels'
hrsta                                     = g.band 'HṚṢṬA'
in_the_fishtank_7                         = g.band 'Low + Dirty Three'
intl_shades                               = g.band "Int'l Shades"
isis                                      = g.band 'Isis'
jarboe_solo                               = g.band 'Jarboe'
jenny_hval                                = g.band 'Jenny Hval'
june_of_44                                = g.band 'June of 44'
king_crimson                              = g.band 'King Crimson'
linkin_park                               = g.band 'Linkin Park'
listener                                  = g.band 'Listener'
live_skull                                = g.band 'Live Skull'
low                                       = g.band 'Low'
marilyn_manson                            = g.band 'Marilyn Manson'
marnie_stern                              = g.band 'Marnie Stern'
mastodon                                  = g.band 'Mastodon'
matana_roberts                            = g.band 'Matana Roberts'
megadeth                                  = g.band 'Megadeth'
metallica                                 = g.band 'Metallica'
mission_of_burma                          = g.band 'Mission of Burma'
molasses                                  = g.band 'Molasses'
mr_bungle                                 = g.band 'Mr. Bungle'
mwy                                       = g.band 'mewithoutYou'
my_chemical_romance                       = g.band 'My Chemical Romance'
nine_inch_nails                           = g.band 'Nine Inch Nails'
nirvana                                   = g.band 'Nirvana'
nmh                                       = g.band 'Neutral Milk Hotel'
no_joy                                    = g.band 'No Joy'
norma_jean                                = g.band 'Norma Jean'
opeth                                     = g.band 'Opeth'
pantera                                   = g.band 'Pantera'
paramore                                  = g.band 'Paramore'
pearl_jam                                 = g.band 'Pearl Jam'
porcupine_tree                            = g.band 'Porcupine Tree'
primus                                    = g.band 'Primus'
protest_the_hero                          = g.band 'Protest the Hero'
pullman                                   = g.band 'Pullman'
puscifer                                  = g.band 'Puscifer'
queen                                     = g.band 'Queen'
queens_club                               = g.band 'Queens Club'
queens_of_the_stone_age                   = g.band 'Queens of the Stone Age'
rachels                                   = g.band "Rachel's"
rapeman                                   = g.band 'Rapeman'
ratm                                      = g.band 'Rage Against The Machine'
rex                                       = g.band 'Rex'
rhcp                                      = g.band 'Red Hot Chili Peppers'
rodan                                     = g.band 'Rodan'
run_dmc                                   = g.band 'Run-DMC'
run_the_jewels                            = g.band 'Run the Jewels'
savatage                                  = g.band 'Savatage'
scratch_acid                              = g.band 'Scratch Acid'
serj_tankian                              = g.band 'Serj Tankian'
sftf                                      = g.band 'Set Fire To Flames'
shellac                                   = g.band 'Shellac'
shipping_news                             = g.band 'Shipping News'
slint                                     = g.band 'Slint'
snoop_dogg                                = g.band 'Snoop Dogg'
soad                                      = g.band 'System of a Down'
sonic_youth                               = g.band 'Sonic Youth'
soundgarden                               = g.band 'Soundgarden'
squirrel_bait                             = g.band 'Squirrel Bait'
steven_wilson                             = g.band 'Steven Wilson'
storm_corrosion                           = g.band 'Storm Corrosion'
st_vincent_david_byrne                    = g.band 'St. Vincent + David Byrne'
st_vincent                                = g.band 'St. Vincent'
sunny_day_real_estate                     = g.band 'Sunny Day Real Estate'
superwolf                                 = g.band "Bonnie 'Prince' Billy + Matt Sweeney"
swans                                     = g.band 'Swans'
talking_heads                             = g.band 'Talking Heads'
tenacious_d                               = g.band 'Tenacious D'
the_brave_and_the_bold                    = g.band "Bonnie 'Prince' Billy + Tortoise"
the_chariot                               = g.band 'The Chariot'
the_damned_things                         = g.band 'The Damned Things'
the_dillinger_escape_plan                 = g.band 'The Dillinger Escape Plan'
the_fall_of_troy                          = g.band 'The Fall of Troy'
the_for_carnation                         = g.band 'The For Carnation'
the_jesus_lizard                          = g.band 'The Jesus Lizard'
the_nightwatchman                         = g.band 'The Nightwatchman'
the_offspring                             = g.band 'The Offspring'
the_smashing_pumpkins                     = g.band 'The Smashing Pumpkins'
the_sonora_pine                           = g.band 'The Sonora Pine'
tony_iommi                                = g.band 'Tony Iommi'
tool                                      = g.band 'Tool'
tortoise                                  = g.band 'Tortoise'
trent_reznor_atticus_ross                 = g.band 'Trent Reznor + Atticus Ross'
tsmz                                      = g.band 'Thee Silver Mt. Zion Memorial Orchestra'
tso                                       = g.band 'Trans-Siberian Orchestra'
underoath                                 = g.band 'Underoath'
vic_chestnutt                             = g.band 'Vic Chestnutt'
weezer                                    = g.band 'Weezer'
wu_tang_clan                              = g.band 'Wu-Tang Clan'
yeah_yeah_yeahs                           = g.band 'Yeah Yeah Yeahs'
zach_hill_and_benjamin_weinman_experiment = g.band 'Zach Hill and Benjamin Weinman Experiment'
zwan                                      = g.band 'Zwan'

# TODO: Factor some of this out.
akron_family.edge angels_of_light, 'label="guest + split" style=dashed'
gybe.edge low, 'label=live style=dotted'
mwy.edge norma_jean, 'label=split style=dashed dir=none'
marnie_stern.edge no_joy, 'label=split style=dashed dir=none'

albini_s        = g.person 'Steve Albini'
alexander_t     = g.person 'Tim Alexander'
amar_t          = g.person 'Thierry Amar'
anselmo_p       = g.person 'Phil Anselmo'
bert_b          = g.person 'Bob Bert'
boo_g           = g.person 'Gangsta Boo'
bowie_d         = g.person 'David Bowie'
brashear_t      = g.person 'Todd Brashear'
braun_d         = g.person 'Dan Braun'
brokaw_c        = g.person 'Chris Brokaw'
brown_b         = g.person 'Bundy K. Brown'
bryant_d        = g.person 'David Bryant'
buckley_k       = g.person 'Keith Buckley'
burnett_s       = g.person 'Stefan Burnett'
byrne_d         = g.person 'David Byrne'
caggiano_r      = g.person 'Rob Caggiano'
cameron_m       = g.person 'Matt Cameron'
cawdron_b       = g.person 'Bruce Cawdron'
chamberlin_j    = g.person 'Jimmy Chamberlin'
chernoff_s      = g.person 'Scott Chernoff'
chestnutt_v     = g.person 'Vic Chestnutt'
clark_a         = g.person 'Annie Clark'
c_m             = g.person 'Mark C.'
cobain_k        = g.person 'Kurt Cobain'
commerford_t    = g.person 'Tim Commerford'
cook_t          = g.person 'Todd Cook'
corgan_b        = g.person 'Billy Corgan'
cornell_c       = g.person 'Chris Cornell'
cortini_a       = g.person 'Alessandro Cortini'
coultas_k       = g.person 'Kevin Coultas'
crabtree_k      = g.person 'Kyle Crabtree'
davidson_d      = g.person 'Daniel Davidson'
degrasso_j      = g.person 'Jimmy DeGrasso'
eaton_d         = g.person 'Dan Eaton'
enigk_j         = g.person 'Jeremy Enigk'
eno_b           = g.person 'Brian Eno'
erskine_fl      = g.person 'Flüffy Erskine'
erskine_fr      = g.person 'Fred Erskine'
everman_j       = g.person 'Jason Everman'
falk_k          = g.person 'Kevin Falk'
finck_r         = g.person 'Robin Finck'
foon_b          = g.person 'Beckie Foon'
freese_j        = g.person 'Josh Freese'
fripp_r         = g.person 'Robert Fripp'
gamble_l        = g.person 'Lisa Gamble'
garson_m        = g.person 'Mike Garson'
gilmore_s       = g.person 'Scott Gilmore'
gira_m          = g.person 'Michael Gira'
girt_a          = g.person 'Aidan Girt'
goldsmith_w     = g.person 'William Goldsmith'
green_d         = g.person 'Dallas Green'
grimes_r        = g.person 'Rachel Grimes'
grohl_d         = g.person 'Dave Grohl'
grubbs_d        = g.person 'David Grubbs'
harris_t        = g.person 'Thor Harris'
hawkins_t       = g.person 'Taylor Hawkins'
heistek_g       = g.person 'Genevieve Heistek'
herndon_j       = g.person 'Johnny Herndon'
hetfield_j      = g.person 'James Hetfield'
hill_z          = g.person 'Zach Hill'
hinds_b         = g.person 'Brent Hinds'
hurley_a        = g.person 'Andy Hurley'
hval_j          = g.person 'Jenny Hval'
ian_s           = g.person 'Scott Ian'
iha_j           = g.person 'James Iha'
ingram_s        = g.person 'Sean Ingram'
iommi_t         = g.person 'Tony Iommi'
irons_j         = g.person 'Jack Irons'
jarboe          = g.person 'Jarboe'
jehanian_g      = g.person 'Greg Jehanian'
johnson_n       = g.person 'Norsola Johnson'
jones_a         = g.person 'Adam Jones'
kane_j          = g.person 'Jonathan Kane'
keenan_m        = g.person 'Maynard James Keenan'
kerfeldt_m      = g.person 'Mikael Åkerfeldt'
krieger_g       = g.person 'Gordon Krieger'
lawrence_k      = g.person 'Kate Lawrence'
leeuwen_t       = g.person 'Troy Van Leeuwen'
lenchantin_p    = g.person 'Paz Lenchantin'
lohner_d        = g.person 'Danny Lohner'
lo_j            = g.person 'James Lo'
maandig_m       = g.person 'Mariqueen Maandig'
mangini_m       = g.person 'Mike Mangini'
mangum_j        = g.person 'Jeff Mangum'
mansell_c       = g.person 'Clint Mansell'
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
newton_j        = g.person 'Josh Newton'
noble_j         = g.person 'Jason Noble'
novoselic_k     = g.person 'Krist Novoselic'
oldham_w        = g.person 'Will Oldham'
oneil_t         = g.person "Tara Jane O'Neil"
orourke_j       = g.person "Jim O'Rourke"
orzolek_k       = g.person 'Karen Orzolek'
osbourne_o      = g.person 'Ozzy Osbourne'
pajo_d          = g.person 'David Pajo'
parker_j        = g.person 'Jeff Parker'
parker_m        = g.person 'Mimi Parker'
patton_m        = g.person 'Mike Patton'
payant_d        = g.person 'David Payant'
pennie_c        = g.person 'Chris Pennie'
picciotto_g     = g.person 'Guy Picciotto'
pitrelli_a      = g.person 'Al Pitrelli'
pop_i           = g.person 'Iggy Pop'
portnoy_m       = g.person 'Mike Portnoy'
pratt_t         = g.person 'Thea Pratt'
puciato_g       = g.person 'Greg Puciato'
reznor_t        = g.person 'Trent Reznor'
roberts_m       = g.person 'Matana Roberts'
rocha_z         = g.person 'Zack de la Rocha'
rollins_h       = g.person 'Henry Rollins'
ross_a          = g.person 'Atticus Ross'
ryan_j          = g.person 'Jake Ryan'
scharin_d       = g.person 'Doug Scharin'
scogin_j        = g.person 'Josh Scogin'
shalabi_s       = g.person 'Sam Shalabi'
sharone_g       = g.person 'Gil Sharone'
sherinian_d     = g.person 'Derek Sherinian'
sims_d          = g.person 'David William Sims'
smith_d         = g.person 'Dan Smith'
sparhawk_a      = g.person 'Alan Sparhawk'
stern_m         = g.person 'Marnie Stern'
sweeney_m       = g.person 'Matt Sweeney'
tankian_s       = g.person 'Serj Tankian'
tellier_craig_r = g.person 'Roger Tellier-Craig'
trohman_j       = g.person 'Joe Trohman'
truchy_j        = g.person 'Jean-Sebastien Truchy'
trudeau_s       = g.person 'Sophie Trudeau'
vrenna_c        = g.person 'Chris Vrenna'
waits_t         = g.person 'Tom Waits'
walford_b       = g.person 'Britt Walford'
walker_r        = g.person 'Rody Walker'
ward_b          = g.person 'Bill Ward'
washam_r        = g.person 'Rey Washam'
waters_j        = g.person 'Jeff Waters'
way_g           = g.person 'Gerard Way'
weinman_b       = g.person 'Ben Weinman'
weiss_a         = g.person 'Aaron Weiss'
wentz_p         = g.person 'Pete Wentz'
weston_b        = g.person 'Bob Weston'
white_j         = g.person 'Jeordie White'
wilk_b          = g.person 'Brad Wilk'
williams_h      = g.person 'Hayley Williams'
wilson_s        = g.person 'Steven Wilson'
yow_d           = g.person 'David Yow'
zedek_t         = g.person 'Thalia Zedek'

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
g.edge hawkins_t, coheed_and_cambria, 'label=session style=dashed'
g.edge cortini_a, how_to_destroy_angels, 'label=touring style=dashed'
g.edge pajo_d, yeah_yeah_yeahs, 'label=touring style=dashed'
g.edge newton_j, the_damned_things, 'label=touring style=dashed'
g.edge hawkins_t, alanis_morissette, 'label=touring style=dashed'

_1_speed_bike.member girt_a
_68.member scogin_j
alexisonfire.member green_d
alice_cooper.guest cornell_c
alice_cooper.member degrasso_j
alice_cooper.member pitrelli_a
alice_cooper.member sherinian_d
alice_in_chains.guest cornell_c
angels_of_light.guest harris_t
angels_of_light.member gira_m
annihilator.member mangini_m
annihilator.member waters_j
anthrax.member caggiano_r
anthrax.member ian_s
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
bastro.member brown_b
bastro.member grubbs_d
bastro.member mcentire_j
between_the_buried_and_me.member falk_k
big_black.member albini_s
black_flag.member rollins_h
black_ox_orkestar.member amar_t
black_ox_orkestar.member gilmore_s
black_ox_orkestar.member moss_j
black_sabbath.member iommi_t
black_sabbath.member osbourne_o
black_sabbath.member ward_b
bonnie_prince_billy.guest sweeney_m
bonnie_prince_billy.member brashear_t
bonnie_prince_billy.member mcmahan_b
bonnie_prince_billy.member oldham_w
bonnie_prince_billy.member walford_b
brian_eno.member eno_b
broken_social_scene.guest moss_j
chavez.member lo_j
chavez.member sweeney_m
circus_mort.member braun_d
circus_mort.member gira_m
circus_mort.member kane_j
city_and_colour.member green_d
clipping.guest boo_g
coalesce.member ingram_s
codeine.guest grubbs_d
codeine.member brokaw_c
codeine.member scharin_d
coheed_and_cambria.member hawkins_t
coheed_and_cambria.member pennie_c
come.guest brown_b
come.guest coultas_k
come.guest mcentire_j
come.guest mcneilly_m
come.guest oneil_t
come.member brokaw_c
come.member zedek_t
david_bowie.guest garson_m
david_bowie.guest pop_i
david_bowie.member bowie_d
david_bowie.member eno_b
david_bowie.member fripp_r
death_grips.member burnett_s
death_grips.member hill_z
deftones.guest keenan_m
deftones.guest tankian_s
devo.member freese_j
dream_theater.guest kerfeldt_m
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
every_time_i_die.guest green_d
every_time_i_die.guest ingram_s
every_time_i_die.guest puciato_g
every_time_i_die.guest way_g
every_time_i_die.guest wentz_p
every_time_i_die.member buckley_k
every_time_i_die.member davidson_d
every_time_i_die.member falk_k
every_time_i_die.member newton_j
faith_no_more.member martin_j
faith_no_more.member patton_m
faith_no_more.member patton_m
fall_out_boy.member hurley_a
fall_out_boy.member trohman_j
fall_out_boy.member wentz_p
foo_fighters.guest novoselic_k
foo_fighters.member goldsmith_w
foo_fighters.member grohl_d
foo_fighters.member hawkins_t
foo_fighters.member hawkins_t
foo_fighters.member mendel_n
fripp_eno.member eno_b
fripp_eno.member fripp_r
fugazi.member picciotto_g
gastr_del_sol.member brown_b
gastr_del_sol.member grubbs_d
gastr_del_sol.member mcentire_j
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
hella.member hill_z
him.member brown_b
him.member erskine_fr
him.member parker_j
him.member scharin_d
hoover.member erskine_fr
how_to_destroy_angels.member maandig_m
how_to_destroy_angels.member reznor_t
how_to_destroy_angels.member ross_a
hrsta.member moya_m
hrsta.member trudeau_s
in_the_fishtank_7.member dirty_three
in_the_fishtank_7.member low
intl_shades.member bert_b
intl_shades.member c_m
isis.guest jones_a
jarboe_solo.guest lenchantin_p
jarboe_solo.member jarboe
jenny_hval.guest harris_t
jenny_hval.member hval_j
june_of_44.member erskine_fr
june_of_44.member meadows_s
june_of_44.member mueller_j
june_of_44.member scharin_d
king_crimson.member fripp_r
linkin_park.guest cornell_c
listener.member smith_d
live_skull.member braun_d
live_skull.member c_m
live_skull.member lo_j
live_skull.member zedek_t
low.guest weston_b
low.member parker_m
low.member sparhawk_a
marilyn_manson.guest corgan_b
marilyn_manson.guest finck_r
marilyn_manson.guest lohner_d
marilyn_manson.guest reznor_t
marilyn_manson.member sharone_g
marilyn_manson.member vrenna_c
marilyn_manson.member white_j
marnie_stern.member hill_z
marnie_stern.member stern_m
mastodon.member hinds_b
matana_roberts.member roberts_m
megadeth.member degrasso_j
megadeth.member mustaine_d
megadeth.member pitrelli_a
metallica.guest martin_j
metallica.member hetfield_j
metallica.member mustaine_d
mission_of_burma.member weston_b
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
mr_bungle.member patton_m
mwy.guest enigk_j
mwy.guest williams_h
mwy.member jehanian_g
mwy.member weiss_a
my_chemical_romance.member way_g
nine_inch_nails.guest garson_m
nine_inch_nails.guest garson_m
nine_inch_nails.guest grohl_d
nine_inch_nails.guest mansell_c
nine_inch_nails.guest ross_a
nine_inch_nails.member cortini_a
nine_inch_nails.member finck_r
nine_inch_nails.member reznor_t
nirvana.member cobain_k
nirvana.member everman_j
nirvana.member grohl_d
nirvana.member novoselic_k
nmh.member mangum_j
norma_jean.guest weiss_a
norma_jean.member davidson_d
norma_jean.member scogin_j
opeth.member kerfeldt_m
pantera.member anselmo_p
paramore.member williams_h
pearl_jam.member cameron_m
pearl_jam.member irons_j
porcupine_tree.guest fripp_r
porcupine_tree.guest kerfeldt_m
porcupine_tree.member wilson_s
primus.guest hetfield_j
primus.guest martin_j
primus.guest morello_t
primus.guest waits_t
primus.member alexander_t
protest_the_hero.member walker_r
pullman.member brokaw_c
pullman.member brown_b
pullman.member mccombs_d
puscifer.guest cortini_a
puscifer.guest morello_t
puscifer.guest sharone_g
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
rachels.guest weston_b
rachels.member coultas_k
rachels.member crabtree_k
rachels.member grimes_r
rachels.member noble_j
rapeman.member albini_s
rapeman.member sims_d
rapeman.member washam_r
ratm.guest keenan_m
ratm.member commerford_t
ratm.member morello_t
ratm.member rocha_z
ratm.member wilk_b
rex.member scharin_d
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
scratch_acid.member sims_d
scratch_acid.member washam_r
scratch_acid.member yow_d
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
shellac.member albini_s
shellac.member weston_b
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
sonic_youth.member bert_b
sonic_youth.member orourke_j
soundgarden.member cameron_m
soundgarden.member cornell_c
soundgarden.member everman_j
squirrel_bait.member grubbs_d
squirrel_bait.member mcmahan_b
squirrel_bait.member walford_b
steven_wilson.member wilson_s
storm_corrosion.member kerfeldt_m
storm_corrosion.member wilson_s
st_vincent_david_byrne.member byrne_d
st_vincent_david_byrne.member clark_a
st_vincent.member clark_a
sunny_day_real_estate.member enigk_j
sunny_day_real_estate.member goldsmith_w
sunny_day_real_estate.member mendel_n
superwolf.member oldham_w
superwolf.member sweeney_m
swans.guest akron_family
swans.guest clark_a
swans.guest orzolek_k
swans.guest parker_m
swans.guest sparhawk_a
swans.member braun_d
swans.member gira_m
swans.member harris_t
swans.member jarboe
swans.member kane_j
talking_heads.guest eno_b
talking_heads.guest fripp_r
talking_heads.member byrne_d
tenacious_d.guest grohl_d
the_brave_and_the_bold.member oldham_w
the_brave_and_the_bold.member tortoise
the_chariot.guest smith_d
the_chariot.guest weiss_a
the_chariot.guest williams_h
the_chariot.member eaton_d
the_chariot.member ryan_j
the_chariot.member scogin_j
the_damned_things.member buckley_k
the_damned_things.member caggiano_r
the_damned_things.member hurley_a
the_damned_things.member ian_s
the_damned_things.member trohman_j
the_dillinger_escape_plan.guest garson_m
the_dillinger_escape_plan.guest hinds_b
the_dillinger_escape_plan.guest patton_m
the_dillinger_escape_plan.member pennie_c
the_dillinger_escape_plan.member puciato_g
the_dillinger_escape_plan.member sharone_g
the_dillinger_escape_plan.member weinman_b
the_fall_of_troy.guest walker_r
the_for_carnation.guest walford_b
the_for_carnation.member cook_t
the_for_carnation.member herndon_j
the_for_carnation.member mccombs_d
the_for_carnation.member mcmahan_b
the_for_carnation.member mcmahan_m
the_for_carnation.member pajo_d
the_jesus_lizard.member mcneilly_m
the_jesus_lizard.member sims_d
the_jesus_lizard.member yow_d
the_nightwatchman.guest tankian_s
the_nightwatchman.member morello_t
the_smashing_pumpkins.guest garson_m
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
tortoise.member brown_b
tortoise.member herndon_j
tortoise.member mccombs_d
tortoise.member mcentire_j
tortoise.member pajo_d
tortoise.member parker_j
trent_reznor_atticus_ross.guest how_to_destroy_angels
trent_reznor_atticus_ross.guest orzolek_k
trent_reznor_atticus_ross.member reznor_t
trent_reznor_atticus_ross.member ross_a
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
underoath.member davidson_d
vic_chestnutt.guest picciotto_g
vic_chestnutt.member chestnutt_v
wu_tang_clan.guest morello_t
yeah_yeah_yeahs.member orzolek_k
zach_hill_and_benjamin_weinman_experiment.member hill_z
zach_hill_and_benjamin_weinman_experiment.member weinman_b
zwan.member chamberlin_j
zwan.member corgan_b
zwan.member lenchantin_p
zwan.member pajo_d
zwan.member sweeney_m

puts g.generate_dot
