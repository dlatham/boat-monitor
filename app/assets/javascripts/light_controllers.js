// Support for light_controllers model and controller
var device_local, device_remote, active_controller, active_controller_id, power_on_config;

// new light controller
function convertToSlug(Text)
{
    return Text
        .toLowerCase()
        .replace(/ /g,'-')
        .replace(/[^\w-]+/g,'')
        ;
}

function lightControllerNameChange(field)
{
	//alert(convertToSlug(field.value));
	$("#light_controller_slug").val(convertToSlug(field.value));
}

// show light controller
$(document).ready(function() {
	$("#show_light_controller_form").submit(function(){
        return false;
    });


    $("#local_base_url").keyup(function(event) {
    	if(device_local)
    	{
    		if($(this).val() == light_controllers[active_controller]["device_local_base_url"]){
    			$("#local_base_url_btn").attr("disabled", true);
    		} else {
    			$("#local_base_url_btn").html("Save");
				$("#local_base_url_btn").removeClass("btn-success btn-danger");
    			$("#local_base_url_btn").attr("disabled", false);
    		}
    	} else {
    		if($(this).val() == light_controllers[active_controller]["local_base_url"]){
    			$("#local_base_url_btn").attr("disabled", true);
    		} else {
    			$("#local_base_url_btn").html("Save");
				$("#local_base_url_btn").removeClass("btn-success btn-danger");
    			$("#local_base_url_btn").attr("disabled", false);
    		}
    	}
    });

    $("#remote_base_url").keyup(function(event) {
    	if(device_remote)
    	{
    		if($(this).val() == light_controllers[active_controller]["device_remote_base_url"]){
    			$("#remote_base_url_btn").attr("disabled", true);
    		} else {
    			$("#remote_base_url_btn").html("Save");
				$("#remote_base_url_btn").removeClass("btn-success btn-danger");
    			$("#remote_base_url_btn").attr("disabled", false);
    		}
    	} else {
    		if($(this).val() == light_controllers[active_controller]["remote_base_url"]){
    			$("#remote_base_url_btn").attr("disabled", true);
    		} else {
    			$("#remote_base_url_btn").html("Save");
				$("#remote_base_url_btn").removeClass("btn-success btn-danger");
    			$("#remote_base_url_btn").attr("disabled", false);
    		}
    	}
    });

    $("#power_config_save").click(function() {
    	save_light_config("power_config", active_controller_id, light_controllers[active_controller]["power_config"]);
    });

    $("#switch_config_save").click(function() {
    	save_light_config("switch_config", active_controller_id, light_controllers[active_controller]["switch_config"]);
    });

});


function show_light_controller(i, reset_toggles = true)
{
	active_controller = i; // used to reference the json light_controllers var
	console.log("active_controller:" + active_controller);
	active_controller_id = light_controllers[i]["id"]; // used to pass AJAX updates back to the server
	$(".light_controller_name").text(light_controllers[i]["name"]);
	// Parse all the statuses stored in "messages"
	$(".light_controller_status").html("");
	var l; var statuses = "";
	if (light_controllers[i]["messages"] != null)
	{
		for (l = 0; l < light_controllers[i]["messages"].length; l++)
		{
			statuses += "<div class=\"list-group-item\"><div class=\"row\"><div class=\"col-2\"><div class=\"status-" + light_controllers[i]["messages"][l]["status"] + "\"></div> <small class=\"font-weight-lighter\">";
			statuses += light_controllers[i]["messages"][l]["status"]
			statuses += "</small></div><div class=\"col-6 truncate-text\">";
			statuses += light_controllers[i]["messages"][l]["description"];
			statuses += "</div><div class=\"col-4 text-right\"><span class=\"shortDateFormat font-weight-lighter\">";
			statuses += light_controllers[i]["messages"][l]["created_at"];
			statuses += "</span> <small>(";
			statuses += $.format.prettyDate(light_controllers[i]["messages"][l]["created_at"]) + ")</small></div></div></div>";
		}
		$(".light_controller_status").html(statuses);
		handle_date_shortener();
	}

	//reset the URL buttons
	$("#local_base_url_btn").html("Save");
	$("#local_base_url_btn").removeClass("btn-success btn-danger");
	$("#local_base_url_btn").attr("disabled", true);
	$("#remote_base_url_btn").attr("disabled", true);
		

	// Parse the URLs if the reset_toggles is true or not used
	if(reset_toggles)
	{
		if (!light_controllers[i]["device_local_base_url"])
		{
			$("#local_base_url").val(light_controllers[i]["local_base_url"]);
			$(".local-base-url").addClass("active");
			$(".device-local-base-url").removeClass("active");
			device_local = false;
		} else {
			$("#local_base_url").val(light_controllers[i]["device_local_base_url"]);
			$(".device-local-base-url").addClass("active");
			$(".local-base-url").removeClass("active");
			device_local = true;
		}

		if (!light_controllers[i]["device_remote_base_url"])
		{
			$("#remote_base_url").val(light_controllers[i]["remote_base_url"]);
			$(".remote-base-url").addClass("active");
			$(".device-remote-base-url").removeClass("active");
			device_remote = false;
		} else {
			$("#remote_base_url").val(light_controllers[i]["device_remote_base_url"]);
			$(".device-remote-base-url").addClass("active");
			$(".remote-base-url").removeClass("active");
			device_remote = true;
		}
	}

	// Set the light config UI
	initialize_power_config(active_controller);
	initialize_switch_config(active_controller);

}

