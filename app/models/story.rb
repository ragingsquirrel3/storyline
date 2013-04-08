class Story
  include Mongoid::Document
  include Mongoid::Timestamps
  
  embeds_many :scenes
  
  field :name, type: String
  field :description, type: String
  
  def add_scene(options)
    s = Scene.new(options)
    s.story = self
    s.name = "scene#{self.scenes.length - 1}"
    s.save
  end
  
  def to_api
    raw_story = {}
    self.scenes.each do |scene|
      raw_story["#{scene.name}"] = {
        content: scene.content,
        dimensions: scene.dimensions
      }
    end
    raw_story      
  end
end
