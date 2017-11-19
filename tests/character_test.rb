require 'test/unit'
require_relative '../lib/object_orientated_game/characters/character'
require_relative '../lib/object_orientated_game/characters/ninja'

class CharacterTest < Test::Unit::TestCase
  def setup
    @ninja = Ninja.new('Mr. Ninja', 100, 100, self.class)
    @samurai = Samurai.new('Mr. Samurai', 200, 200, self.class)
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
end