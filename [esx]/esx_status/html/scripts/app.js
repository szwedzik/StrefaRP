(function(){

	let status = []
	let voice = []

	let renderStatus = function(){

		$('#status_list').html('');

		for(let i=0; i<status.length; i++){	

			if(!status[i].visible)
				continue;

			let statusDiv = $(
				'<div class="status_main" style="margin-left: ' + (i*25) + '%">' +
					'<div class="status_inner">' +
						'<div class="status_val_under"></div>' +
						'<div class="status_val"></div>' +
					'</div>' +
				'</div>');

			statusDiv.find('.status_val')
				.css({
					'background-color' : status[i].color,
					'width'            : (status[i].val / 10000) + '%'
				})
			;
			
			statusDiv.find('.status_val_under')
				.css({
					'background-color' : status[i].color
				})
			;

			$('#status_list').append(statusDiv)
		}

		let statusDiv = $(
			'<div class="status_voice" style="margin-left: 50%">' +
				'<div class="status_inner">' +
					'<div class="status_val_under"></div>' +
					'<div class="status_val"></div>' +
				'</div>' +
			'</div>');

		statusDiv.find('.status_val')
			.css({
				'background-color' : voice.color,
				'width'            : voice.val + '%'
			})
		;
		
		statusDiv.find('.status_val_under')
			.css({
				'background-color' : voice.basecolor
			})
		;

		$('#status_list').append(statusDiv)

	}

	window.onData = function(data){

		if(data.update){
			
			status.length = 0;

			for(let i=0; i<data.status.length; i++)
				status.push(data.status[i])
		}
		
		if(data.updatev){
			
			voice = data.voice[0];
		}
		
		if(data.updatev || data.update)
		{
			renderStatus();
		}

		if(data.setDisplay){
			$('#status_list').css({'opacity' : data.display})
		}

	}

	window.onload = function(e){ window.addEventListener('message', function(event){ onData(event.data) }); }

})()