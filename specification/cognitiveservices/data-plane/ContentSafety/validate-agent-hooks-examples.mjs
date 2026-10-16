import { createHash } from "node:crypto";
import { readFile, readdir } from "node:fs/promises";
import { basename, join } from "node:path";

const root = new URL(".", import.meta.url).pathname;
const sourceDirectory = join(root, "examples", "2026-10-15-preview");
const semanticDirectory = join(root, "semantic-examples", "2026-10-15-preview");
const generatedDirectory = join(root, "preview", "2026-10-15-preview", "examples");
const negativeExamples = new Map([
  ["UnifiedModerate_InvalidSelectorCombination.json", ["400", "InvalidRequest"]],
  ["UnifiedModerate_MissingSelectedPolicyRevision.json", ["400", "SelectedPolicyRevisionRequired"]],
  ["UnifiedModerate_NativeRouteDisabled.json", ["404", "NativeRouteDisabled"]],
  ["UnifiedModerate_PolicyFenceChanged.json", ["409", "PolicyFenceChanged"]],
  ["UnifiedModerate_PolicyLayerUnavailable.json", ["503", "PolicyLayerUnavailable"]],
  ["UnifiedModerate_SelectedPolicyRevisionMismatch.json", ["409", "SelectedPolicyRevisionMismatch"]],
  ["UnifiedModerate_UnknownPolicy.json", ["409", "SelectedPolicyRevisionUnavailable"]],
  ["UnifiedModerate_UnsupportedCapability.json", ["409", "UnsupportedCapability"]],
]);
const removedReceiptFields = [
  "appliedGeneration",
  "bindingEpoch",
  "capabilityVersion",
  "readinessEpoch",
  "supportedInterventionPoints",
];

function assert(condition, message) {
  if (!condition) throw new Error(message);
}

function validateUnicode(value) {
  for (let index = 0; index < value.length; index += 1) {
    const code = value.charCodeAt(index);
    if (code >= 0xd800 && code <= 0xdbff) {
      const next = value.charCodeAt(index + 1);
      assert(next >= 0xdc00 && next <= 0xdfff, "RFC 8785 rejects lone high surrogates");
      index += 1;
    } else {
      assert(code < 0xdc00 || code > 0xdfff, "RFC 8785 rejects lone low surrogates");
    }
  }
}

function canonicalize(value) {
  if (value === null || typeof value === "boolean") return JSON.stringify(value);
  if (typeof value === "number") {
    assert(Number.isFinite(value), "RFC 8785 supports only finite JSON numbers");
    return JSON.stringify(value);
  }
  if (typeof value === "string") {
    validateUnicode(value);
    return JSON.stringify(value);
  }
  if (Array.isArray(value)) return `[${value.map(canonicalize).join(",")}]`;
  assert(typeof value === "object", "Unsupported JSON value");
  return `{${Object.keys(value)
    .sort()
    .map((key) => {
      validateUnicode(key);
      return `${JSON.stringify(key)}:${canonicalize(value[key])}`;
    })
    .join(",")}}`;
}

function digest(material) {
  return `sha256:${createHash("sha256").update(canonicalize(material), "utf8").digest("hex")}`;
}

function bindingMaterial(parameters) {
  const selectors =
    parameters.policyId === undefined
      ? {
          targetResourceId: parameters.targetResourceId,
          selectedPolicyId: parameters.selectedPolicyId,
          selectedPolicyRevision: parameters.selectedPolicyRevision,
          selectedPolicySemanticDigest: parameters.selectedPolicySemanticDigest,
        }
      : { policyId: parameters.policyId };
  return {
    apiVersion: parameters["api-version"],
    context: parameters.body,
    selectors,
  };
}

