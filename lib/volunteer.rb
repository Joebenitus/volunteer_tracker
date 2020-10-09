class Volunteer
  attr_reader :id
  attr_accessor :project_id, :name

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
    @id = attributes.fetch(:id)
  end
end