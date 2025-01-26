# Developer Documentation

## Pre-requisite

run this in the root of the azure-rest-api-specs/-pr directory
```bash
npm i
```
oav-generate
```bash
npm i -g oav
```
typespec compiler
```bash
npm install -g @typespec/compiler
```
## When contributing
When making changes to these specs please run this script before pushing changes to your remote branch. 
 ```bash
   ./openapi-script.sh
```

The script will:
1. re-compile the typespec files
2. generate examples
3. prettify the directory