const fs = require("fs");
const path = require("path");

const filePath = path.join("./", "package.json");
const fileCOntent = fs.readFileSync(filePath, "utf-8");

const config = JSON.parse(fileCOntent);

config.scripts.start = 'NODE_ENV="development" webpack --watch';
config.scripts.build = 'NODE_ENV="production" webpack build';
config.scripts.dev = "webpack-dev-server";

fs.writeFileSync(filePath, JSON.stringify(config));
