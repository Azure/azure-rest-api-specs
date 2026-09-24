#!/usr/bin/env node

import process from "node:process";
import { mainGenerateSdk } from "../src/generate-sdk.ts";

try {
  await mainGenerateSdk();
} catch (error) {
  const message = error instanceof Error ? error.message : String(error);
  console.error(`release-plan generate-sdk tool failed: ${message}`);
  process.exit(1);
}
