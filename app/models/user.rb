# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  first_name :string
#  last_name  :string
#  email      :string
#  company_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  belongs_to :company
	has_many :works
	has_many :projects, :through => :services

	validates :first_name, length: { minimum: 2 }
	validates :last_name, length: { minimum: 5 }
	validates :company, presence: true
	validates :email, presence: true,
              uniqueness: true,
              format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  def full_name
    "#{first_name} #{last_name}".titleize
  end
end
