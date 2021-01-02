let previousItems = "";

window.addEventListener("message", (event) => {
	if (event.data.type == "openInventory") {
		console.log(event.data.items[2].item_name);
		if (previousItems == "") {
			loadInItems(event.data.items);
		} else {
			loadInItems(event.data.items);
		}
	}
});

function loadInItems(items) {
	let n = 0;
	$(".inv_slot").each(function (index, element) {
		$(element).empty();
	});

	items.forEach((el)=> {
		$(".player-inventory").children('.inv_slot').eq(n).append(`
		<div class="item clickable">
			<img src="images/${el.image_url}" alt="item">
			<h3 data-item-id="${el.item_id}" data-item-name="${el.item_name}" data-item-quantity="TODO">${el.item_name}</h3>
		</div>
		`);
		n++;
	})
	previousItems = items;
	addListenerToItems();
	toggle_Inv_UI();
}

function toggle_Inv_UI() {
	$("body").toggleClass("hidden");
}

function close_Inv_UI() {
	toggle_Inv_UI();
	$.post('http://bm_inventory/bm:closeInv', JSON.stringify({}));
}

function addListenerToItems() {
	let clickable = document.querySelectorAll('.clickable');
	const menu = document.getElementById('menu');
	const outClick = document.getElementById('out-click');

	clickable.forEach(element => {
		element.addEventListener('click', e => {
			e.preventDefault();
		
			menu.style.top = `${e.clientY}px`;
			menu.style.left = `${e.clientX}px`;
			menu.classList.add('show');
		
			outClick.style.display = "block";
		})
	});

	outClick.addEventListener('click', () => {
		menu.classList.remove('show');
		outClick.style.display = "none";
	})
}