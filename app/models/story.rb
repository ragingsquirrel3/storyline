class Story
  include Mongoid::Document
  include Mongoid::Timestamps
  
  embeds_many :scenes
  
  field :name, type: String
  field :description, type: String
  
  def add_scene
    s = Scene.new
    s.story = self
    s.name = "scene#{self.scenes.length}"
    s.save
  end
end
