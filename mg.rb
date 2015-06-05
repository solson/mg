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

degrasso_j  = g.person 'Jimmy DeGrasso'
eaton_d     = g.person 'Dan Eaton'
jehanian_g  = g.person 'Greg Jehanian'
mangini_m   = g.person 'Mike Mangini'
mustaine_d  = g.person 'Dave Mustaine'
pitrelli_a  = g.person 'Al Pitrelli'
ryan_j      = g.person 'Jake Ryan'
scogin_j    = g.person 'Josh Scogin'
sherinian_d = g.person 'Derek Sherinian'
smith_d     = g.person 'Dan Smith'
waters_j    = g.person 'Jeff Waters'
weiss_a     = g.person 'Aaron Weiss'
williams_h  = g.person 'Hayley Williams'

_68.member scogin_j
alice_cooper.member degrasso_j
alice_cooper.member pitrelli_a
alice_cooper.member sherinian_d
annihilator.member mangini_m
annihilator.member waters_j
as_cities_burn.guest scogin_j
dream_theater.member mangini_m
dream_theater.member sherinian_d
geology.member jehanian_g
listener.member smith_d
megadeth.member degrasso_j
megadeth.member mustaine_d
megadeth.member pitrelli_a
metallica.member mustaine_d
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
the_chariot.guest smith_d
the_chariot.guest weiss_a
the_chariot.guest williams_h
the_chariot.member eaton_d
the_chariot.member ryan_j
the_chariot.member scogin_j
tso.member pitrelli_a

puts g.generate_dot
