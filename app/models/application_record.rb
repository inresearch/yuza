class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  after_initialize :init_new_record, if: :new_record?

  def init_new_record
  end
end
