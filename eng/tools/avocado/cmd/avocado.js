#!/usr/bin/env node

import yargs from 'yargs'
import { run } from '../dist/cli.js'
import { avocado, UnifiedPipelineReport } from '../dist/index.js'

var argv = yargs
  .usage('Usage: avocado [options]')
  .alias('f', 'file')
  .describe('f', 'output detail result to log file')
  .alias('d', 'dir')
  .describe('d', 'run avocado under directory')
  .option('excludePaths', {
    type: 'array',
    desc: 'array contains path patterns to be ignored',
  })
  .option('includePaths', {
    type: 'array',
    desc: 'array contains path patterns to be included. If this option is not set, all files will be included. If this option is set, only files that match at least one pattern will be included',
  })
  .help('h')
  .alias('h', 'help').argv

run(avocado, UnifiedPipelineReport(argv.f), {
  cwd: process.cwd(),
  env: process.env,
  args: { dir: argv.d, excludePaths: argv.excludePaths, includePaths: argv.includePaths },
})
