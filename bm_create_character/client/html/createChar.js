window.addEventListener("message", (event) => {
	if (event.data.type == "character_creation") {
		toggle_CC_UI();
	}
});

function toggle_CC_UI() {
	$("body").toggleClass("hidden");
}

function close_CC_UI() {
	toggle_CC_UI();
	$.post('http://bm_create_character/bm:closeCharCreate', JSON.stringify({
			data: "close",
		})
    );
    console.log("sent again");
}