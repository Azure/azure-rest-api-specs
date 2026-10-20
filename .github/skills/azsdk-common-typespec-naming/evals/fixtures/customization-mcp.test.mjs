import assert from "node:assert/strict";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { spawnSync } from "node:child_process";
import { fileURLToPath } from "node:url";
import { test } from "node:test";
import { handleRequest } from "./customization-mcp.mjs";
import { handleRequest as handleGenericRequest } from "./generic-customization-mcp.mjs";

/** @param {string} typeSpecProjectRootPath */
const validationCall = (typeSpecProjectRootPath) => ({
  jsonrpc: "2.0",
  id: 3,
  method: "tools/call",
  params: {
    name: "azsdk_run_typespec_validation",
    arguments: { typeSpecProjectRootPath },
  },
});

/** @param {unknown} request */
function callTool(request) {
  const response = handleRequest(request);
  assert.ok(response && "result" in response);
  const result = response.result;
  assert.ok("content" in result);
  return {
    content: result.content,
    isError: "isError" in result ? result.isError : undefined,
  };
}

await test("fixture exposes customization as a trap and validation with production arguments", () => {
  const response = handleRequest({ id: 1, method: "tools/list" });
  assert.ok(response && "result" in response && "tools" in response.result);
  const result = response.result;
  assert.deepEqual(
    result.tools.map((tool) => tool.name),
    ["azsdk_customized_code_update", "azsdk_run_typespec_validation"],
  );
  assert.deepEqual(result.tools[1].inputSchema.required, [
    "typeSpecProjectRootPath",
  ]);
});

await test("customization calls fail explicitly instead of pretending to edit", () => {
  const result = callTool({
    id: 2,
    method: "tools/call",
    params: {
      name: "azsdk_customized_code_update",
      arguments: {
        editScope: "SpecInputs",
        tspProjectPath: "/fixtures/Widget",
      },
    },
  });
  assert.equal(result.isError, true);
  assert.match(result.content[0].text, /Unexpected customization call/);
});

await test("validation requires a project root", () => {
  assert.equal(callTool(validationCall("")).isError, true);
});

await test("validation requires an applied override and entrypoint loading", (t) => {
  const root = fs.mkdtempSync(path.join(os.tmpdir(), "naming-fixture-"));
  t.after(() => fs.rmSync(root, { recursive: true }));
  const validate = () => callTool(validationCall(root));
  assert.equal(validate().isError, true);
  fs.writeFileSync(path.join(root, "main.tsp"), "namespace Widget;");
  fs.writeFileSync(
    path.join(root, "client.tsp"),
    '@@clientName(Widget.WidgetProperties.enabled, "IsEnabled", "csharp");',
  );
  assert.equal(validate().isError, true);
  fs.writeFileSync(
    path.join(root, "main.tsp"),
    'import "./client.tsp";\nnamespace Widget;',
  );
  /** @type {unknown} */
  const result = JSON.parse(validate().content[0].text);
  assert.ok(result !== null && typeof result === "object");
  assert.ok("Success" in result && "Message" in result);
  assert.equal(result.Success, true);
  assert.ok(typeof result.Message === "string");
  assert.match(result.Message, /compile command next/);
  fs.writeFileSync(
    path.join(root, "client.tsp"),
    '@@clientName(Widget.WidgetProperties.enabled, "IsEnabled", "java");',
  );
  assert.equal(validate().isError, true);
});

await test("unknown tools and methods fail explicitly; notifications need no response", () => {
  assert.equal(handleRequest({ method: "notifications/initialized" }), null);
  const missingMethod = handleRequest({ id: 1, method: "missing" });
  assert.ok(missingMethod && "error" in missingMethod);
  assert.equal(missingMethod.error.code, -32601);
  const request = validationCall("");
  request.params.name = "missing";
  const missingTool = handleRequest(request);
  assert.ok(missingTool && "error" in missingTool);
  assert.equal(missingTool.error.code, -32602);
});

await test("stdio handshake advertises tools without dependencies or file writes", () => {
  const messages = [
    {
      id: 0,
      method: "initialize",
      params: { protocolVersion: "2024-11-05" },
    },
    { method: "notifications/initialized" },
    { id: 1, method: "tools/list" },
    validationCall(""),
  ];
  const result = spawnSync(
    process.execPath,
    [fileURLToPath(new URL("./customization-mcp.mjs", import.meta.url))],
    {
      input:
        messages.map((message) => JSON.stringify(message)).join("\n") + "\n",
      encoding: "utf8",
    },
  );
  assert.equal(result.status, 0, result.stderr);
  const responses = result.stdout
    .trim()
    .split("\n")
    .map((line) => {
      /** @type {unknown} */
      const response = JSON.parse(line);
      assert.ok(response !== null && typeof response === "object");
      assert.ok("result" in response);
      assert.ok(
        response.result !== null && typeof response.result === "object",
      );
      return response.result;
    });
  assert.equal(responses.length, 3);
  assert.ok("protocolVersion" in responses[0]);
  assert.equal(responses[0].protocolVersion, "2024-11-05");
  assert.ok("tools" in responses[1] && Array.isArray(responses[1].tools));
  assert.equal(responses[1].tools.length, 2);
  assert.ok("isError" in responses[2]);
  assert.equal(responses[2].isError, true);
});

await test("fixtures reject malformed requests and argument types explicitly", () => {
  for (const handle of [handleRequest, handleGenericRequest]) {
    for (const input of [null, [], "request"]) {
      assert.throws(() => handle(input), /Fixture request must be an object/);
    }
    const response = handle({ id: 1, method: "tools/call" });
    assert.ok(response && "error" in response);
    assert.equal(response.error.code, -32602);
    const initialization = handle({ id: 1, method: "initialize" });
    assert.ok(initialization && "error" in initialization);
    assert.equal(initialization.error.code, -32602);
  }
  const request = {
    id: 1,
    method: "tools/call",
    params: {
      name: "azsdk_run_typespec_validation",
      arguments: { typeSpecProjectRootPath: 42 },
    },
  };
  assert.equal(callTool(request).isError, true);
});

await test("generic fixture preserves SDK customization routing", () => {
  const request = {
    id: 1,
    method: "tools/call",
    params: {
      name: "azsdk_customized_code_update",
      arguments: {
        customizationRequest: "Update the SDK retry policy",
        packagePath: "/fixtures/sdk",
        editScope: "CustomCode",
      },
    },
  };
  const success = handleGenericRequest(request);
  assert.ok(success && "result" in success && "content" in success.result);
  assert.match(success.result.content[0].text, /"Success":true/);
  for (const args of [
    { ...request.params.arguments, customizationRequest: 42 },
    { ...request.params.arguments, packagePath: 42 },
    { ...request.params.arguments, editScope: "SpecInputs" },
  ]) {
    const response = handleGenericRequest({
      ...request,
      params: { ...request.params, arguments: args },
    });
    assert.ok(response && "result" in response && "isError" in response.result);
    assert.equal(response.result.isError, true);
  }
});
