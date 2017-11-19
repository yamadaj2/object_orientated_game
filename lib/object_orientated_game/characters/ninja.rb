class Ninja < Character
  attr_reader :type

  def initialize(name, health_points, attack_points, type)
    super(name, health_points, attack_points)
    @type = self.class
  end
end