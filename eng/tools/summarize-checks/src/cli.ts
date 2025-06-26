#!/usr/bin/env node

import { parseArgs, ParseArgsConfig } from "node:util";

export async function main() {
  const config: ParseArgsConfig = {
    options: {},
    allowPositionals: true,
  };

  const { values: opts, positionals } = parseArgs(config);
  // this option has a default value of process.cwd(), so we can assume it is always defined
  // just need to resolve that here to make ts aware of it

  console.log(opts)
  console.log(positionals)
  console.log("Hello from summarize-checks CLI!");
  process.exit()
}
