#!/usr/bin/env node

import { Command } from "commander";
import * as cm from "../dist/src/index.js";

const program = new Command();

program
  .name("apiview-automation-client")
  .description("Client for firing off APIView automation")
  .version("1.0.0");

program
  .command("api_change_comment")
  .description("Add API change check comment to a pull request")
  .argument("<headCommitSh>", "Head commit SHA of the pull request")
  .option("-v, --verbose", "Enable verbose output")
  .action((path, options) => {
    cm.api_change_comment(path, options);
  });

program.parse(process.argv);