function light_controller_toggle_device(base, device, id)
{
	var formField = "#" + base + "_base_url";
	var cssActive, cssInactive;
	
	if(device) // the mode being select t/f
	{
		cssActive = ".device-" + base + "-base-url";
		cssInactive = "." + base + "-base-url";
		if(base == "local"){
			device_local = device;
			$(formField).val(light_controllers[id]["device_local_base_url"]);
		} else {
			device_remote = device;
			$(formField).val(light_controllers[id]["device_remote_base_url"]);
		}
	} else {
		cssInactive = ".device-" + base + "-base-url";
		cssActive = "." + base + "-base-url";
		if(base == "local"){
			device_local = device;
			$(formField).val(light_controllers[id]["local_base_url"]);
		} else {
			device_remote = device;
			$(formField).val(light_controllers[id]["remote_base_url"]);
		}
	}
	$(cssActive).addClass("active");
	$(cssInactive).removeClass("active");
	return false;
}

function update_base_url(id, base, device, url, ssl)
{
	// base = remote || local, device = boolean, ssl = boolean (not currently supported in the data model)
	var getUrl = window.location;
	var baseUrl = getUrl.protocol + "//" + getUrl.host + "/light_controllers/" + light_controllers[id]["id"] + ".json";
	var data = { "base" : base, "device" : device, "url" : url, "ssl" : ssl, "update_type" : "base_url" };
	var varSelector;
	if(device)
	{
		varSelector = "device_" + base + "_base_url";
	} else {
		varSelector = base + "_base_url";
	}
	//var post_struct = { "post_url" : baseUrl, "device" : device, "url" : url };
	console.log("Starting request with params: " + JSON.stringify(data));
	//alert(JSON.stringify(data));
	var request = $.ajax({
		url: baseUrl,
		method: "PUT",
		data: data,
		success: function() {
			// Update the javascript data blob and refresh the main div
			light_controllers[id][varSelector] = url;
			show_light_controller(id, false);
			update_main_div();
			handle_success();
			$("#local_base_url_btn").attr("disabled", true);
			$("#remote_base_url_btn").attr("disabled", true);
		},
		error: function() {
			handle_failure();
		}
	});
}

function update_main_div()
{
	$('.remote-base-text').each(function(index) {
    	if(light_controllers[index]["device_remote_base_url"]){
    		$(this).text(light_controllers[index]["device_remote_base_url"]);
    	} else {
    		$(this).text(light_controllers[index]["remote_base_url"]);
    	}
    	
	});

	$('.local-base-text').each(function(index) {
    	if(light_controllers[index]["device_local_base_url"]){
    		$(this).text(light_controllers[index]["device_local_base_url"]);
    	} else {
    		$(this).text(light_controllers[index]["local_base_url"]);
    	}
    	
	});

	$('.remote-base-badge').each(function(index) {
		if(light_controllers[index]["device_remote_base_url"]){
			$(this).removeClass('badge-dark');
			$(this).addClass('badge-light');
		} else {
			$(this).removeClass('badge-light');
			$(this).addClass('badge-dark');
		}
	});

	$('.local-base-badge').each(function(index) {
    	if(light_controllers[index]["device_local_base_url"]){
    		$(this).removeClass('badge-dark');
    		$(this).addClass('badge-light')
    	} else {
    		$(this).removeClass('badge-light');
    		$(this).addClass('badge-dark')
    	}
    });

}


// THESE FUNCTIONS ARE ONLY USED ON THE SETTNGS VIEW - SEE IF THIS CAN BE REPUPOSED FOR THE OTHER VIEWS
function initialize_power_config(id)
{
	//power_on_config = light_controllers[id]["power_config"];
	//console.log(power_on_config);
	$("#light-config-power-on").html("");
	for(i=0; i<light_controllers[id]["total_lights"]; i++)
	{
		if(light_controllers[id]["power_config"] && light_controllers[id]["power_config"]["data"][i])
		{
			$("#light-config-power-on").append("<a class='color-picker float-left' id='power-on-config-" + i + "' data-controller='" + id + "' data-selector='power_config' data-id='" + i + "' style='background-color: rgb(" + light_controllers[id]["power_config"]["data"][i]["r"] + "," + light_controllers[id]["power_config"]["data"][i]["g"] + "," + light_controllers[id]["power_config"]["data"][i]["b"] + ")'></a>");
		} else {
			$("#light-config-power-on").append("<a class='color-picker float-left' id='power-on-config-" + i + "' data-controller='" + id + "' data-selector='power_config' data-id='" + i + "'></a>");
		}
			
	}
}

