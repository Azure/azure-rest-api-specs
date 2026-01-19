# LintDiff

LintDiff looks at files changed in a commit, runs `autorest` linting over those
files, and looks for "new" errors in the results.

Interesting changed files are swagger `.json` files and `readme.md` files.
Changes to swagger JSON files are mapped to `readme.md` files and tags which
include the swagger file. The entire tree of swagger dependencies is traversed
so changes to a file will result in scanning of readme.md and swagger files
which depend on the changed file.

## Correlation

LintDiff attempts to correlate errors found to files with the same base name
and JSON path to the error site. Array position matters, so if an object's
position in an array changes, the error will not correlate and may be reported.

## Prerequisites

- Node.JS 20 or later

## Run Locally

1. Setup `before` folder state - Clone the specs repo at the _base commit_ for the changes you want to test. (generally cloned to main and in a temp location like `/tmp/rest-api-specs-before`)
1. Setup `after` folder state - Clone the specs repo at the commit for the changes you want to test in a different folder.
1. Build a list of changed files from `after` generally by running `git diff --name-only <base> > changed-files.txt` in the `after` folder.
1. From the root of the repo run `npm ci` to install dependencies.
1. Run `npm exec --no -- lint-diff --before <before-path> --after <after-path> --changed-files <changed-files.txt>`

### Example

In most common cases, changes to LintDiff are in the current state of the repo and you'll need to set up a `before` to run against.

At the root of the repo with changes you want to test, run the following commands:

```bash
# Clone the specs repo into a temporary location at the base commit
git clone https://github.com/Azure/azure-rest-api-specs.git /tmp/rest-api-specs-before

# Diff the current repo (after state) against the base commit
git diff --name-only main > changed-files.txt

npm ci
npm exec --no -- lint-diff --before /tmp/rest-api-specs-before --after . --changed-files changed-files.txt
```

## Output

Output is written by default to `lint-diff.md` in the current working
directory. The file contains a table of errors. LintDiff itself also
formats error output to the console.
