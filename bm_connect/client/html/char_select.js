window.addEventListener("message", (event) => {
	if (event.data.type == "character_selection_open") {
		toggle_CS_UI();
	}
});

function toggle_CS_UI() {
	// $(".shopInterface-options-character").toggleClass("hidden");
	$("body").toggleClass("hidden");
}