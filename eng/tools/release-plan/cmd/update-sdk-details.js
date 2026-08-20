#!/usr/bin/env node

import process from "node:process";
import { mainUpdateSdkDetails } from "../src/update-sdk-details.ts";

try {
  mainUpdateSdkDetails();
} catch (error) {
  const message = error instanceof Error ? error.message : String(error);
  console.error(`release-plan update-sdk-details tool failed: ${message}`);
  process.exit(1);
}
