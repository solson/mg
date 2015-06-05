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
    person.edge(self, 'style=dotted label=guest')
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
      sep: '"+10,10"',
      overlap: 'false',
      splines: 'true',
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

_68            = g.band "'68"
alice_cooper   = g.band 'Alice Cooper'
annihilator    = g.band 'Annihilator'
as_cities_burn = g.band 'As Cities Burn'
dream_theater  = g.band 'Dream Theater'
geology        = g.band 'Geology'
listener       = g.band 'Listener'
megadeth       = g.band 'Megadeth'
metallica      = g.band 'Metallica'
mwy            = g.band 'mewithoutYou'
norma_jean     = g.band 'Norma Jean'
paramore       = g.band 'Paramore'
queens_club    = g.band 'Queens Club'
savatage       = g.band 'Savatage'
the_chariot    = g.band 'The Chariot'
tso            = g.band 'Trans-Siberian Orchestra'

a_pitrelli  = g.person 'Al Pitrelli'
a_weiss     = g.person 'Aaron Weiss'
d_eaton     = g.person 'Dan Eaton'
d_mustaine  = g.person 'Dave Mustaine'
d_sherinian = g.person 'Derek Sherinian'
d_smith     = g.person 'Dan Smith'
g_jehanian  = g.person 'Greg Jehanian'
h_williams  = g.person 'Hayley Williams'
j_degrasso  = g.person 'Jimmy DeGrasso'
j_ryan      = g.person 'Jake Ryan'
j_scogin    = g.person 'Josh Scogin'
j_waters    = g.person 'Jeff Waters'
m_mangini   = g.person 'Mike Mangini'

_68.member j_scogin
alice_cooper.member a_pitrelli
alice_cooper.member d_sherinian
alice_cooper.member j_degrasso
annihilator.member j_waters
annihilator.member m_mangini
as_cities_burn.guest j_scogin
dream_theater.member d_sherinian
dream_theater.member m_mangini
geology.member g_jehanian
listener.member d_smith
megadeth.member a_pitrelli
megadeth.member d_mustaine
megadeth.member j_degrasso
metallica.member d_mustaine
mwy.guest h_williams
mwy.member a_weiss
mwy.member g_jehanian
norma_jean.guest a_weiss
norma_jean.member j_scogin
paramore.member h_williams
queens_club.member d_eaton
queens_club.member j_ryan
savatage.guest j_waters
savatage.member a_pitrelli
the_chariot.guest a_weiss
the_chariot.guest d_smith
the_chariot.guest h_williams
the_chariot.member d_eaton
the_chariot.member j_ryan
the_chariot.member j_scogin
tso.member a_pitrelli

puts g.generate_dot
