window.addEventListener("message", (event) => {
	if (event.data.type == "character_creation") {
		fillInModels(JSON.parse(event.data.models))
	}
});

function toggle_CC_UI() {
	$("body").toggleClass("hidden");
}

function close_CC_UI(model, fname, lname) {
	toggle_CC_UI();
	$.post('http://bm_create_character/bm:closeCharCreate', JSON.stringify({
			data: "close",
			model: model,
			fname: fname,
			lname: lname,
		})
	);
}

function fillInModels(models) {
	let list = document.querySelector(".model_choice");

	for (let i = 0; i < models.length; i++) {
		list.innerHTML += `
		<option value="${i+1}">${i+1} ${models[i]}</option>
		`;
	}
	
	toggle_CC_UI();

	modelChange();
}

function collectCharacterInfo() {
	let model = document.querySelector(".model_choice").value;
	let fname = document.querySelector(".first_name").value;
	let lname = document.querySelector(".last_name").value;
	close_CC_UI(model, fname, lname)
}

function modelChange() {
	$( ".model_choice" ).change(function() {
		let model = document.querySelector(".model_choice").value;
		$.post('http://bm_create_character/bm:changeChar', JSON.stringify({
			model: model
		})
	);
	});
}