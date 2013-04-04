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
  	@ds = new Miso.Dataset(
      url: "../data/ma.csv"
      delimiter: ","
      columns : [
          { name : "Deal Type" },
          { name : "Announce Date" },
          { name : "Target Name" },
          { name : "Acquirer Name" },
          { name : "Announced Total Value" },
          { name : "EBITDA Multiple" },
          { name : "Net Debt" },
          { name : "Acquirer Industry Sector" },
          { name : "Target Industry Sector" },
          { name : "Target Country" },
          { name : "Target Industry Sector" },
          { name : "Acquirer Country" },
          { name : "Target Country Name" },
          { name : "Acquirer Country Name" },
          { name : "Target Region" },
          { name : "Acquirer Region" } 
        ]
    )
    @ds.fetch(
      success: =>
        @startStory(@ds.toJSON())
    )
    
    $('.next').click( =>
  	  @storyToFilter()
  	)
  
  draw: (data) ->
    $('#vis').empty()
    dimensions = ["Deal Type", "Acquirer Region", "Target Region"]
    width = $("#vis").width()
    @chart = d3.parsets().dimensions(dimensions);
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