function initialize_switch_config(id)
{
	$("#light-config-switch").html("");
	if(light_controllers[id]["switch_config"])
	{
		for(j=0; j<light_controllers[id]["switch_config"]["data"].length; j++) // Loop through each config in the data array
		{
			var html = "<div class='row mb-3'><div class='col'>";
			for(i=0; i<light_controllers[id]["total_lights"]; i++)
			{
				if(light_controllers[id]["switch_config"]["data"][j][i])
				{
					html += "<a class='color-picker float-left' id='switch-config-" + j + "-" + i + "' data-controller='" + id + "' data-selector='switch_config' data-id='" + i + "' data-switch='" + j + "' style='background-color: rgb(" + light_controllers[id]["switch_config"]["data"][j][i]["r"] + "," + light_controllers[id]["switch_config"]["data"][j][i]["g"] + "," + light_controllers[id]["switch_config"]["data"][j][i]["b"] + ")'></a>";
				} else {
					html += "<a class='color-picker float-left' id='switch-config-" + j + "-" + i + "' data-controller='" + id + "' data-selector='switch_config' data-id='" + i + "' data-switch='" + j + "'></a>";
				}	
			}
			html += "</div></div>";
			$("#light-config-switch").append(html);
		}
	}
}

function save_light_config(type, id, config)
{
	// Take the JSON to pass to the server and update the power_config field
	var getUrl = window.location;
	var baseUrl = getUrl.protocol + "//" + getUrl.host + "/light_controllers/" + id + ".json";
	if(type == "power_config"){
		var data = { update_type: "power_config", power_config: config }
		$("#power_config_save").attr("disabled", true);
	} else {
		var data = { update_type: "switch_config", switch_config: JSON.stringify(config) }
		$("#switch_config_save").attr("disabled", true);
	}
	console.log("Starting request to [" + baseUrl + "] with data [" + JSON.stringify(data) + "]");
	var request = $.ajax({
		url: baseUrl,
		method: "PUT",
		data: data,
		success: function() {
			handle_success();
		},
		error: function() {
			handle_failure();
		}
	});

}

function new_switch_config()
{
	var new_data = [];
	for(i=0; i<light_controllers[active_controller]["total_lights"]; i++){
		new_data.push({r: 0, g: 0, b: 0});
	}
	if(light_controllers[active_controller]["switch_config"]){
		light_controllers[active_controller]["switch_config"]["data"].push(new_data);
		light_controllers[active_controller]["switch_config"]["from"] = current_device;
		light_controllers[active_controller]["switch_config"]["sent"] = "";
	} else {
		light_controllers[active_controller]["switch_config"] = { from: current_device, sent: "", data: [new_data] };
	}
	initialize_switch_config(active_controller);
	$("#switch_config_save").attr("disabled", false);
}

function send_config_to_controller(){
	// The client needs to send the configuration in case the controller isn't accessible to the server
	console.log("Sending configuration to light controller id [" + active_controller_id + "]");
	// Power config
	$("#controller_status").text("Sending power on configuration...");
	var url = "http://" + (local_device ? light_controllers[active_controller]["local_base_url"] : light_controllers[active_controller]["remote_base_url"]) + "/config/power";
	light_controllers[active_controller]["power_config"]["sent"] = new Date();
	var data = JSON.stringify(light_controllers[active_controller]["power_config"]);
	console.log(url);
	console.log(data);
	var request = $.ajax({
		url: url,
		method: "POST",
		contentType: "text/plain",
		data: data,
		success: function(){
			$("#controller_status").text("Power configuration sent.");
			console.log("Power configuration successfully sent.");
		},
		error: function() {
			light_controllers[active_controller]["power_config"]["sent"] = "";
			alert("Something went wrong.");
			return;
		}
	});
	$("#controller_status").text("Updating timestamps on the server...");
	save_light_config("power_config", active_controller_id, light_controllers[active_controller]["power_config"]);

	// Switch config
	$("#controller_status").text("Sending switch configurations...");
	var url = "http://" + (local_device ? light_controllers[active_controller]["local_base_url"] : light_controllers[active_controller]["remote_base_url"]) + "/config/switch";
	light_controllers[active_controller]["switch_config"]["sent"] = new Date();
	var data = JSON.stringify(light_controllers[active_controller]["switch_config"]);
	console.log(url);
	console.log(data);
	var request = $.ajax({
		url: url,
		method: "POST",
		contentType: "text/plain",
		data: data,
		success: function(){
			$("#controller_status").text("Switch configuration sent.");
			console.log("Switch configuration successfully sent.");
		},
		error: function() {
			light_controllers[active_controller]["switch_config"]["sent"] = "";
			alert("Something went wrong.");
			return;
		}
	});
	$("#controller_status").text("Updating timestamps on the server...");
	save_light_config("switch_config", active_controller_id, light_controllers[active_controller]["switch_config"]);

	$("#controller_status").text("Updated.");

}
