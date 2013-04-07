class Scene
  include Mongoid::Document
  include Mongoid::Timestamps
  
  embedded_in :story
  
  field :name, type: String, default: 'scene1'
  field :title, type: String, default: 'untitled'
  field :content, type: String, default: 'Please add some content.'
  
  field :chart_type, type: String, default: 'parsets'
  field :dimensions, type: Array, default: ['Acquiring Region', 'Target Region']
end
