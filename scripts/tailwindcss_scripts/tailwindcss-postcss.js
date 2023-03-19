const fs = require("fs");
const path = require("path");

const filePath = path.join("./", "postcss.config.js");
const fileCOntent = fs.readFileSync(filePath, "utf-8");

const config = eval(fileCOntent);

config.plugins.tailwindcss = {};

fs.writeFileSync(filePath, "module.exports = " + JSON.stringify(config));
