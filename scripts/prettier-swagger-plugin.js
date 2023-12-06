const plugins_estree = require("prettier/plugins/estree");
const plugins_babel = require("prettier/plugins/babel")

// Customize the standard json-stringify parser from https://github.com/prettier/prettier/blob/50404103ef7d96fb36f8cba1ac7bc40c671fd6cf/src/language-json/parser-json.js
const print = (path, options, print) => {
    const node = path.getValue();
    
    if (node.type === "NumericLiteral") {
        // Keep numeric literal as-is to allow values to have more then one trailing digit after the decimal like 100.00
        return node.extra.raw;
    }

    return plugins_estree.printers['estree-json'].print(path, options, print);
};

exports.languages = [
    {
        name: 'json-swagger',
        extensions: ['.json'],
        parsers: ['json-swagger']
    }
];
exports.parsers = {
    'json-swagger': {
        ...plugins_babel.parsers['json-stringify'],
        astFormat: 'estree-swagger-customized'
    }
};
exports.printers = {
    'estree-swagger-customized': {
        print
    }
};
