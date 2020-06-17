window.addEventListener("message", (event) => {
	if (event.data.type == "character_selection_open") {
		populate_CS_UI(event.data.char_1);
		populate_CS_UI(event.data.char_2);
		populate_CS_UI(event.data.char_3);
		populate_CS_UI(event.data.char_4);
		toggle_CS_UI();
	}
});

function toggle_CS_UI() {
	$("body").toggleClass("hidden");
}

function close_CS_UI(char_id) {
	let id = char_id
	toggle_CS_UI();
	$.post('http://bm_connect/bm:start', JSON.stringify({
			char_id: id,
		})
	);
}

function createChar() {
	toggle_CS_UI();
	$.post('http://bm_connect/bm:startCC', JSON.stringify({
			data: "create",
		})
	);
}

function populate_CS_UI(char) {
	let cs_selection = document.querySelector(".cs_selection");
	if (char != undefined) {
		var date = new Date(char.birth_date);

		cs_selection.innerHTML += `
			<div class="cs_box used">
			    <h3 class="cs_name">${char.first_name} ${char.last_name}</h3>
			    <h4 class="cs_job">${char.job_name}</h4>
			    <h4 class="cs_bank">bank: <span>${char.char_bank}.00$</span></h4>
			    <h4 class="cs_cash">pocket: <span>${char.char_pocket}.00$</span></h4>
			    <h4 class="cs_birth">Date of birth: <span>${formatDate(date)}</span></h4>
			    <button class="cs_play cs_button" onclick="close_CS_UI(${char.char_id})">Play</button>
			</div>
		`;
	} else {
		cs_selection.innerHTML += `
			<div class="cs_box empty">
			    <button class="cs_create cs_button" onclick="createChar()">Create</button>
			</div>
		`;
	}
}

var formatDate = function(timestamp) {
	var date = new Date(timestamp);
	var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October',	'November', 'December'];
	return months[date.getMonth()] + ' ' + date.getDate() + ', ' + date.getFullYear();

};