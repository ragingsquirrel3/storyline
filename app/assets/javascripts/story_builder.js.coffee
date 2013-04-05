$(->
	$('#MyCarousel').carousel(
		interval: false
	)
	sb = new StoryboardBuilder
	sb.initialize()
)
class StoryboardBuilder
  states: ['start', 'filtered', 'unfiltered']
  initialize: (options) ->
    d3.csv("../data/ma.csv", (csv) =>
      @data = csv
      console.log csv
      @draw(@data)
      )
    $('.next').click( =>
  	  @storyToFilter()
  	  )
  draw: (data) ->
    console.log data
    $('#vis').empty()
    @dimensions = ["Deal Type", "Acquirer Region", "Target Region"]
    width = $("#vis").width()
    @chart = d3.parsets().dimensions(@dimensions)
    @vis = d3.select("#vis").append("svg").attr("width", width).attr("height", @chart.height())
    @vis.datum(data).call(@chart.width(width))
    
  startStory: (data) ->
    @story = new Miso.Storyboard(
    		initial: 'loading'
    		scenes:
    			loading:
    				enter: =>
    					 @draw(data)

    			filtered:
    				enter: => 
    				  data = @ds.where(
                rows: (row) ->
                  return row['Acquirer Country'] == 'US'
              )
              @vis.datum(data.toJSON()).call(@chart)
    				exit: -> console.log 'done filtering'

    			ending: {}
    	)
    	@story.start().then()
    	
  storyToFilter: ->
    @story.to('filtered')
