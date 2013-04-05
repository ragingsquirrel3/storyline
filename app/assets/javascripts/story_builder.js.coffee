$(->
	$('#MyCarousel').carousel(
		interval: false
	)
	sb = new StoryboardBuilder
	sb.initialize()
)
class StoryboardBuilder
  states: ['start', 'filtered', 'unfiltered']
  dimensions: ["Deal Type", "Acquirer Region", "Target Region"]
  activeSceneId: null
  dimensionDictionary = {}
  
  initialize: (options) ->
    d3.csv("../data/ma.csv", (csv) =>
      @data = csv
      @buildStory()
      )
    $('.next').click( =>
  	  @next()
  	  )
  	  
    $('.prev').click( =>
  	  @previous()
  	  )
  	  
  # contruct a miso storyboard from data attr
  buildStory: ->
    raw = $('#vis').data().chart.scenes
    
    protoStory =
      initial: 'scene0'
    
    protoStory['scenes'] = {}
    i = 0
    @dimensionDictionary = {}
    for scene in raw
      s = scene.dimensions
      @dimensionDictionary["scene#{i}"] = s
      protoStory['scenes']["scene#{i}"] =
        enter: =>
          @draw(@data)
      i++
    # From an array of scenes, make storyboard.  Each state requires an id, an array of dimenions, and filter hashes (key and value)
    @story = new Miso.Storyboard(protoStory)
    @startStory()
    
  next: =>
    i = @activeSceneId.substring(@activeSceneId.length - 1, @activeSceneId.length)
    # TODO, dont let it go to far
    i++
    @activeSceneId = "scene#{i}"
    @story.to("scene#{i}")
    
  previous: =>
    i = @activeSceneId.substring(@activeSceneId.length - 1, @activeSceneId.length)
    if i < 1
      i = 0
    else
      i--
    @activeSceneId = "scene#{i}"
    @story.to("scene#{i}")
    
  startStory: =>
    @activeSceneId = 'scene0'
    @story.start()
    
  storyToFilter: ->
    @story.to('scene1')
  
  draw: (data) =>
    $('#vis').empty()
    width = $("#vis").width()
    @dimensions = @dimensionDictionary[@activeSceneId]
    @chart = d3.parsets().dimensions(@dimensions)
    @vis = d3.select("#vis").append("svg").attr("width", width).attr("height", @chart.height())
    @vis.datum(data).call(@chart.width(width))