const fs = require("fs");
const path = require("path");

const filePath = path.join("./", "package.json");
const fileCOntent = fs.readFileSync(filePath, "utf-8");

const config = JSON.parse(fileCOntent);

config.scripts.test = `${process.argv[2]}`;

fs.writeFileSync(filePath, JSON.stringify(config));
