require 'test/unit'
require_relative '../lib/object_orientated_game/characters/character'
require_relative '../lib/object_orientated_game/characters/ninja'
require_relative '../lib/object_orientated_game/characters/samurai'
require_relative '../lib/object_orientated_game/characters/demon'


class CharacterTest < Test::Unit::TestCase
  def setup
    @ninja = Ninja.new('Mr. Ninja', 100, 100, self.class)
    @samurai = Samurai.new('Mr. Samurai', 200, 200, self.class)
    @demon = Demon.new('Mr. Demon', 300, 300, self.class)
  end

  test 'that show_full_stats method works with correct stdout formatting for ninja' do
    divider = '-' * 40
    expected = <<~END
      #{divider}
        Name: #{@ninja.name}
        Type: #{@ninja.type}
        Health Points: #{@ninja.health_points}
        Attack Points: #{@ninja.attack_points}
      #{divider}
    END

    assert_equal expected, @ninja.show_full_stats
  end

  test 'that show_player_selection functions as expected' do
    assert_equal 'You chose Mr. Ninja the Ninja', @ninja.show_player_selection
    assert_equal 'You chose Mr. Samurai the Samurai', @samurai.show_player_selection
  end

  test 'that show_challenge_line functions as expected' do
    assert_equal 'Mr. Ninja the Ninja has appeared and is challenging you to a fight to the death!', @ninja.show_challenge_line
    assert_equal 'Mr. Samurai the Samurai has appeared and is challenging you to a fight to the death!', @samurai.show_challenge_line
    assert_equal 'Mr. Demon the Demon has appeared and is challenging you to a fight to the death!', @demon.show_challenge_line
  end

  test 'that show_character_intro line functions as expected' do
    possible_outcomes =
        [
            "Mr. Ninja looks at you dead in the eye and says:\n\"Where did you get those clothes? At the toilet store?\"",
            "Mr. Ninja looks at you dead in the eye and says:\n\"When I get a hold of you, I'm going to shove a sausage down your throat and stick starving dogs in your butt!\"",
            "Mr. Ninja looks at you dead in the eye and says:\n\"When I get a hold of you, I'm going to gouge out your eyes and shove 'em down your pants so you can watch me kick the crap out of you!\"",
            "Mr. Ninja looks at you dead in the eye and says:\n\"Do you feel lucky? Punk!\"",
            "Mr. Ninja looks at you dead in the eye and says:\n\"Sticks and stones may break my bones but I'm going to kick you repeatedly in the balls\"",
            "Mr. Ninja looks at you dead in the eye and says:\n\"Hi, I'm a stupid moron with an ugly face and a big butt and my butt smells and...I like to kiss my own butt.\"",
            "Mr. Ninja looks at you dead in the eye and says:\n\"It's me, Mr. Crowbar. And this is my friend who is also a crowbar.\""
        ]

    assert_each_element_occurs_at_least_once(possible_outcomes){@ninja.show_character_intro}
    assert_each_element_has_equal_chance_of_occurring(possible_outcomes){@ninja.show_character_intro}
  end

  test 'that character trash talk functions as expected' do
    trash_talk =
        [
            "\"Where did you get those clothes? At the toilet store?\"",
            "\"When I get a hold of you, I'm going to shove a sausage down your throat and stick starving dogs in your butt!\"",
            "\"When I get a hold of you, I'm going to gouge out your eyes and shove 'em down your pants so you can watch me kick the crap out of you!\"",
            "\"Do you feel lucky? Punk!\"",
            "\"Sticks and stones may break my bones but I'm going to kick you repeatedly in the balls\"",
            "\"Hi, I'm a stupid moron with an ugly face and a big butt and my butt smells and...I like to kiss my own butt.\"",
            "\"It's me, Mr. Crowbar. And this is my friend who is also a crowbar.\""
        ]

    assert_each_element_occurs_at_least_once(trash_talk){@samurai.character_trash_talk}
    assert_each_element_has_equal_chance_of_occurring(trash_talk){@samurai.character_trash_talk}
  end

  test 'that show_attack_description functions as expected' do
    assert_equal 'Mr. Ninja threw Ninja Stars.', @ninja.show_attack_description(1)
    assert_equal 'Mr. Ninja threw a Bolas, wrapping around its target and slams him to the ground!', @ninja.show_attack_description(2)
    assert_equal 'Mr. Ninja took out his Dagger and delivered a swift strike to the enemy!', @ninja.show_attack_description(3)
    assert_equal 'Mr. Ninja vanished into thin air and re-appeared behind the target, cutting him with a knife!', @ninja.show_attack_description(4)

    assert_equal 'Mr. Samurai struck with a huge Sword Slash!', @samurai.show_attack_description(1)
    assert_equal 'Mr. Samurai is running and attacked with Sword Charge!', @samurai.show_attack_description(2)
    assert_equal 'Mr. Samurai began spinning and struck with Sword Spin, knocking the opponent to the ground!', @samurai.show_attack_description(3)
    assert_equal 'Mr. Samurai threw a lightening strong Energy Punch, sending the enemy flying into the air with a huge burst of light!', @samurai.show_attack_description(4)

    assert_equal 'Mr. Demon struck with a rapid Feral Demon Slash!', @demon.show_attack_description(1)
    assert_equal 'Mr. Demon channeled demon energy through his body and fired a powerful Red Demon Blast at his target, exploding on impact!!! The battlefield has been destroyed leaving a crater in the centre!', @demon.show_attack_description(2)
  end

  #TODO test select_attack method

  test 'that get_attack_list method works as expected for each character' do
    expected_ninja_attack_list =
        {
            ninja_stars: { attack_name: 'Ninja Stars', damage: 0.4, description: 'threw Ninja Stars.'},
            bolas: { attack_name: 'Bolas', damage: 0.2, description: 'threw a Bolas, wrapping around its target and slams him to the ground!' },
            dagger_strike: { attack_name: 'Dagger Strike', damage: 0.5, description: 'took out his Dagger and delivered a swift strike to the enemy!' },
            shadow_stab: { attack_name: 'Shadow Stab', damage: 0.8, description: 'vanished into thin air and re-appeared behind the target, cutting him with a knife!' },
        }
    assert_equal expected_ninja_attack_list, @ninja.get_attack_list
    assert_equal 4, @ninja.get_attack_list.length

    expected_samurai_attack_list =
        {
            sword_slash: { attack_name: 'Sword Slash', damage: 0.6, description: 'struck with a huge Sword Slash!'},
            sword_charge: { attack_name: 'Sword Charge', damage: 0.8, description: 'is running and attacked with Sword Charge!'},
            sword_spin: { attack_name: 'Sword Spin', damage: 0.7, description: 'began spinning and struck with Sword Spin, knocking the opponent to the ground!'},
            heavy_punch: { attack_name: 'Energy Punch', damage: 0.9, description: 'threw a lightening strong Energy Punch, sending the enemy flying into the air with a huge burst of light!'}
        }
    assert_equal expected_samurai_attack_list, @samurai.get_attack_list
    assert_equal 4, @samurai.get_attack_list.length

    expected_demon_attack_list =
        {
            demonic_slash: { attack_name: 'Demonic Slash', damage: 0.4, description: 'struck with a rapid Feral Demon Slash!'},
            demon_blast: { attack_name: 'Demon Blast', damage: 1.5, description: 'channeled demon energy through his body and fired a powerful Red Demon Blast at his target, exploding on impact!!! The battlefield has been destroyed leaving a crater in the centre!'}
        }
    assert_equal expected_demon_attack_list, @demon.get_attack_list
    assert_equal 2, @demon.get_attack_list.length
  end

  test 'that is_alive? method works as expected' do
    @ninja.health_points = 1
    @samurai.health_points = 1
    @demon.health_points = 1
    assert @ninja.is_alive?
    assert @samurai.is_alive?
    assert @demon.is_alive?

    @ninja.health_points = 0
    @samurai.health_points = 0
    @demon.health_points = 0
    assert !@ninja.is_alive?
    assert !@samurai.is_alive?
    assert !@demon.is_alive?

    @ninja.health_points = -1
    @samurai.health_points = -1
    @demon.health_points = -1
    assert !@ninja.is_alive?
    assert !@samurai.is_alive?
    assert !@demon.is_alive?
  end

  test "that calculate_damage method works as expected for each character's attacks" do
    assert_equal 40, @ninja.calculate_damage(1)
    assert_equal 20, @ninja.calculate_damage(2)
    assert_equal 50, @ninja.calculate_damage(3)
    assert_equal 80, @ninja.calculate_damage(4)

    assert_equal 120, @samurai.calculate_damage(1)
    assert_equal 160, @samurai.calculate_damage(2)
    assert_equal 140, @samurai.calculate_damage(3)
    assert_equal 180, @samurai.calculate_damage(4)

    assert_equal 120, @demon.calculate_damage(1)
    assert_equal 450, @demon.calculate_damage(2)
  end

  test 'that deduct_health method functions as expected' do
    assert_equal 100, @ninja.health_points
    @ninja.deduct_health(10)
    assert_equal 90, @ninja.health_points

    assert_equal 200, @samurai.health_points
    @samurai.deduct_health(10)
    assert_equal 190, @samurai.health_points

    assert_equal 300, @demon.health_points
    @demon.deduct_health(10)
    assert_equal 290, @demon.health_points
  end

  test 'that damage_received_remark functions as expected' do
    attack_remarks_array =
        [
            "Mr. Samurai is going to feel that in the morning",
            "Right in Mr. Samurai's weak spot!",
            "Mr. Samurai's blood is everywhere.",
            "Mr. Samurai almost dodged that one",
            "Is this the end for Mr. Samurai?",
            'That was a powerful strike',
            "I'm not sure if Mr. Samurai can get up after that attack"
        ]

    assert_each_element_has_equal_chance_of_occurring(attack_remarks_array){@samurai.damaged_received_remark}
    assert_each_element_occurs_at_least_once(attack_remarks_array){@samurai.damaged_received_remark}
  end

  #todo test show damage_scene (stdout)

  test 'that show_target_is_hit functions correctly' do
    assert_equal 'Mr. Ninja is hit!', @ninja.show_target_is_hit(@ninja)
    assert_equal 'Mr. Samurai is hit!', @ninja.show_target_is_hit(@samurai)
    assert_equal 'Mr. Demon is hit!', @ninja.show_target_is_hit(@demon)
  end

  test 'that show_damage_amount functions correctly' do
    assert_equal 'Damage inflicted: 100', @ninja.show_damage_amount(100)
    assert_equal 'Damage inflicted: 100', @samurai.show_damage_amount(100)
    assert_equal 'Damage inflicted: 100', @demon.show_damage_amount(100)
  end

  private

  def assert_each_element_occurs_at_least_once(array_name)
    #todo this should be DRY
    counters_hash = initialize_counters
    loop_number = 10000
    loop_number.times{
      random_element = yield
      assert array_name.include?(random_element)
      counters_hash = count_element(array_name, random_element, counters_hash)
    }

    assert_operator counters_hash[:element_0_counter], :>, 0
    assert_operator counters_hash[:element_1_counter], :>, 0
    assert_operator counters_hash[:element_2_counter], :>, 0
    assert_operator counters_hash[:element_3_counter], :>, 0
    assert_operator counters_hash[:element_4_counter], :>, 0
    assert_operator counters_hash[:element_5_counter], :>, 0
    assert_operator counters_hash[:element_6_counter], :>, 0
    assert_equal 0, counters_hash[:unknown_element_counter]
  end

  def assert_each_element_has_equal_chance_of_occurring(array_name)
    #todo this should be DRY
    counters_hash = initialize_counters
    loop_number = 10000
    loop_number.times{
      random_element = yield
      assert array_name.include?(random_element)
      counters_hash = count_element(array_name, random_element, counters_hash)
    }
    # todo Implement proper calculation for MOE with a 95% confidence interval
    margin_of_error = 300
    equal_chance_number = (loop_number / array_name.length) + margin_of_error

    assert_operator counters_hash[:element_0_counter], :<, equal_chance_number
    assert_operator counters_hash[:element_1_counter], :<, equal_chance_number
    assert_operator counters_hash[:element_2_counter], :<, equal_chance_number
    assert_operator counters_hash[:element_3_counter], :<, equal_chance_number
    assert_operator counters_hash[:element_4_counter], :<, equal_chance_number
    assert_operator counters_hash[:element_5_counter], :<, equal_chance_number
    assert_operator counters_hash[:element_6_counter], :<, equal_chance_number
    assert_equal 0, counters_hash[:unknown_element_counter]
  end

  def initialize_counters
    counter_hash =
        {
            element_0_counter: 0,
            element_1_counter: 0,
            element_2_counter: 0,
            element_3_counter: 0,
            element_4_counter: 0,
            element_5_counter: 0,
            element_6_counter: 0,
            unknown_element_counter: 0
        }

    counter_hash
  end

  def count_element(array_name, random_element, counters)
    case random_element
      when array_name[0]
        counters[:element_0_counter] += 1
      when array_name[1]
        counters[:element_1_counter] += 1
      when array_name[2]
        counters[:element_2_counter] += 1
      when array_name[3]
        counters[:element_3_counter] += 1
      when array_name[4]
        counters[:element_4_counter] += 1
      when array_name[5]
        counters[:element_5_counter] += 1
      when array_name[6]
        counters[:element_6_counter] += 1
      else
        counters[:unknown_element_counter] += 1
    end

    counters
  end
end