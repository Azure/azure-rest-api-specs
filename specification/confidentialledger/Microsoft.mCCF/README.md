Installation:

- For the generic TypeSpec API, follow the instructions here https://microsoft.github.io/typespec/introduction/installation to install and run the TypeSpec code
- For Azure Specific TypeSpec API, follow this guide: https://azure.github.io/typespec-azure/docs/getstarted/installation

Since we need to emit OpenAPI2, follow `npm install` instructions from both the above links (i.e. must install `@azure-tools/typespec-autorest`).

To build:

```
npm install
npx tsp compile . --emit @azure-tools/typespec-autorest
```
