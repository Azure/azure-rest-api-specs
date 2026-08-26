import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

// Workaround for the JavaScript RLC emitter (@azure-tools/typespec-ts) generating
// a `NodeJS.ReadableStream` arm in the binary-body parameter union. The Azure SDK
// for JS browser tsconfig sets "types": [] (excludes @types/node by policy), so
// `NodeJS` is undefined in the browser target and the build fails with TS2503 in
// sdk/confidentialledger/codetransparency-rest/src/parameters.ts.
//
// Narrowing the JS-side type of `SignedStatement.body` to `string` avoids the
// Node-only type reference. The wire contract (application/cose bytes) is
// unchanged; other emitters (Python/C#/Java/autorest) ignore this override.
//
// TODO: Remove once the upstream emitter bug is fixed and rolled into the
// spec-gen-sdk pipeline. Tracking issue: https://github.com/Azure/autorest.typescript/issues/3990
@@alternateType(
  Microsoft.CodeTransparency.SignedStatement.body,
  string,
  "javascript"
);
