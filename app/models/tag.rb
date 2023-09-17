# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tags_on_name  (name) UNIQUE
#
class Tag < ApplicationRecord
    before_save :downcase_name

    validates :name, presence: true, length: { minimum: 3 }, uniqueness: { case_sensitive: false }

    has_many :taggings, dependent: :destroy
    has_many :episodes, through: :taggings

    private

    def downcase_name
        self.name.downcase!
    end
end