function validatePositive(name, example) {
  const success = example.responses["200"];
  assert(success, `${name}: positive example must contain HTTP 200`);
  const receipt = success.body.receipt;
  assert(receipt, `${name}: missing receipt`);
  assert(
    receipt.requestBinding.digest === digest(bindingMaterial(example.parameters)),
    `${name}: request-binding digest mismatch`,
  );
  for (const field of removedReceiptFields) {
    assert(!(field in receipt), `${name}: obsolete receipt field ${field}`);
  }
  assert(receipt.evaluatedPolicyLayers.length > 0, `${name}: no evaluated policy layers`);
  for (const layer of receipt.evaluatedPolicyLayers) {
    assert(layer.activatedArtifactDigest, `${name}: layer lacks activatedArtifactDigest`);
    assert(!("manifestRegoDigest" in layer), `${name}: obsolete manifestRegoDigest`);
    assert(!["developer", "generated"].includes(layer.kind), `${name}: obsolete layer kind ${layer.kind}`);
  }
  if (receipt.profile === "foundryProject") {
    assert(example.parameters.targetResourceId, `${name}: Foundry profile lacks targetResourceId`);
    assert(example.parameters.selectedPolicyId, `${name}: Foundry profile lacks selectedPolicyId`);
    const selectedLayers = receipt.evaluatedPolicyLayers.filter((layer) => layer.kind === "selected");
    assert(selectedLayers.length === 1, `${name}: Foundry profile requires exactly one selected layer`);
    assert(
      selectedLayers[0].policyResourceId === example.parameters.selectedPolicyId,
      `${name}: selected layer resource differs from the admitted selector`,
    );
    assert(
      selectedLayers[0].policyRevision === example.parameters.selectedPolicyRevision,
      `${name}: selected layer revision differs from the admitted selector`,
    );
    assert(
      selectedLayers[0].policySemanticDigest === example.parameters.selectedPolicySemanticDigest,
      `${name}: selected layer semantic digest differs from the admitted selector`,
    );
    assert(
      /^[0-9a-f]{8}(?:-[0-9a-f]{4}){3}-[0-9a-f]{12}$/.test(receipt.targetIncarnation),
      `${name}: invalid RP project incarnation`,
    );
  } else {
    assert(receipt.profile === "namedPolicy", `${name}: unknown receipt profile`);
    assert(example.parameters.policyId, `${name}: named profile lacks policyId`);
    assert(!("targetResourceId" in receipt), `${name}: named profile contains project identity`);
  }
}

function validateNegative(name, example, expected) {
  assert(!("200" in example.responses), `${name}: negative example advertises HTTP 200`);
  assert(
    Object.keys(example.responses).length === 1,
    `${name}: semantic negative fixture must contain one response`,
  );
  const [status, code] = expected;
  assert(example.responses[status]?.body?.error?.code === code, `${name}: expected ${status}/${code}`);
}

// RFC 8785 examples exercise key ordering, Unicode escaping and ECMAScript number serialization.
assert(
  canonicalize({ literals: [null, true, false], string: "€$\u000f\nA'B\"\\\\\"/" }) ===
    '{"literals":[null,true,false],"string":"€$\\u000f\\nA\'B\\"\\\\\\\\\\"/"}',
  "RFC 8785 string vector failed",
);
assert(
  canonicalize({ numbers: [333333333.33333329, 1e30, 4.5, 0.002, 1e-27] }) ===
    '{"numbers":[333333333.3333333,1e+30,4.5,0.002,1e-27]}',
  "RFC 8785 number vector failed",
);

const files = (await readdir(sourceDirectory))
  .filter((name) => name.startsWith("UnifiedModerate") && name.endsWith(".json"))
  .sort();
for (const name of files) {
  const sourceText = await readFile(join(sourceDirectory, name), "utf8");
  const generatedText = await readFile(join(generatedDirectory, name), "utf8");
  assert(sourceText === generatedText, `${name}: generated example differs from source`);
  const example = JSON.parse(sourceText);
  assert(!negativeExamples.has(name), `${name}: semantic negative fixture must not be emitted`);
  validatePositive(name, example);
}

const semanticFiles = (await readdir(semanticDirectory)).filter((name) =>
  name.startsWith("UnifiedModerate") && name.endsWith(".json"),
);
assert(semanticFiles.length === negativeExamples.size, "Semantic fixture set is incomplete");
for (const [name, expected] of negativeExamples) {
  assert(semanticFiles.includes(name), `${name}: missing semantic fixture`);
  const example = JSON.parse(await readFile(join(semanticDirectory, name), "utf8"));
  validateNegative(name, example, expected);
}

console.log(
  `Validated ${files.length} emitted Unified Moderate examples and ${semanticFiles.length} semantic error fixtures.`,
);
