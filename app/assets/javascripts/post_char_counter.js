
// update the counter div element with the right integer.
function updateCounter(counter_div, count) {
	counter_div.innerHTML = 140 - count;
	if ((140 - count) <= 0) {
		counter_div.parentElement.style.color = "red";
		counter_div.style.color = "red";
	}	else {
		counter_div.parentElement.style.color = "";
		counter_div.style.color = "";
	}
}


function getLength(box) {
	return box.value.length;  // Return the length of the string in the box.
}


window.onload = function () {

	var inputBox = document.getElementById("micropost_content"); //This is the post content.
	var counterDiv = document.getElementById('char-counter'); //This div is where the number of chars left goes.
	
	var initialCount = getLength(inputBox); //get the initial count, in case there's a default value.
	updateCounter(counterDiv,initialCount); //set the counter to the correct initial value.

	// When we click in the box, start counting keypresses.
	inputBox.onfocus = function() {
		// When a key is released, count the chars.
		inputBox.onkeyup = function() {
			var stringLength = getLength(inputBox);
			console.log(stringLength);
			updateCounter(counterDiv, stringLength); //Update the counter div with the current count.
		};

	};

};




