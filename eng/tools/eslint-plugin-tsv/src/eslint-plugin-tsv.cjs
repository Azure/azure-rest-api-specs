// TODO: Convert to TS

const enforceFooBar = require("./enforce-foo-bar.cjs");
const plugin = { rules: { "enforce-foo-bar": enforceFooBar } };
module.exports = plugin;
