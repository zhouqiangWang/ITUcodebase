for (var i = 0; i < 27; i++) {
	if (13*i % 27 === 1) {
		console.log(i);
	}
}

console.log(25*5 % 27);
console.log(-2*25 % 27 + 27);
console.log(25*3 % 27);
let str = "ZHOU";

const aN = "A".charCodeAt(0);

console.log("index");
for (let i = 0; i < str.length ; i++) {
	console.log(str.charCodeAt(i) - aN);
}