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