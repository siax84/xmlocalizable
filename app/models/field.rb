class Field < ApplicationRecord
  belongs_to :synchronization
  
  def to_s
    self.name
  end
  
  def name_with_line
    "#{self.name} - Line #{self.line}"
  end
  
end
