class Host < ApplicationRecord
  has_many :host_records, dependent: :destroy
  has_many :records, through: :host_records

  validates :url, presence: true
end
