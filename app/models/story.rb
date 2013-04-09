class Story
  include Mongoid::Document
  include Mongoid::Timestamps
  
  embeds_many :scenes
  
  field :name, type: String
  field :description, type: String
  
  def add_scene(options)
    s = Scene.new
    s.story = self
    s.name = "scene#{self.scenes.length - 1}"
    s.title = options['title']
    s.content = options['content']
    s.chart_type = options['chart_type']
    infile = options['data'].read
    keys = CSV.parse(infile).first
    raw = []
    CSV.parse(infile) do |row|
      new = {}
      keys.each_with_index do |key, i|
        new[key] = row[i]
      end
      raw.append new
    end
    raw.delete_at(0) # remove the first entry, which is a redundant header
    s.data = raw
    s.save
  end
  
  def to_api
    raw_story = {}
    self.scenes.each do |scene|
      raw_story["#{scene.name}"] = {
        content: scene.content,
        dimensions: scene.dimensions,
        data: scene.data
      }
    end
    raw_story      
  end
end
