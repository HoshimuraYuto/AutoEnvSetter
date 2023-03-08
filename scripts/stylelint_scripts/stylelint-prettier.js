const fs = require("fs");
const path = require("path");

const filePath = path.join("./", ".stylelintrc.js");
const fileCOntent = fs.readFileSync(filePath, "utf-8");

const config = eval(fileCOntent);

config.plugins.push("stylelint-prettier");
config.extends.push("plugin:prettier/recommended");
config.extends.push("stylelint-config-prettier");

fs.writeFileSync(filePath, "module.exports = " + JSON.stringify(config));
