require 'test/unit'
require_relative '../lib/object_orientated_game/gameplay'

class Gameplay < Test::Unit::TestCase
  def setup
    @gameplay = Gameplay.new
    @ninja = Ninja.new('Mr. Ninja', 100, 100, self.class)
    @samurai = Samurai.new('Mr. Samurai', 200, 200, self.class)
    @demon = Demon.new('Mr. Demon', 300, 300, self.class)
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

    input = 'words, numbers123, &special characters'
    assert_equal false, @gameplay.letters_only?(input)
  end
end