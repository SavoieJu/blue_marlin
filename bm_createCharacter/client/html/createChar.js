window.addEventListener("message", (event) => {
	if (event.data.type == "") {

		toggle_CS_UI();
	}
});

function toggle_CS_UI() {
	$("body").toggleClass("hidden");
}