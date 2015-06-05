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
      overlap: 'scale',
      splines: 'true',
      repulsiveforce: '1.5',
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

_68                 = g.band "'68"
akron_family        = g.band 'Akron/Family'
alice_cooper        = g.band 'Alice Cooper'
angels_of_light     = g.band 'Angels of Light'
annihilator         = g.band 'Annihilator'
arcade_fire         = g.band 'Arcade Fire'
as_cities_burn      = g.band 'As Cities Burn'
black_ox_orkestar   = g.band 'Black Ox Orkestar'
broken_social_scene = g.band 'Broken Social Scene'
dream_theater       = g.band 'Dream Theater'
efrim_menuck        = g.band 'Efrim Manuel Menuck'
geology             = g.band 'Geology'
gybe                = g.band 'Godspeed You! Black Emperor'
hrsta               = g.band 'HṚṢṬA'
listener            = g.band 'Listener'
low                 = g.band 'Low'
megadeth            = g.band 'Megadeth'
metallica           = g.band 'Metallica'
molasses            = g.band 'Molasses'
mwy                 = g.band 'mewithoutYou'
norma_jean          = g.band 'Norma Jean'
paramore            = g.band 'Paramore'
queens_club         = g.band 'Queens Club'
savatage            = g.band 'Savatage'
sftf                = g.band 'Set Fire To Flames'
swans               = g.band 'Swans'
the_chariot         = g.band 'The Chariot'
tsmz                = g.band 'Thee Silver Mt. Zion Memorial Orchestra'
tso                 = g.band 'Trans-Siberian Orchestra'

akron_family.edge angels_of_light, 'label="guest + split" style=dashed'
low.edge gybe, 'label="live performance" style=dotted dir=none'
molasses.edge swans, 'label="lyrical ref." style=dotted'
mwy.edge norma_jean, 'label=split style=dashed dir=none'

amar_t          = g.person 'Thierry Amar'
bryant_d        = g.person 'David Bryant'
cawdron_b       = g.person 'Bruce Cawdron'
degrasso_j      = g.person 'Jimmy DeGrasso'
eaton_d         = g.person 'Dan Eaton'
foon_b          = g.person 'Beckie Foon'
gilmore_s       = g.person 'Scott Gilmore'
gira_m          = g.person 'Michael Gira'
girt_a          = g.person 'Aidan Girt'
jarboe          = g.person 'Jarboe'
jehanian_g      = g.person 'Greg Jehanian'
mangini_m       = g.person 'Mike Mangini'
menuck_e        = g.person 'Efrim Menuck'
moss_j          = g.person 'Jessica Moss'
moya_m          = g.person 'Mike Moya'
mustaine_d      = g.person 'Dave Mustaine'
parker_m        = g.person 'Mimi Parker'
payant_d        = g.person 'David Payant'
pitrelli_a      = g.person 'Al Pitrelli'
pratt_t         = g.person 'Thea Pratt'
ryan_j          = g.person 'Jake Ryan'
scogin_j        = g.person 'Josh Scogin'
shalabi_s       = g.person 'Sam Shalabi'
sherinian_d     = g.person 'Derek Sherinian'
smith_d         = g.person 'Dan Smith'
sparhawk_a      = g.person 'Alan Sparhawk'
tellier_craig_r = g.person 'Roger Tellier-Craig'
trudeau_s       = g.person 'Sophie Trudeau'
waters_j        = g.person 'Jeff Waters'
weiss_a         = g.person 'Aaron Weiss'
williams_h      = g.person 'Hayley Williams'
harris_t = g.person 'Thor Harris'

_68.member scogin_j
alice_cooper.member degrasso_j
alice_cooper.member pitrelli_a
alice_cooper.member sherinian_d
angels_of_light.guest harris_t
angels_of_light.member gira_m
annihilator.member mangini_m
annihilator.member waters_j
arcade_fire.guest moss_j
arcade_fire.guest trudeau_s
as_cities_burn.guest scogin_j
black_ox_orkestar.member amar_t
black_ox_orkestar.member gilmore_s
black_ox_orkestar.member moss_j
broken_social_scene.guest moss_j
dream_theater.member mangini_m
dream_theater.member sherinian_d
efrim_menuck.guest moss_j
efrim_menuck.guest payant_d
efrim_menuck.member menuck_e
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
listener.member smith_d
low.member parker_m
low.member sparhawk_a
megadeth.member degrasso_j
megadeth.member mustaine_d
megadeth.member pitrelli_a
metallica.member mustaine_d
molasses.guest shalabi_s
molasses.member amar_t
molasses.member moya_m
mwy.guest williams_h
mwy.member jehanian_g
mwy.member weiss_a
norma_jean.guest weiss_a
norma_jean.member scogin_j
paramore.member williams_h
queens_club.member eaton_d
queens_club.member ryan_j
savatage.guest waters_j
savatage.member pitrelli_a
sftf.member bryant_d
sftf.member cawdron_b
sftf.member foon_b
sftf.member girt_a
sftf.member moya_m
sftf.member pratt_t
sftf.member tellier_craig_r
swans.guest parker_m
swans.guest sparhawk_a
swans.member gira_m
swans.member harris_t
swans.member jarboe
the_chariot.guest smith_d
the_chariot.guest weiss_a
the_chariot.guest williams_h
the_chariot.member eaton_d
the_chariot.member ryan_j
the_chariot.member scogin_j
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

puts g.generate_dot
