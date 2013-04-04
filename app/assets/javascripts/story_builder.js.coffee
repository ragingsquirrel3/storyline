$(->
	$('#MyCarousel').carousel(
		interval: false
	)
	
	
	demoBlock = $('#demoblock')
	boxes = new Miso.Storyboard(
		initial: 'loading'
		scenes:
			loading:
				enter: ->
					console.log 'enter loading'
				exit: -> console.log 'exiting load'
				
			painting:
				enter: -> console.log 'now painting'
				exit: -> console.log 'done painting'
				
			ending: {}
	)
	
	boxes.start().then( ->
		boxes.to('painting').then( ->
			boxes.to('loading')
		)
	)
	
	
)

		