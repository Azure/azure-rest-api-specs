import assert from "node:assert/strict";
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { parse } from "yaml";

const scriptDir = path.dirname(fileURLToPath(import.meta.url));
const skillDir = path.resolve(scriptDir, "../..");
const evalsDir = path.resolve(scriptDir, "../evals");

function read(relativePath) {
  return fs.readFileSync(path.join(skillDir, relativePath), "utf8");
}

const skill = read("SKILL.md");
const intake = read("references/intake.md");
const plan = read("references/authoring-plan.md");

assert.ok(
  skill.indexOf("Catalog access gates source selection") <
    skill.indexOf("Use exactly one knowledge-source family"),
  "entry-point catalog gate must precede source routing",
);
assert.match(skill, /Never call `azsdk_typespec_generate_authoring_plan`/);
assert.match(skill, /block rather than switching to retrieval/);
assert.match(skill, /"carry over all features" or "no exclusions" completely answers/);
assert.match(skill, /Retrieval unavailable:[\s\S]*authoritative Web\s+documentation/);
assert.match(skill, /Validation unavailable:[\s\S]*mandatory local compile/);
assert.match(skill, /returns an error, times out, or fails authentication is not\s+unavailable/);

const catalogGate = plan.indexOf("complete this catalog-access gate");
const webRoute = plan.indexOf("Entire request covered");
const retrievalRoute = plan.indexOf("Entirely or partly uncovered");
assert.ok(catalogGate !== -1 && catalogGate < webRoute);
assert.ok(webRoute < retrievalRoute);
assert.match(plan, /successful non-Web catalog read/);
assert.match(plan, /When the retrieval tool is not exposed, select the Web fallback/);
assert.match(plan, /invocation\s+error, authentication failure, or timeout[\s\S]*not\s+absence/);
assert.match(plan, /Do not use `ArmResourcePatchSync` or `ArmResourcePatchAsync`/);
assert.match(plan, /Preserve every released stable wire contract/);

assert.match(intake, /Add, replace, or promote an API version/);
assert.match(intake, /Version-scope an existing feature without adding or promoting a version/);
assert.match(intake, /do not ask\s+for an unrelated service-wide carry-forward decision/);
assert.match(intake, /Continue without another question/);
assert.match(intake, /carry over all features[\s\S]*complete\s+decision/);
assert.match(intake, /informational, not a request\s+for approval/);

const requiredPromptFragments = new Map([
  ["001005.eval.yaml", ["Carry other features"]],
  ["001006.eval.yaml", ["Carry over all the features"]],
  ["001007.eval.yaml", ["Carry other features"]],
  ["001008.eval.yaml", ["Carry over all the features"]],
  ["003001.eval.yaml", ["greenfield operation", "Location", "Azure-AsyncOperation", "Retry-After"]],
  ["006002.eval.yaml", ["synchronous get operation", "existing name key"]],
  ["006003.eval.yaml", ["all existing and future API versions"]],
  ["006004.eval.yaml", ["complete synchronously"]],
  ["006007.eval.yaml", ["carry forward all other existing features"]],
  ["006009.eval.yaml", ["carry forward all other existing features"]],
]);

for (const [fileName, fragments] of requiredPromptFragments) {
  const specification = parse(fs.readFileSync(path.join(evalsDir, fileName), "utf8"));
  const forced = specification.stimuli.find((stimulus) => stimulus.tags?.mode === "forced");
  assert.ok(forced, `${fileName} has a forced stimulus`);
  for (const fragment of fragments) {
    assert.ok(forced.prompt.includes(fragment), `${fileName} forced prompt includes ${fragment}`);
  }
}

const versionSpread = parse(
  fs.readFileSync(path.join(evalsDir, "001001.eval.yaml"), "utf8"),
).stimuli.find((stimulus) => stimulus.tags?.mode === "forced");
assert.ok(versionSpread.prompt.includes("2025-05-04-preview only"));
assert.ok(
  !/carry forward|exclude/i.test(versionSpread.prompt),
  "001001 remains a feature-scoping request rather than a new-version stimulus",
);

console.log("Skill workflow contract checks passed.");
