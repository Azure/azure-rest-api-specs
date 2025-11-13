#!/usr/bin/env node

// Modified version of tsmv that merges files from both old and new paths
import { mainWithMerge } from "../dist/src/index-merge.js";

await mainWithMerge();
