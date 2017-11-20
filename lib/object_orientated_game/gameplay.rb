require_relative '../object_orientated_game/characters/ninja'
require_relative '../object_orientated_game/characters/samurai'
require_relative '../object_orientated_game/characters/demon'
require_relative '../../lib/object_orientated_game/modules/enemy_list'
require_relative '../object_orientated_game/modules/player_character_list'

class Gameplay
  include EnemyList
  include PlayerCharacterList

  def random_enemy_selection
    r = Random.new
    random_selection = r.rand(19)
    case
      when random_selection.zero?
        enemy_character = EnemyList::ENEMY_LIST[:boss_demon][:object]
      when random_selection >= 1 && random_selection <= 9
        enemy_character = EnemyList::ENEMY_LIST[:enemy_samurai][:object]
      when random_selection > 9 && random_selection <= 20
        enemy_character = EnemyList::ENEMY_LIST[:enemy_ninja][:object]
    end

    enemy_character
  end

  # todo test(stdin)
  def player_setup
    player_input = choose_character_menu
    case player_input
      when 1
        player_character = PlayerCharacterList::PLAYERS[:player_ninja]
      when 2
        player_character = PlayerCharacterList::PLAYERS[:player_samurai]
    end
    player_character.name = choose_player_name

    player_character
  end

  # todo test (stdin)
  def choose_character_menu
    player_input = 0

    while player_input <= 0 || player_input > PlayerCharacterList::PLAYERS.length
      puts 'Choose your character by entering a number'
      puts "1 for the #{PlayerCharacterList::PLAYERS[:player_ninja].type}"
      puts "2 for the #{PlayerCharacterList::PLAYERS[:player_samurai].type}"
      player_input = gets.chomp.to_i
    end

    player_input
  end

  # todo test (stdin)
  def choose_player_name
    puts 'Type a name for you character using letters only.'
    player_name = gets.chomp
    if letters_only?(player_name)
      player_name
    else
      choose_player_name
    end
  end

  def letters_only?(player_input)
    !/^[A-z]+$/.match(player_input).nil?
  end

  def divider
    divider = '-' * 40
  end
end