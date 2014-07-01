module Spree
  class OptionType < ActiveRecord::Base
    has_many :option_values, order: "#{Spree::OptionValue.quoted_table_name}.position", dependent: :destroy
    has_many :product_option_types, dependent: :destroy
    has_many :products, through: :product_option_types
    has_and_belongs_to_many :prototypes, join_table: 'spree_option_types_prototypes'

    attr_accessible :name, :presentation, :option_values_attributes

    validates :name, :presentation, presence: true
    default_scope order: "#{quoted_table_name}.position"

    accepts_nested_attributes_for :option_values, reject_if: lambda { |ov| ov[:name].blank? || ov[:presentation].blank? }, allow_destroy: true
  end
end
