# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :string           not null
#

class Goal < ApplicationRecord
end
