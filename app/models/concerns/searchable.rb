module Searchable
  extend ActiveSupport::Concern
  module ClassMethods

    def search query
      where(build_query(query))
    end

    private

    def build_query query
      query_string = []
      builder = Query::Builder.new
      query.each do |key, value|
        # value.present? would skip if the column is boolean and the value is false
        next if value=='' || value.nil? || value == "Any" || value == [""] || value == [] || value == 'All'
        partial_query = builder.process(key,value)
        query_string.push(partial_query) if partial_query.present?
      end
      # query_string.push(builder.build_exp_query(query)) if query[:max_experience].present?
      query_string.join(' and ')
    end


  end
end
