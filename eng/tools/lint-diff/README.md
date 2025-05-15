# TODO: REVERIFY THESE DOCS BEFORE MERGE
# LintDiff

LintDiff looks at files changed in a commit, runs `autorest` linting over those
files, and looks for "new" errors in the results. 

Altered files examined include `readme.md` files and swagger `.json` files. In
the case of `readme.md` files the tool will examine tags and other files that
could be impacted by the change (e.g. `readme.md` files in folders higher in the
directory structure).

## Run Locally

1. Setup `before` - Clone the specs repo at the *base commit* for the changes you want to test. (generally cloned to main and in a temp location like `/tmp/rest-api-specs-before`)
1. Setup `after` - Clone the specs repo at the commit for the changes you want to test.
1. Build a list of changed files from `after` generally by running `git diff --name-only <base> > changed-files.txt` 
1. From the root of the repo run `npm i` to install dependencies. 
1. Run `npm exec --no -- lint-diff --before <before> --after <after> --changed-files <changed-files.txt>`

### Example 

In most common cases, changes to LintDiff are in the current state of the repo and you'll need to set up a `before` to run against.

```bash
git clone https://github.com/Azure/azure-rest-api-specs.git /tmp/rest-api-specs-before
git diff --name-only main > changed-files.txt

npm i
npm exec --no -- lint-diff --before /tmp/rest-api-specs-before --after . --changed-files changed-files.txt
```
