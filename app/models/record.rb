class Record < ApplicationRecord
  has_many :host_records, dependent: :destroy
  has_many :hosts, through: :host_records
end
