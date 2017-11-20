require 'test/unit'
require_relative '../lib/object_orientated_game/gameplay'
require_relative '../lib/object_orientated_game/characters/ninja'
require_relative '../lib/object_orientated_game/characters/samurai'
require_relative '../lib/object_orientated_game/characters/demon'

class GameplayTest < Test::Unit::TestCase
  def setup
    @gameplay = Gameplay.new
    @ninja = Ninja.new('Mr. Ninja', 100, 100, self.class)
    @samurai = Samurai.new('Mr. Samurai', 200, 200, self.class)
    @demon = Demon.new('Mr. Demon', 300, 300, self.class)
  end

  test 'that random_enemy_selection method works as expected' do
    demon_count = 0
    samurai_count = 0
    ninja_count = 0
    other_count = 0
    loop_length = 100000

    loop_length.times{
      random_enemy = @gameplay.random_enemy_selection
      case random_enemy
        when EnemyList::ENEMY_LIST[:boss_demon][:object]
          demon_count += 1
        when EnemyList::ENEMY_LIST[:enemy_samurai][:object]
          samurai_count += 1
        when EnemyList::ENEMY_LIST[:enemy_ninja][:object]
          ninja_count += 1
        else
          other_count += 1
      end
    }

    # 5 - 5.5% of the time
    assert_operator demon_count, :>, loop_length * 0.05
    assert_operator demon_count, :<, loop_length * 0.055

    # 46.8% - 47.7% of the time
    assert_operator samurai_count, :>, loop_length * 0.468
    assert_operator samurai_count, :<, loop_length * 0.477

    # 46.8% - 47.7% of the time
    assert_operator ninja_count, :>, loop_length * 0.468
    assert_operator ninja_count, :<, loop_length * 0.477

    assert_equal 0, other_count
  end

  test 'that demon boss intro scene functions correctly' do
    expected_demon_boss_scene = "What the..? You've encountered the infamous Demon Boss Tuguro"
    assert_equal expected_demon_boss_scene, @demon.show_demon_boss_intro_scene
  end

  test 'that demon boss intro line functions correctly' do
    expected_demon_intro_line = "Tuguro says: \"I am more powerful than the others you have faced. You cannot win. Prepare to die\""
    assert_equal expected_demon_intro_line, @demon.show_demon_intro_line
  end

  test 'that show_health_statuses method works correctly.' do
    assert_equal "Your health: 100 | Mr. Samurai's health: 200", @gameplay.show_health_statuses(@ninja, @samurai)
    assert_equal "Your health: 200 | Mr. Demon's health: 300", @gameplay.show_health_statuses(@samurai, @demon)
  end

  test 'that show_characters_turn functions as expected' do
    assert_equal '*' * 30 + "  #{@ninja.name}'s Move  " + '*' * 30, @gameplay.show_characters_turn(@ninja)
    assert_equal '*' * 30 + "  #{@samurai.name}'s Move  " + '*' * 30, @gameplay.show_characters_turn(@samurai)
    assert_equal '*' * 30 + "  #{@demon.name}'s Move  " + '*' * 30, @gameplay.show_characters_turn(@demon)
  end

  test 'that show attack description method functions correctly for all 3 characters.' do
    attack_list = AttackList::NINJA_ATTACK_LIST
    ninja_attack_description_list =
        [
            'Mr. Ninja threw Ninja Stars.',
            'Mr. Ninja threw a Bolas, wrapping around its target and slams him to the ground!',
            'Mr. Ninja took out his Dagger and delivered a swift strike to the enemy!',
            'Mr. Ninja vanished into thin air and re-appeared behind the target, cutting him with a knife!'
        ]
    4.times do |index|
      assert_equal ninja_attack_description_list[index], @ninja.show_attack_description(index + 1)
    end

    attack_list = AttackList::SAMURAI_ATTACK_LIST
    samurai_attack_description_list =
        [
            'Mr. Samurai struck with a huge Sword Slash!',
            'Mr. Samurai is running and attacked with Sword Charge!',
            'Mr. Samurai began spinning and struck with Sword Spin, knocking the opponent to the ground!',
            'Mr. Samurai threw a lightening strong Energy Punch, sending the enemy flying into the air with a huge burst of light!'
        ]
    4.times do |index|
      assert_equal samurai_attack_description_list[index], @samurai.show_attack_description(index + 1)
    end

    attack_list = AttackList::DEMON_ATTACK_LIST
    demon_attack_description_list =
        [
            'Mr. Demon struck with a rapid Feral Demon Slash!',
            'Mr. Demon channeled demon energy through his body and fired a powerful Red Demon Blast at his target, exploding on impact!!! The battlefield has been destroyed leaving a crater in the centre!'
        ]

    2.times do |index|
      assert_equal demon_attack_description_list[index], @demon.show_attack_description(index + 1)
    end
  end

  test 'that attack is accurate 88% to 90% of the time' do
    accurate_count = 0
    loop_length = 10000

    loop_length.times{
      if @gameplay.attack_accurate?
        accurate_count += 1
      end
    }
    assert_operator accurate_count, :>, loop_length * 0.88
    assert_operator accurate_count, :<, loop_length * 0.9
  end

  test 'that letters_only method only allows letters to be accepted' do
    input = 'hello'
    assert @gameplay.letters_only?(input)

    input = '123'
    assert_equal false, @gameplay.letters_only?(input)

    input = 'abc123'
    assert_equal false, @gameplay.letters_only?(input)

    input = 'sentence with spaces'
    assert_equal false, @gameplay.letters_only?(input)

    input = '&specialCharacters%$@'
    assert_equal false, @gameplay.letters_only?(input)
  end
end