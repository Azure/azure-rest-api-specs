/* eslint-disable typescript/no-unsafe-assignment, typescript/no-unsafe-call, typescript/no-unsafe-member-access, typescript/no-unsafe-return -- Contract tests intentionally construct schema-less Vally events. */
import * as assert from "node:assert/strict";
import { analyzeEvents, summarize } from "./analyze-routing.js";

let sequence = 0;

function tool(events, toolName, arguments_, success = true) {
  const toolCallId = `call-${++sequence}`;
  events.push({
    type: "tool.execution_start",
    data: { arguments: arguments_, toolCallId, toolName },
  });
  events.push({
    type: "tool.execution_complete",
    data: { success, toolCallId },
  });
}

function coveredEvents() {
  const events = [];
  tool(events, "view", {
    path: "C:\\skill\\references\\reference-document-links.md",
  });
  tool(events, "web_fetch", {
    url: "https://azure.github.io/typespec-azure/docs/howtos/versioning/",
  });
  tool(events, "apply_patch", {});
  tool(events, "azure-sdk-mcp-azsdk_run_typespec_validation", {});
  return events;
}

const covered = analyzeEvents(coveredEvents(), "covered");
assert.equal(covered.route, "Web only");
assert.equal(covered.catalogReadSucceeded, true);
assert.equal(covered.catalogBeforeSource, true);
assert.equal(covered.sourceExclusive, true);
assert.equal(covered.groundingBeforeMutation, true);
assert.equal(covered.validationAfterMutation, true);

const uncoveredEvents = [];
tool(uncoveredEvents, "view", {
  path: "/skill/references/reference-document-links.md",
});
tool(uncoveredEvents, "web_fetch", {
  url: "https://typespec.io/docs/language-basics/models/",
});
tool(uncoveredEvents, "edit", {});
tool(uncoveredEvents, "azure-sdk-mcp-azsdk_run_typespec_validation", {});
const uncovered = analyzeEvents(uncoveredEvents, "uncovered");
assert.equal(uncovered.route, "Web only");
assert.equal(uncovered.catalogBeforeSource, true);
assert.equal(uncovered.sourceExclusive, true);
assert.equal(uncovered.approvedKnowledgeRoute, true);

const canonicalEvents = [];
tool(
  canonicalEvents,
  "view",
  {
    path: "/skill/references/reference-document-links.md",
  },
  false,
);
tool(canonicalEvents, "web_fetch", {
  url: "https://raw.githubusercontent.com/Azure/azure-rest-api-specs/main/.github/skills/azure-typespec-author/references/reference-document-links.md",
});
tool(canonicalEvents, "web_fetch", {
  url: "https://azure.github.io/typespec-azure/docs/howtos/versioning/",
});
tool(canonicalEvents, "apply_patch", {});
tool(canonicalEvents, "azure-sdk-mcp-azsdk_run_typespec_validation", {});
const canonical = analyzeEvents(canonicalEvents, "canonical");
assert.equal(canonical.route, "Web only");
assert.equal(canonical.catalogReadSucceeded, true);
assert.equal(canonical.catalogBeforeSource, true);

const unavailableCatalogEvents = [];
tool(
  unavailableCatalogEvents,
  "view",
  {
    path: "/skill/references/reference-document-links.md",
  },
  false,
);
tool(unavailableCatalogEvents, "web_fetch", {
  url: "https://typespec.io/docs/language-basics/models/",
});
tool(unavailableCatalogEvents, "apply_patch", {});
tool(unavailableCatalogEvents, "azure-sdk-mcp-azsdk_run_typespec_validation", {});
const unavailableCatalog = analyzeEvents(unavailableCatalogEvents, "unavailable-catalog");
assert.equal(unavailableCatalog.route, "Web only");
assert.equal(unavailableCatalog.catalogReadSucceeded, false);
assert.equal(unavailableCatalog.catalogBeforeSource, true);
assert.equal(unavailableCatalog.approvedKnowledgeRoute, true);
assert.equal(unavailableCatalog.catalogFailureSafe, true);

const prematureEvents = [];
tool(
  prematureEvents,
  "view",
  {
    path: "/skill/references/reference-document-links.md",
  },
  false,
);
tool(prematureEvents, "azure-sdk-mcp-azsdk_typespec_retrieve_knowledge", {});
const premature = analyzeEvents(prematureEvents, "premature");
assert.equal(premature.catalogReadSucceeded, false);
assert.equal(premature.catalogBeforeSource, true);
assert.equal(premature.catalogFailureSafe, false);

const blockerEvents = [];
tool(
  blockerEvents,
  "view",
  {
    path: "/skill/references/reference-document-links.md",
  },
  false,
);
tool(
  blockerEvents,
  "web_fetch",
  {
    url: "https://typespec.io/docs/",
  },
  false,
);
const blocker = analyzeEvents(blockerEvents, "blocker");
assert.equal(blocker.route, "Web only");
assert.equal(blocker.catalogFailureSafe, true);

const mixedEvents = coveredEvents();
tool(mixedEvents, "azure-sdk-mcp-azsdk_typespec_retrieve_knowledge", {});
tool(mixedEvents, "azure-sdk-mcp-azsdk_typespec_generate_authoring_plan", {});
const mixed = analyzeEvents(mixedEvents, "mixed");
assert.equal(mixed.route, "Both");
assert.equal(mixed.sourceExclusive, false);
assert.equal(mixed.planner, 1);

const summary = summarize([covered, uncovered, canonical, unavailableCatalog, premature, mixed]);
assert.deepEqual(summary.routes, {
  "Web only": 4,
  "Retrieval only": 1,
  Both: 1,
  Neither: 0,
});
assert.equal(summary.catalogViolations, 0);
assert.equal(summary.sourceExclusivityViolations, 1);
assert.equal(summary.retrievalViolations, 2);
assert.equal(summary.plannerCalls, 1);

console.log("Routing analyzer contract scenarios passed.");
