module CommonValidations
  extend ActiveSupport::Concern
  include ActiveModel::Validations

  PARENTS = %w(Supplier Rfid BanReasonType CardType)
  # CHILDREN = %w(Truck Driver Assistant)

  module ClassMethods

    def unique_validator obj
      conditions = []
      self::UNIQUE_COLUMNS.each do |t|
        conditions.push ApplicationRecord.send(:sanitize_sql_array, ["#{t} = ?",obj.send(t)])
      end
      where(conditions.join(' and ')).
      where("deleted_at is null").
      not_self(obj.id)
    end

  end

  included do

    validate :remove_parent_children
    # validate :disallow_deleting_with_child_assoc

    def remove_parent_children
      return unless self.try(:deleted_at).present?
      return unless self.deleted_at.present? && PARENTS.include?(self.class.name)
      assoc("has_many").each do |child_klass|
        errors.add(:base, error_message(child_klass.klass.model_name.human)) if self.send(child_klass.plural_name).any?
      end
    end

    def validate_uniquness_on_soft_deleted
      if self.class.unique_validator(self).limit(1).present?
        errors.add(:base,"This code is already taken")
        false
      end
    end

    # def disallow_deleting_with_child_assoc
    #   return unless self.deleted_at.present? && CHILDREN.include?(self.class.name)

    #   assoc("belongs_to").each do |child_klass|
    #     model_name = child_klass.klass.model_name

    #     errors.add(:base, error_message(model_name.human)) if self.send(model_name.singular).present?
    #   end
    # end


    private

    def assoc type
      self.class.reflect_on_all_associations(type.to_sym)
    end

    def error_message referenced_obj_name
      "Sorry, this action is not allowed. "\
      "This field is being referenced by a #{referenced_obj_name}."
    end

  end
end
