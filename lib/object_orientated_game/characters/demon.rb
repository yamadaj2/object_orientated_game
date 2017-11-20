require_relative 'character'

class Demon < Character
  attr_reader :type

  def initialize(name, health_points, attack_points, type)
    super(name, health_points, attack_points)
    @type = self.class
  end

  def attack_list_length
    AttackList::DEMON_ATTACK_LIST.length
  end

  def show_demon_intro_scenes
    sleep 3
    puts self.show_demon_boss_intro_scene
    sleep 3
    puts self.show_demon_intro_line
    sleep 3
  end

  def show_demon_boss_intro_scene
    EnemyList::ENEMY_LIST[:boss_demon][:scene]
  end

  def show_demon_intro_line
    EnemyList::ENEMY_LIST[:boss_demon][:intro_line]
  end
end