module AttackRemarks
  class AccurateAttackRemarks
    def random_attack_remark(target)
      r = Random.new
      remarks =
          [
              "#{target.name} is going to feel that in the morning",
              "Right in #{target.name}'s weak spot!",
              "#{target.name}'s blood is everywhere.",
              "#{target.name} almost dodged that one",
              "Is this the end for #{target.name}?",
              'That was a powerful strike',
              "I'm not sure if #{target.name} can get up after that attack"
          ]

      remarks[r.rand(remarks.length)]
    end
  end

  class MissRemarks
    def random_miss_remark(attacker)
      r = Random.new
      remarks =
          [
              'How embarrassing!',
              'Should have gone to specsavers',
              "Woeful performance on #{attacker.name}'s part, just woeful",
              'So close, yet so far!',
              "Can't believe #{attacker.name} missed that one!",
              "Critical Error for #{attacker.name}!",
              "Is this the beginning of the end for #{attacker.name}?"
          ]
      remarks[r.rand(remarks.length)]
    end
  end
end
