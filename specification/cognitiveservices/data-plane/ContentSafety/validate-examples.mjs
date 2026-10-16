import { createHash } from "node:crypto";
import { readFile, readdir } from "node:fs/promises";
import { join } from "node:path";
import { fileURLToPath } from "node:url";

const root = fileURLToPath(new URL(".", import.meta.url));
const sourceDirectory = join(root, "examples", "2026-10-15-preview");
const generatedDirectory = join(root, "preview", "2026-10-15-preview", "examples");
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

function assertThrows(action, message) {
  try {
    action();
  } catch {
    return;
  }
  throw new Error(message);
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

function validateContext(name, context) {
  const point = context.interception_point;
  const expected = {
    agent_startup: context.agent_init,
    input: context.input,
    pre_model_call: context.messages,
    post_model_call: context.response,
    pre_tool_call: context.tool_call?.args,
    post_tool_call: context.tool_result?.value,
    output: context.output,
    agent_shutdown: context.summary,
  }[point];
  assert(expected !== undefined, `${name}: missing point-specific payload for ${point}`);
  assert(
    canonicalize(context.target) === canonicalize(expected),
    `${name}: target does not equal the ${point} payload`,
  );
  if (point === "agent_startup") {
    assert(
      Array.isArray(context.agent_init.tools_registered) &&
        context.agent_init.tools_registered.every((value) => typeof value === "string"),
      `${name}: invalid agent_startup payload`,
    );
  }
  if (point === "pre_model_call") {
    assert(context.model && Array.isArray(context.messages), `${name}: invalid pre_model_call payload`);
  }
  if (point === "post_model_call") {
    assert(context.model && context.response, `${name}: invalid post_model_call payload`);
  }
  if (point === "pre_tool_call") {
    assert(context.tool_call?.args, `${name}: invalid pre_tool_call payload`);
  }
  if (point === "post_tool_call") {
    assert(context.tool_call && "value" in context.tool_result, `${name}: invalid post_tool_call payload`);
  }
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
  validateContext(name, example.parameters.body);
  assert(
    receipt.evaluatedInterventionPoint === example.parameters.body.interception_point,
    `${name}: receipt intervention point differs from the request`,
  );
  assert(
    receipt.requiredInterventionPoints.includes(example.parameters.body.interception_point),
    `${name}: receipt does not require the evaluated intervention point`,
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
  const verdict = success.body.verdict;
  if (verdict.decision === "transform") {
    assert(verdict.transform, `${name}: transform verdict lacks transform metadata`);
    assert(
      /^\$(target|policy_target)(\.|\[|$)/.test(verdict.transform.path),
      `${name}: invalid transform path`,
    );
    assert(
      !["agent_startup", "agent_shutdown"].includes(example.parameters.body.interception_point),
      `${name}: transform is forbidden at startup/shutdown`,
    );
  } else {
    assert(!("transform" in verdict), `${name}: non-transform verdict contains transform metadata`);
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

function clone(value) {
  return structuredClone(value);
}

function validateSemanticCase(test) {
  const { parameters, setup = {} } = test;
  switch (test.code) {
    case "InvalidRequest":
      assert(
        parameters.policyId &&
          (parameters.targetResourceId || parameters.selectedPolicyId),
        `${test.name}: mixed-selector conflict is absent`,
      );
      break;
    case "SelectedPolicyRevisionRequired":
      assert(
        parameters.selectedPolicyId &&
          (!parameters.selectedPolicyRevision || !parameters.selectedPolicySemanticDigest),
        `${test.name}: selected-policy tuple is complete`,
      );
      break;
    case "NativeRouteDisabled":
      assert(setup.nativeRouteEnabled === false, `${test.name}: route is not disabled`);
      break;
    case "PolicyFenceChanged":
      assert(
        canonicalize(setup.before) !== canonicalize(setup.after),
        `${test.name}: policy fence did not change`,
      );
      break;
    case "PolicyLayerUnavailable":
      assert(setup.requiredPolicyAvailable === false, `${test.name}: required policy is available`);
      break;
    case "SelectedPolicyRevisionMismatch":
      assert(
        setup.resolvedPolicy &&
          (setup.resolvedPolicy.revision !== parameters.selectedPolicyRevision ||
            setup.resolvedPolicy.semanticDigest !== parameters.selectedPolicySemanticDigest),
        `${test.name}: selected tuple matches the resolved policy`,
      );
      break;
    case "SelectedPolicyRevisionUnavailable":
      assert(setup.resolvedPolicy === null, `${test.name}: selected revision is available`);
      break;
    case "UnsupportedCapability":
      assert(
        setup.requiredPoints.some((point) => !setup.supportedPoints.includes(point)),
        `${test.name}: host supports every required point`,
      );
      break;
    default:
      throw new Error(`${test.name}: unknown semantic error code`);
  }
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
  validatePositive(name, example);
}

const base = JSON.parse(await readFile(join(sourceDirectory, "UnifiedModerate.json"), "utf8"));
const semanticCases = [
  {
    name: "mixed selector profiles",
    status: 400,
    code: "InvalidRequest",
    parameters: { ...clone(base.parameters), policyId: "named-policy" },
  },
  {
    name: "incomplete selected-policy tuple",
    status: 400,
    code: "SelectedPolicyRevisionRequired",
    parameters: { ...clone(base.parameters), selectedPolicyRevision: undefined },
  },
  {
    name: "disabled native route",
    status: 404,
    code: "NativeRouteDisabled",
    parameters: clone(base.parameters),
    setup: { nativeRouteEnabled: false },
  },
  {
    name: "changed project or hierarchy",
    status: 409,
    code: "PolicyFenceChanged",
    parameters: clone(base.parameters),
    setup: { before: { incarnation: "a", layers: ["selected"] }, after: { incarnation: "b", layers: ["selected"] } },
  },
  {
    name: "unavailable administrator policy",
    status: 503,
    code: "PolicyLayerUnavailable",
    parameters: clone(base.parameters),
    setup: { requiredPolicyAvailable: false },
  },
  {
    name: "selected revision mismatch",
    status: 409,
    code: "SelectedPolicyRevisionMismatch",
    parameters: clone(base.parameters),
    setup: {
      resolvedPolicy: {
        revision: "different-etag",
        semanticDigest: base.parameters.selectedPolicySemanticDigest,
      },
    },
  },
  {
    name: "selected revision unavailable",
    status: 409,
    code: "SelectedPolicyRevisionUnavailable",
    parameters: clone(base.parameters),
    setup: { resolvedPolicy: null },
  },
  {
    name: "unsupported mandatory point",
    status: 409,
    code: "UnsupportedCapability",
    parameters: clone(base.parameters),
    setup: { requiredPoints: ["pre_tool_call"], supportedPoints: ["input", "output"] },
  },
];
for (const test of semanticCases) {
  assert(Number.isInteger(test.status), `${test.name}: invalid HTTP status`);
  validateSemanticCase(test);
}

const wrongReceiptPoint = clone(base);
wrongReceiptPoint.responses["200"].body.receipt.evaluatedInterventionPoint = "output";
assertThrows(
  () => validatePositive("mutated receipt point", wrongReceiptPoint),
  "Verifier accepted a receipt for a different intervention point",
);

const missingPointPayload = clone(base);
missingPointPayload.parameters.body.interception_point = "pre_tool_call";
missingPointPayload.parameters.body.target = {};
missingPointPayload.responses["200"].body.receipt.evaluatedInterventionPoint = "pre_tool_call";
missingPointPayload.responses["200"].body.receipt.requiredInterventionPoints = ["pre_tool_call"];
missingPointPayload.responses["200"].body.receipt.requestBinding.digest = digest(
  bindingMaterial(missingPointPayload.parameters),
);
assertThrows(
  () => validatePositive("mutated missing point payload", missingPointPayload),
  "Verifier accepted a pre_tool_call request without tool_call",
);

const removedSelectorConflict = clone(semanticCases[0]);
delete removedSelectorConflict.parameters.policyId;
assertThrows(
  () => validateSemanticCase(removedSelectorConflict),
  "Verifier accepted an invalid-selector case after removing the conflict",
);
