const fs = require("fs");

console.log('test sdk-suppressions-label.js is working 2');

const result = { removeLabel: "remove-label", addLabel: "add-label" };

fs.writeFileSync("output.json", JSON.stringify(result));
console.log("JSON output saved to output.json");

console.log("Ending log");

