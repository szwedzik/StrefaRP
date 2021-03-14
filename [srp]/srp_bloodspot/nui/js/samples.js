var selectedPane;
var selectedSlot;

var noBtns;

$(function() {
    
    window.addEventListener( 'message', function( event ) {
		if(event.data.type == 'show'){
			
			noBtns = false;
			
			$( "#samples_menu" ).show();
			updateSlots(event.data.samples);
		}
		else if(event.data.type == 'show-nobtns'){
			noBtns = true;
			
			$( "#samples_menu" ).show();
			updateSlots(event.data.samples);
		}
		else if(event.data.type == 'update'){
			updateSlots(event.data.samples);
		}
		else if(event.data.type == 'hide'){
			$( "#samples_menu" ).hide(); 
		}
    });

	$(".container").on("click", function()
	{
		$(".container").each(function(i)
		{
			$(this).removeClass("clicked");
		});
		$(this).addClass("clicked");
		
		if(noBtns == false)
		{
			$("#analyze").show();
			$("#clear").show();
			
			setTimeout(function() {
				$("#analyze").addClass("visible");
				$("#clear").addClass("visible");
			}, 50);
		}
		
		selectedPane = $(this).attr("data-id");
		selectedSlot = $(this).attr("data-slot");
	
	});
	
	$("#analyze, #clear").on("click", function()
	{
		
		$(".container").each(function(i)
		{
			$(this).removeClass("clicked");
		});
		
		$("#analyze").removeClass("visible");
		$("#clear").removeClass("visible");
		$("#analyze").hide();
		$("#clear").hide();
	});
	
	$("#analyze").on('click', function()
	{
		$.post("http://srp_bloodspot/showSampleData", JSON.stringify({id: selectedPane, slot: selectedSlot}));
		$.post('http://srp_bloodspot/exit', JSON.stringify({}));
	});
	
	$("#clear").on('click', function()
	{
		$.post("http://srp_bloodspot/clearSampleStick", JSON.stringify({id: selectedPane, slot: selectedSlot}));
		$.post('http://srp_bloodspot/exit', JSON.stringify({}));
	});

	document.onkeyup = function (data) {
        if (data.which == 27) { // Escape key
            $.post('http://srp_bloodspot/exit', JSON.stringify({}));
			
			
			$(".container").each(function(i)
			{
				$(this).removeClass("clicked");
			});
			
			
			$("#analyze").removeClass("visible");
			$("#clear").removeClass("visible");
			$("#analyze").hide();
			$("#clear").hide();
			
        }
    };
	
	$("#exit").on('click', function()
	{
		$.post('http://srp_bloodspot/exit', JSON.stringify({}));
		
		$(".container").each(function(i)
		{
			$(this).removeClass("clicked");
		});
		
		
		$("#analyze").removeClass("visible");
		$("#clear").removeClass("visible");
		$("#analyze").hide();
		$("#clear").hide();
	});
	
});


function updateSlots(data)
{
	
	$(".container").each(function(i)
	{
		$(this).removeClass("stick-clear");
		$(this).removeClass("stick-blood");
	});
	
	for(i = 0; i < data.length; i++)
	{
		if(data[i] == 0)
		{
			$("#slot"+(i+1)).addClass("stick-clear");
			$("#slot"+(i+1)).attr("data-id", -1);
		}
		else
		{
			$("#slot"+(i+1)).addClass("stick-blood");
			$("#slot"+(i+1)).attr("data-id", data[i].bloodid);
		}
	}
}
