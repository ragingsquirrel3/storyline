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
  states: null
  
  
  initialize: (options) ->
    @buildStory()
    d3.csv("../data/ma.csv", (csv) =>
      @data = csv
      @startStory(@data)
      )
    $('.next').click( =>
  	  @next()
  	  )
  	  
    $('.prev').click( =>
  	  @previous()
  	  )
  	  
  # contruct a miso storyboard from data attr
  buildStory: ->
    console.log 'building time'
    # From an array of scenes, make storyboard.  Each state requires an id, an array of dimenions, and filter hashes (key and value)
  
  next: =>
    i = @activeSceneId.substring(@activeSceneId.length - 1, @activeSceneId.length)
    # TODO, dont let it go to far
    i++
    @activeSceneId = "scene#{i}"
    @story.to("scene#{i}")
    
  previous: =>
    i = @activeSceneId.substring(@activeSceneId.length - 1, @activeSceneId.length)
    console.log "trying to go to scene#{i}"
    if i < 1
      i = 0
    else
      i--
    @activeSceneId = "scene#{i}"
    @story.to("scene#{i}")
    
  startStory: (data) =>
    @story = new Miso.Storyboard(
    		initial: 'scene0'
    		scenes:
    			scene0:
    				enter: =>
    				  @dimensions = ["Deal Type", "Acquirer Region", "Target Region"]
    				  @draw(@data)
    				exit: =>
    			
    			scene1:
    				enter: =>
              @dimensions = ["Deal Type", "Acquirer Region"]
              @draw(@data)

    			ending: {}
    	)
    	@story.start()
    	@activeSceneId = @story.scene()
    	
  storyToFilter: ->
    @story.to('scene1')
  
  draw: (data) ->
    $('#vis').empty()
    width = $("#vis").width()
    @chart = d3.parsets().dimensions(@dimensions)
    @vis = d3.select("#vis").append("svg").attr("width", width).attr("height", @chart.height())
    @vis.datum(data).call(@chart.width(width))