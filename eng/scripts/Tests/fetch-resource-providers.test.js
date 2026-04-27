#!/usr/bin/env node
// Tests for fetch-resource-providers.js

const path = require("path");
const {
  findRepoRoot,
  findResourceProviders,
  formatOutput,
} = require("../fetch-resource-providers.js");

function assert(condition, message) {
  if (!condition) throw new Error(`Test failed: ${message}`);
}

function testFindRepoRoot() {
  const repoRoot = findRepoRoot();
  assert(
    repoRoot.endsWith("azure-rest-api-specs"),
    "Repo root should end with azure-rest-api-specs",
  );
  assert(
    require("fs").existsSync(path.join(repoRoot, "specification")),
    "Specification directory should exist",
  );
  console.log("✓ findRepoRoot test passed");
}

function testFindResourceProvidersWithout() {
  const repoRoot = findRepoRoot();
  const rps = findResourceProviders(repoRoot, false);
  assert(
    rps.length > 0,
    "Should find resource providers without service names",
  );
  assert(
    rps.every((rp) => rp.rpNamespace && rp.orgName && rp.path),
    "All RPs should have rpNamespace, orgName, and path",
  );
  assert(
    rps.every((rp) => !rp.serviceNames),
    "RPs without service names should not have serviceNames field",
  );
  assert(
    rps.some((rp) => rp.rpNamespace === "Microsoft.Storage"),
    "Should include Microsoft.Storage",
  );
  assert(
    !rps.some((rp) => rp.rpNamespace === "Microsoft.Compute"),
    "Should not include Microsoft.Compute (has service names)",
  );
  console.log(
    `✓ findResourceProviders (without) test passed - found ${rps.length} RPs`,
  );
}

function testFindResourceProvidersWith() {
  const repoRoot = findRepoRoot();
  const rps = findResourceProviders(repoRoot, true);
  assert(rps.length > 0, "Should find resource providers with service names");
  assert(
    rps.every(
      (rp) => rp.rpNamespace && rp.orgName && rp.path && rp.serviceNames,
    ),
    "All RPs should have rpNamespace, orgName, path, and serviceNames",
  );
  assert(
    rps.every((rp) => Array.isArray(rp.serviceNames)),
    "serviceNames should be an array",
  );
  const compute = rps.find((rp) => rp.rpNamespace === "Microsoft.Compute");
  assert(compute, "Should include Microsoft.Compute");
  assert(
    compute.orgName === "compute",
    'Microsoft.Compute orgName should be "compute"',
  );
  assert(
    compute.serviceNames.includes("Compute"),
    "Microsoft.Compute should have Compute service name",
  );
  assert(
    !rps.some((rp) => rp.rpNamespace === "Microsoft.Storage"),
    "Should not include Microsoft.Storage (no service names)",
  );
  console.log(
    `✓ findResourceProviders (with) test passed - found ${rps.length} RPs`,
  );
}

function testFormatOutputList() {
  const rps = [
    { rpNamespace: "Microsoft.Test", orgName: "test", path: "test/path" },
    {
      rpNamespace: "Microsoft.Test2",
      orgName: "test2",
      path: "test2/path",
      serviceNames: ["Group1", "Group2"],
    },
  ];

  const outputWithout = formatOutput([rps[0]], "list", false);
  assert(
    outputWithout.includes("test, Microsoft.Test"),
    "List format should include orgName and rpNamespace",
  );

  const outputWith = formatOutput([rps[1]], "list", true);
  assert(
    outputWith.includes("test2, Microsoft.Test2, [Group1, Group2]"),
    "List format with serviceNames should include orgName, rpNamespace, and serviceNames",
  );

  console.log("✓ formatOutput (list) test passed");
}

function testFormatOutputJson() {
  const rps = [
    { rpNamespace: "Microsoft.Test", orgName: "test", path: "test/path" },
  ];
  const output = formatOutput(rps, "json", false);
  const parsed = JSON.parse(output);
  assert(Array.isArray(parsed), "JSON output should be an array");
  assert(
    parsed[0].rpNamespace === "Microsoft.Test",
    "JSON should preserve RP namespace",
  );
  console.log("✓ formatOutput (json) test passed");
}

function testFormatOutputTable() {
  const rps = [
    { rpNamespace: "Microsoft.Test", orgName: "test", path: "test/path" },
  ];
  const output = formatOutput(rps, "table", false);
  assert(output.includes("orgName"), "Table should have orgName header");
  assert(
    output.includes("rpNamespace"),
    "Table should have rpNamespace header",
  );
  assert(output.includes("test"), "Table should include org name");
  assert(
    output.includes("Microsoft.Test"),
    "Table should include RP namespace",
  );
  console.log("✓ formatOutput (table) test passed");
}

function runTests() {
  console.log("Running tests for fetch-resource-providers.js...\n");

  try {
    testFindRepoRoot();
    testFindResourceProvidersWithout();
    testFindResourceProvidersWith();
    testFormatOutputList();
    testFormatOutputJson();
    testFormatOutputTable();

    console.log("\n✅ All tests passed!");
    return 0;
  } catch (error) {
    console.error(`\n❌ ${error.message}`);
    console.error(error.stack);
    return 1;
  }
}

if (require.main === module) {
  process.exit(runTests());
}
