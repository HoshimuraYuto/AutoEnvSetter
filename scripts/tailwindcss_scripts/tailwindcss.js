const fs = require("fs");
const path = require("path");

const filePath = path.join("./", "tailwind.config.js");
const fileCOntent = fs.readFileSync(filePath, "utf-8");

const config = eval(fileCOntent);

config.content = [`./src/**/*.{html,${process.argv[2]}}`];

fs.writeFileSync(filePath, "module.exports = " + JSON.stringify(config));
