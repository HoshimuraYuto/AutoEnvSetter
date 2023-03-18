const fs = require("fs");
const path = require("path");

const filePath = path.join("./", "tsconfig.json");
const fileCOntent = fs.readFileSync(filePath, "utf-8");

const config = JSON.parse(fileCOntent.replace(/\/\*[\s\S]*?\*\/|\/\/.*/g, ""));

config.compilerOptions.lib = ["dom", "dom.iterable", "esnext"];
config.compilerOptions.jsx = "react";
config.include = ["src"];

fs.writeFileSync(filePath, JSON.stringify(config));
