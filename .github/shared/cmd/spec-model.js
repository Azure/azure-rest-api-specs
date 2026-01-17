#!/usr/bin/env node

import { flatMapAsync } from "../src/array.js";
import { debugLogger } from "../src/logger.js";
import { SpecModel } from "../src/spec-model.js";
import { withTiming } from "../src/timing.js";

const USAGE =
  "Usage: npx spec-model path/to/spec [--debug] [--include-operations] [--include-refs] [--relative-paths] [--no-embed-errors]\n" +
  "Examples:\n" +
  "  npx spec-model specification/widget\n" +
  "  npx spec-model specification --include-operations --include-refs > out.txt; grep out.txt '\"error\":'";

// Exclude first two args (node, script file)
let args = process.argv.slice(2);

const debug = args.includes("--debug");
args = args.filter((a) => a != "--debug");

const includeOperations = args.includes("--include-operations");
args = args.filter((a) => a != "--include-operations");

const includeRefs = args.includes("--include-refs");
args = args.filter((a) => a != "--include-refs");

const relativePaths = args.includes("--relative-paths");
args = args.filter((a) => a != "--relative-paths");

const noEmbedErrors = args.includes("--no-embed-errors");
args = args.filter((a) => a != "--no-embed-errors");

if (args.length < 1) {
  console.error(USAGE);
  process.exit(1);
}

if (args.length > 1) {
  console.error("ERROR: Too many arguments\n");
  console.error(USAGE);
  process.exit(1);
}

const specPath = args[0];

// Default to 'undefined' instead of 'defaultLogger', so output is always a valid JSON object (no logging)
const logger = debug ? debugLogger : undefined;

const specModel = await withTiming(`new SpecModel()`, () => new SpecModel(specPath, { logger }));

console.log();

const readmes = await withTiming("getReadmes()", async () => await specModel.getReadmes());
console.log(`readmes: ${readmes.size}\n`);

const tags = await withTiming(
  "getTags()",
  async () =>
    await flatMapAsync([...readmes.values()], async (r) => [...(await r.getTags()).values()]),
);
console.log(`tags: ${tags.length}\n`);

const swaggers = await withTiming("getSwaggers()", () =>
  tags.flatMap((t) => [...t.inputFiles.values()]),
);
console.log(`swaggers: ${swaggers.length}\n`);

const swagger = swaggers[0];
console.log(`swagger: ${swagger.path}\n`);

// const refs = await withTiming("getRefs()", async () => await swagger.getRefs());
// console.log(`swaggers: ${refs.size}\n`);

// const operations = await withTiming("getOperations()", async () => await swagger.getOperations());
// console.log(`operations: ${operations.size}\n`);

// const affectedReadmeTags = await withTiming(
//   "getAffectedReadmeTags()",
//   async () => await specModel.getAffectedReadmeTags(swagger.path),
// );
// console.log(`affectedReadmeTags: ${inspect(affectedReadmeTags)}\n`);

// const affectedReadmeTags2 = await withTiming(
//   "getAffectedReadmeTags()",
//   async () => await specModel.getAffectedReadmeTags(swaggers[1].path),
// );
// console.log(`affectedReadmeTags2: ${affectedReadmeTags2.size}\n`);

for (let i = 0; i < 10; i++) {
  const affectedSwaggers = await withTiming(
    "getAffectedSwaggers()",
    async () => await specModel.getAffectedSwaggers(swaggers[i].path),
  );
  console.log(`affectedSwaggers: ${affectedSwaggers.size}\n`);
}

// console.log(
//   JSON.stringify(
//     await specModel.toJSONAsync({
//       embedErrors: !noEmbedErrors,
//       includeOperations,
//       includeRefs,
//       relativePaths,
//     }),
//     null,
//     2,
//   ),
// );
