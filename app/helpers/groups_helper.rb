module GroupsHelper
  def members_collection_select
    User.all.map { |m| [m.name, m.id] }
  end

  def debt_summary_for(group)
    members = group.members
    debt = []
    (0..members.size-1).each do |i|
      (1..members.size-1).each do |j|
        next if i > j # ignore repeatative comparison which duplicates results
        db = group.debt_to(members[i], members[j]).to_i
        cr = group.credit_to(members[i], members[j]).to_i
        next if (db==cr)

        if db > cr
          debt << { amount: (db - cr), payer: members[i].name, payee: members[j].name }
        else
          debt << { amount: (cr - db), payer: members[j].name, payee: members[i].name }
        end
      end
    end
    debt
  end

  def summary_for(group, user=current_user)
    summary = {}
    paid = group.total_paid_by(user).to_i
    spent = group.total_spent_by(user).to_i

    if paid > spent
      summary[:result] = { credit: (paid-spent) }
    else
      summary[:result] = { debt: (spent-paid) }
    end
    summary
  end
end
