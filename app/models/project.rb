# == Schema Information
#
# Table name: projects
#
#  id             :integer          not null, primary key
#  name           :string
#  company_id     :integer
#  default_charge :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#

class Project < ActiveRecord::Base
  belongs_to :company
	has_many :services, dependent: :destroy
	has_many :users, :through => :services
	belongs_to :user

	validates :name, length: { minimum: 5 }
	validates :company_id, presence: true
	validates :default_charge, numericality: { only_integer: true,
											 greater_than: 50,
											 less_than: 10000 }

	scope :lowdefaultcharge, -> { where("default_charge < 100") }
end
