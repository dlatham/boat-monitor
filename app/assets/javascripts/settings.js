// Functions specific to the setting controller and view

$( document ).ready(function(){

	$("#datepicker_heartbeats_destroy").datepicker().on('changeDate', function(){
		$("#heartbeats_destroy").addClass("loading").html("<span class='spinner-border spinner-border-sm'></span>");
		var getUrl = window.location;
		var baseUrl = getUrl.protocol + "//" + getUrl.host + "/heartbeats/get_count";
		var data = { date: selected_date };
		console.log("Starting request to [" + baseUrl + "] with params [" + selected_date + "]");
		var request = $.ajax({
			url: baseUrl,
			method: "GET",
			data: data,
			success: function(data) {
				$("#heartbeats_destroy").toggleClass("loading btn-warning btn-danger").html("Destroy " + data + " records");
				$("#heartbeats_destroy").attr("disabled", false);

			},
			error: function() {
				alert("Something went wrong getting the record count.");
			}
		});
	});


	$("#heartbeats_destroy").click(function(){
		if(confirm("Are you sure? These records cannot be recovered."))
		{
			var getUrl = window.location;
			var baseUrl = getUrl.protocol + "//" + getUrl.host + "/heartbeats/destroy_before";
			var data = { date: selected_date };
			var request = $.ajax({
				url: baseUrl,
				method: "POST",
				data: data,
				success: function(data) {
					$("#heartbeats_destroy").toggleClass("loading btn-warning btn-danger").html("Records destroyed");
					$("#heartbeats_destroy").attr("disabled", true);
					$("#total_heartbeats").text(data["remaining"]);
				},
				error: function() {
					alert("Something went wrong detroying the records.");
				}
			});

		}
	})
});