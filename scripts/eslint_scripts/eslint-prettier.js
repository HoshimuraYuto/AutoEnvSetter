const fs = require("fs");
const path = require("path");

const filePath = path.join("./", ".eslintrc.js");
const fileCOntent = fs.readFileSync(filePath, "utf-8");

const config = eval(fileCOntent);

config.extends.push("plugin:prettier/recommended");

fs.writeFileSync(filePath, "module.exports = " + JSON.stringify(config));
