window.addEventListener("message", (event) => {
	if (event.data.type == "character_selection_open") {
		toggle_CS_UI();
	}
});

function toggle_CS_UI() {
	// $(".shopInterface-options-character").toggleClass("hidden");
	$("body").toggleClass("hidden");
}

function close_CS_UI() {
	toggle_CS_UI();
	$.post('http://bm_connect/bm:start', JSON.stringify({
     		data: "NUICallbackHere"
	 	})
	);
}