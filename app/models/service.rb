# == Schema Information
#
# Table name: services
#
#  id         :integer          not null, primary key
#  project_id :integer
#  user_id    :integer
#  dateworked :datetime
#  hours      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Service < ActiveRecord::Base
  belongs_to :project
	belongs_to :user

	validates :project, presence: true
	validates :user, presence: true
	validates :dateworked, presence: true
	validate :date_is_in_past
	validates :hours, numericality: { only_integer: true,
									  greater_than: 0,
									  less_than_or_equal_to: 8 }

	scope :fullday, -> { where("hours >= 8") }

	def date_is_in_past
		if dateworked.present? && dateworked > Time.now
			errors.add(:dateworked, "can't be in the future")
		end
	end

end
