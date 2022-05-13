class DataSourceSerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :description
end
