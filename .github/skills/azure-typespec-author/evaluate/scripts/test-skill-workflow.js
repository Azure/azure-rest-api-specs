/* eslint-disable typescript/no-unsafe-argument, typescript/no-unsafe-assignment, typescript/no-unsafe-call, typescript/no-unsafe-member-access -- Eval YAML is external data validated by the assertions below. */
import * as assert from "node:assert/strict";
import * as fs from "node:fs";
import * as path from "node:path";
import { fileURLToPath } from "node:url";
import { parse } from "yaml";

const scriptDir = path.dirname(fileURLToPath(import.meta.url));
const skillDir = path.resolve(scriptDir, "../..");
const evalsDir = path.resolve(scriptDir, "../evals");

function read(relativePath) {
  return fs.readFileSync(path.join(skillDir, relativePath), "utf8");
}

const skill = read("SKILL.md");
const frontmatterEnd = skill.indexOf("\n---", 4);
const skillFrontmatter = skill.slice(0, frontmatterEnd);
const intake = read("references/intake.md");
const plan = read("references/authoring-plan.md");
const search = read("references/agentic-search.md");

assert.ok(
  skill.indexOf("Attempt catalog access before selecting a knowledge route") <
    skill.indexOf("Select and execute one knowledge route during intake"),
  "entry-point catalog gate must precede route selection",
);
assert.match(skill, /Never call `azsdk_typespec_generate_authoring_plan`/);
assert.match(skillFrontmatter, /azsdk_typespec_retrieve_knowledge/);
assert.match(skillFrontmatter, /azsdk_run_typespec_validation/);
assert.match(skill, /MCP tools are optional capabilities, not prerequisites/);
assert.match(skill, /Step 3 reuses the fetched content and must not retrieve it again/);
assert.match(skill, /"carry over all features" or "no exclusions" completely answers/);
assert.match(
  skill,
  /Analyze → Read catalog → Classify coverage → Ground once during intake → Plan locally/,
);
assert.match(skill, /returns an error, times out, or fails authentication is not\s+unavailable/);

const catalogGate = intake.indexOf("Select and execute one knowledge route");
const routeClassification = intake.indexOf("Classify the complete request");
assert.ok(catalogGate !== -1 && catalogGate < routeClassification);
assert.match(intake, /Use the fetched\s+guidance to determine the material intake decisions/);
assert.match(intake, /Catalog access failure is not a blocker/);
assert.match(intake, /Execute exactly one route for the complete request/);
assert.match(intake, /Do not call both Agentic Search and retrieval/);
assert.match(
  intake,
  /must reuse this grounding record without repeating Agentic Search or retrieval/,
);
assert.equal((intake.match(/Covered — Agentic Search/g) ?? []).length, 4);
assert.match(plan, /executed exactly one knowledge route/);
assert.match(
  plan,
  /Do not call Agentic Search, `azsdk_typespec_retrieve_knowledge`, or an authoring-plan/,
);
assert.match(plan, /return to Step 2 and refine\s+the same selected route there/);
assert.match(
  search,
  /Enter this procedure during Step 2 when intake selects the Web knowledge route/,
);
assert.match(search, /catalog may guide URL selection but is not required/);
assert.match(search, /Do not call a knowledge MCP after selecting this route/);
assert.match(plan, /Do not use `ArmResourcePatchSync` or `ArmResourcePatchAsync`/);
assert.match(plan, /Preserve every released stable wire contract/);
assert.match(plan, /Use synchronous templates for GET\/read and LIST/);
assert.match(plan, /Preserve the target resource's existing key, route, request, and response/);
assert.match(plan, /full CRUD request supplies one sync\/async decision/);
assert.match(
  plan,
  /including existence[\s>]+checks, custom actions, LRO behavior, and response\/header changes/,
);

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
