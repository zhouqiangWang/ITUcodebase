
const alphabet = "ABCDEFGHIKLMNOPQRSTVUWXYZ";

class Playfair {
	constructor() {
		this.keyTable = new Array(25);
	}
	createKeyTable(key) {
		let flags = new Array(26);
		flags.fill(0);
		key = key.toLocaleUpperCase();
		key = key.replace("J", "I");

		const aN = "A".charCodeAt(0);
		let keyLen = key.length;
		let initialKey = "";

		let dict = new Map();
		let keyI = 0;
		for (let i = 0; i < keyLen; i++) {
			let index = key.charCodeAt(i) - aN;
			let ch = key.charAt(i);
			if (!flags[index]) {
				flags[index] = 1;
				initialKey += ch;
				dict.set(ch, keyI);
				this.keyTable[keyI++] = ch;
			}
		}
		console.log("\nThe processed Secret Key : " + initialKey);

		// console.log(flags);
		for (let i = 0; i < 25; i++) {
			let index = alphabet.charCodeAt(i) - aN;
			let ch = alphabet.charAt(i);
			if (!flags[index]) {
				dict.set(ch, keyI);
				this.keyTable[keyI++] = ch;
			}
		}

		// console.log(dict);
		console.log("\nThe 5x5 table is:");
		console.log("-----");
		let row = "";
		for (let i = 0; i < 25; i++) {
			row += this.keyTable[i];
			if (i%5 === 4) {
				console.log(row);
				row = "";
			}
		}
		console.log("-----");

		return dict;
	}

	encrypt(key, plainText) {
		console.log("Input secret key : " + key);
		console.log("Input plain text : " + plainText);
		let dict = this.createKeyTable(key);
		// console.log("keyTable : " + this.keyTable);

		let text = plainText.toLocaleUpperCase().replace(/\s+/g, "");
		if (text.length % 2 !== 0) {
			console.log("the plain text must have even letters!");
			return;
		}
		console.log("Plain  Text : " + text);
		text = text.replace("J", "I");
		let cryptText = "";
		for (let i = 0; i < text.length; i+=2) {
			let index1 = dict.get(text.charAt(i));
			let index2 = dict.get(text.charAt(i+1));
			// console.log(index1 + ", " + index2);
			let row1 = Math.floor(index1 / 5);
			let col1 = index1 % 5;
			let row2 = Math.floor(index2 / 5);
			let col2 = index2 % 5;
			let ch1, ch2;
			// console.log("row1 = " + row1 + ", col1 = " + col1 + ", row2 = " + row2 + ", col2 = " + col2);
			// same row
			if (row1 === row2) {
				ch1 = this.keyTable[row1*5 + (col1+1)%5];
				ch2 = this.keyTable[row2*5 + (col2+1)%5];
			} else if (col1 === col2) { // same column
				ch1 = this.keyTable[(row1+1)%5*5 + col1];
				ch2 = this.keyTable[(row2+1)%5*5 + col2];
			} else { // opposite corners
				ch1 = this.keyTable[row1*5 + col2];
				ch2 = this.keyTable[row2*5 + col1];
			}
			cryptText = cryptText + ch1 + ch2;
		}
		console.log("Encryt Text : " + cryptText);

		return cryptText;
	}

	decrypt(key, cipherText) {
		let dict = this.createKeyTable(key);

		let plainText = "";
		for (let i = 0; i < cipherText.length; i+=2) {
			let index1 = dict.get(cipherText.charAt(i));
			let index2 = dict.get(cipherText.charAt(i+1));
			// console.log(index1 + ", " + index2);
			let row1 = Math.floor(index1 / 5);
			let col1 = index1 % 5;
			let row2 = Math.floor(index2 / 5);
			let col2 = index2 % 5;
			let ch1, ch2;
			// console.log("row1 = " + row1 + ", col1 = " + col1 + ", row2 = " + row2 + ", col2 = " + col2);
			// same row
			if (row1 === row2) {
				ch1 = this.keyTable[row1*5 + (col1+4)%5];
				ch2 = this.keyTable[row2*5 + (col2+4)%5];
			} else if (col1 === col2) { // same column
				ch1 = this.keyTable[(row1+4)%5*5 + col1];
				ch2 = this.keyTable[(row2+4)%5*5 + col2];
			} else { // opposite corners
				ch1 = this.keyTable[row1*5 + col2];
				ch2 = this.keyTable[row2*5 + col1];
			}
			plainText = plainText + ch1 + ch2;
		}
		plainText = plainText.replace("I", "(I/J)");
		console.log("Plain Text : " + plainText);

		return plainText;
	}
}

// test case
let testKey = "zhouqii";
let text = "Internati onals";

let agent = new Playfair();
let cryptText = agent.encrypt(testKey, text);

let plainText = agent.decrypt(testKey, cryptText);


