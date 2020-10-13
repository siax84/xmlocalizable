class Mapping < ApplicationRecord
  belongs_to :source_field, class_name: 'Field'
  belongs_to :target_field, class_name: 'Field'
  belongs_to :synchronization
end
