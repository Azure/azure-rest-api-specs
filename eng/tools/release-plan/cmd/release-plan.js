#!/usr/bin/env node

const releasePlanModule = /** @type {typeof import("../src/index.ts")} */ (
  await import("../dist/src/index.js")
);

await releasePlanModule.main();
