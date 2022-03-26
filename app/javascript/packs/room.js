$(document).on('turbolinks:load', function() {
    let rooms = document.getElementsByClassName("room-card");
    for (let room of rooms) {
    	let button_open = room.querySelector("button");
    	button_open.addEventListener("click", () => {
    		open_schedule(room.dataset.roomId, button_open);
    	}, false);
    	let button_close = document.getElementById("room-" + room.dataset.roomId + "-reservations");
    	button_close.addEventListener("click", () => {
    		close_schedule(room.dataset.roomId, button_open);
    	}, false);
    };
    function open_schedule(id, open_button) {
    	open_button.style.display = "none";
    	document.getElementById("room-" + id + "-reservations").style.display = "block";
    }
    function close_schedule(id, open_button) {
    	open_button.style.display = "block";
    	document.getElementById("room-" + id + "-reservations").style.display = "none";
    }
});
