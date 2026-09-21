import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { canonicalJson, stableId } from "./stable-id.mjs";

const CATALOG_PATH = path.resolve(
  path.dirname(fileURLToPath(import.meta.url)), "..", "references", "reference-document-links.md",
);
const REFERENCE_HEADINGS = [
  "ARM Resource Type", "ARM Resource Operation", "API Versioning",
  "Long-Running Operations (LRO)", "Paging", "Models and Enums", "Decorators", "Warnings",
];
export const REFERENCE_CATEGORIES = [
  "arm-resource-type", "arm-resource-operation", "api-versioning",
  "long-running-operation", "paging", "models-and-enums", "decorators", "warnings",
];
const DECISIONS = ["applicable-pass", "applicable-fail", "no-applicable-guidance", "not-assessed"];

function duplicates(values) {
  return values.filter((value, index) => values.indexOf(value) !== index);
}

function assertKeys(value, allowed, label) {
  if (!value || typeof value !== "object" || Array.isArray(value)) {
    throw new Error(`${label} must be an object.`);
  }
  const unknown = Object.keys(value).filter((key) => !allowed.includes(key));
  if (unknown.length) throw new Error(`${label} contains unknown fields: ${unknown.join(", ")}.`);
}

function text(value, label) {
  if (typeof value !== "string" || !value.trim()) throw new Error(`${label} must be nonempty.`);
}

function array(value, label) {
  if (!Array.isArray(value)) throw new Error(`${label} must be an array.`);
}

function subset(actual, expected, label) {
  array(actual, label);
  if (duplicates(actual).length || actual.some((value) => !expected.includes(value))) {
    throw new Error(`${label} contains an unknown or duplicate ID.`);
  }
}

function exactCoverage(expected, actual, label) {
  subset(actual, expected, label);
  if (expected.some((value) => !actual.includes(value))) throw new Error(`${label} coverage mismatch.`);
}

export function readComplianceCatalog(file = CATALOG_PATH) {
  const entries = [];
  const headings = [];
  const urls = new Set();
  let catalogOrder = 0;
  let category = "";
  for (const line of fs.readFileSync(file, "utf8").split(/\r?\n/)) {
    const heading = line.match(/^##\s+(.+)$/);
    if (heading) {
      category = heading[1];
      headings.push(category);
      continue;
    }
    const entry = line.match(/^- \[([^\]]+)\]\((https?:\/\/[^)]+)\):\s*(.+)$/);
    if (!entry) continue;
    catalogOrder += 1;
    if (urls.has(entry[2])) throw new Error(`Reference catalog contains duplicate canonical URL ${entry[2]}.`);
    urls.add(entry[2]);
    entries.push({
      catalogId: stableId("catalog-entry", entry[2], 12), catalogOrder, category,
      title: entry[1], canonicalUrl: entry[2], description: entry[3],
    });
  }
  if (canonicalJson(headings) !== canonicalJson(REFERENCE_HEADINGS)) {
    throw new Error("Reference catalog must contain exactly the eight canonical category headings, each once and in category order.");
  }
  return entries;
}

export function validateGuidanceRouting(requests, catalog = readComplianceCatalog()) {
  const catalogIds = catalog.map((entry) => entry.catalogId);
  const discoveryIds = [];
  const owners = requests.map((request) => request.reviewUnitId);
  if (duplicates(owners).length) throw new Error("Duplicate guidance routing ownership.");
  for (const request of requests) {
    const label = `Guidance routing ${request.reviewUnitId}`;
    if (!Array.isArray(request.referenceCategories) || !request.guidanceRouting) {
      throw new Error(`${label} is missing reference categories or mandatory routing; rerun deterministic analysis and rebuild the Agent workspace.`);
    }
    subset(request.referenceCategories, REFERENCE_CATEGORIES, `${label} categories`);
    const routing = request.guidanceRouting;
    assertKeys(routing, ["mandatoryCatalogIds", "selections", "discoveryRequests"], label);
    subset(routing.mandatoryCatalogIds, catalogIds, `${label} mandatoryCatalogIds`);
    array(routing.selections, `${label} selections`);
    array(routing.discoveryRequests, `${label} discoveryRequests`);
    for (const selection of routing.selections) {
      assertKeys(selection, ["catalogId", "category", "ruleId"], `${label} selection`);
      if (!request.referenceCategories.includes(selection.category)) throw new Error(`${label} selection has an unowned category.`);
      text(selection.ruleId, `${label} ruleId`);
    }
    exactCoverage(routing.mandatoryCatalogIds, [...new Set(routing.selections.map((item) => item.catalogId))], `${label} selection`);
    if (duplicates(routing.selections.map(canonicalJson)).length) throw new Error(`${label} has duplicate selections.`);
    for (const discovery of routing.discoveryRequests) {
      if (!discovery.requestId?.startsWith("discovery-request-") || discovery.reviewUnitId !== request.reviewUnitId) {
        throw new Error(`${label} discovery has invalid ownership.`);
      }
      text(discovery.trigger, `${label} discovery trigger`);
      array(discovery.queryTerms, `${label} discovery queryTerms`);
      discovery.queryTerms.forEach((term) => text(term, `${label} discovery query term`));
      discoveryIds.push(discovery.requestId);
    }
  }
  if (duplicates(discoveryIds).length) throw new Error("Duplicate canonical discovery requests.");
}

export function resolveDocumentSelections({
  requests, discoveryResults, additionalSelections, documents = [], catalog = readComplianceCatalog(),
}) {
  validateGuidanceRouting(requests, catalog);
  array(discoveryResults, "Discovery results");
  array(additionalSelections, "Additional selections");
  const catalogIds = catalog.map((entry) => entry.catalogId);
  const requestsByIntent = new Map(requests.map((request) => [request.reviewUnitId, request]));
  const canonicalDiscovery = new Map(requests.flatMap((request) =>
    request.guidanceRouting.discoveryRequests.map((item) => [item.requestId, item]),
  ));
  const documentSelections = requests.flatMap((request) =>
    request.guidanceRouting.selections.map((item) => ({
      reviewUnitId: request.reviewUnitId, ...item, basis: "category-rule",
      ...(request.evidenceSetId ? { evidenceSetId: request.evidenceSetId } : {}),
    })),
  );
  const blockers = [];
  const validateOutcome = (result, label) => {
    if (!requestsByIntent.has(result.intentId)) throw new Error(`${label} has unknown intent ownership.`);
    if (!["selected", "no-match", "blocked"].includes(result.outcome)) throw new Error(`${label} has an invalid outcome.`);
    text(result.rationale, `${label} rationale`);
    subset(result.catalogIds, catalogIds, `${label} catalogIds`);
    if ((result.outcome === "selected") !== (result.catalogIds.length > 0)) {
      throw new Error(`${label} selected outcome must have catalog IDs; no-match and blocked must not.`);
    }
    if (result.outcome === "blocked") blockers.push({ reviewUnitId: result.intentId, message: `${label}: ${result.rationale}` });
  };
  if (duplicates(discoveryResults.map((item) => item.requestId)).length) throw new Error("Duplicate discovery results.");
  for (const result of discoveryResults) {
    assertKeys(result, ["requestId", "intentId", "outcome", "catalogIds", "rationale"], "Discovery result");
    const request = canonicalDiscovery.get(result.requestId);
    if (!request || request.reviewUnitId !== result.intentId) throw new Error(`Discovery result ${result.requestId} has unknown or cross-intent ownership.`);
    validateOutcome(result, `Discovery ${result.requestId}`);
    if ((request.trigger === "classification-blocked" ||
      request.queryTerms.some((term) => term.startsWith("classification-diagnostic:"))) &&
      result.outcome !== "blocked") {
      throw new Error(`Discovery ${result.requestId} has blocked canonical classification evidence; rerun deterministic analysis rather than claiming selected or no-match.`);
    }
    documentSelections.push(...result.catalogIds.map((catalogId) => ({
      reviewUnitId: result.intentId, catalogId, basis: "discovery",
      requestId: result.requestId, trigger: request.trigger, rationale: result.rationale,
    })));
  }
  for (const request of canonicalDiscovery.values()) {
    if (!discoveryResults.some((item) => item.requestId === request.requestId)) {
      blockers.push({ reviewUnitId: request.reviewUnitId, message: `Discovery ${request.requestId} has no outcome.` });
    }
  }
  const additionalKeys = [];
  for (const result of additionalSelections) {
    assertKeys(result, ["intentId", "sourceCatalogId", "sourceSection", "trigger", "outcome", "catalogIds", "rationale"], "Additional selection");
    validateOutcome(result, "Additional discovery");
    if (!["linked-reference", "uncovered-concern"].includes(result.trigger)) throw new Error("Additional discovery has an invalid trigger.");
    text(result.sourceSection, "Additional discovery sourceSection");
    const source = documents.find((document) => document.catalogId === result.sourceCatalogId);
    if (!source?.guidance?.some((item) => item.section === result.sourceSection)) {
      throw new Error("Additional discovery requires a retained source document and section.");
    }
    additionalKeys.push(canonicalJson([result.intentId, result.sourceCatalogId, result.sourceSection, result.trigger, result.catalogIds]));
  }
  if (duplicates(additionalKeys).length) throw new Error("Duplicate additional discoveries.");
  // Only references rooted in already selected content can extend an intent's document set.
  const pending = [...additionalSelections];
  while (pending.length) {
    const index = pending.findIndex((result) => documentSelections.some(
      (item) => item.reviewUnitId === result.intentId && item.catalogId === result.sourceCatalogId,
    ));
    if (index < 0) throw new Error("Additional discovery has unselected or cyclic source provenance.");
    const [result] = pending.splice(index, 1);
    documentSelections.push(...result.catalogIds.map((catalogId) => ({
      reviewUnitId: result.intentId, catalogId, basis: "linked-reference",
      sourceCatalogId: result.sourceCatalogId, sourceSection: result.sourceSection,
      trigger: result.trigger, rationale: result.rationale,
    })));
  }
  for (const request of requests) {
    if (!request.guidanceRouting.mandatoryCatalogIds.length && !request.guidanceRouting.discoveryRequests.length) {
      blockers.push({ reviewUnitId: request.reviewUnitId, message: "No mandatory guidance or completed targeted discovery is available." });
    }
  }
  return { documentSelections, blockers };
}

function validateDocument(document, catalogById, declarations) {
  const label = `Azure Guidelines document ${document.catalogId}`;
  assertKeys(document, ["catalogId", "catalogOrder", "title", "canonicalUrl", "retrieval", "guidance", "noRelevantGuidance"], label);
  const catalog = catalogById.get(document.catalogId);
  if (!catalog || ["catalogOrder", "title", "canonicalUrl"].some((field) => catalog[field] !== document[field])) {
    throw new Error(`${label} does not match canonical catalog identity.`);
  }
  assertKeys(document.retrieval, ["status", "retrievedAt", "contentHash", "retrievalSource", "bytes"], `${label} retrieval`);
  const retrieval = document.retrieval;
  if (retrieval.status !== "fetched" || Number.isNaN(Date.parse(retrieval.retrievedAt ?? "")) ||
    !/^sha256:[0-9a-f]{64}$/i.test(retrieval.contentHash ?? "") ||
    !["network", "session-reuse"].includes(retrieval.retrievalSource) ||
    !Number.isInteger(retrieval.bytes) || retrieval.bytes < 1) {
    throw new Error(`${label} requires retained content and valid network or session-reuse provenance.`);
  }
  array(document.guidance, `${label} guidance`);
  if (typeof document.noRelevantGuidance !== "boolean" || document.noRelevantGuidance === (document.guidance.length > 0)) {
    throw new Error(`${label} must contain guidance or declare no relevant guidance, not both.`);
  }
  if (duplicates(document.guidance.map((item) => item.section)).length) throw new Error(`${label} has duplicate sections.`);
  for (const guidance of document.guidance) {
    assertKeys(guidance, ["section", "excerpt", "queryTerms", "examples", "applicableDeclarationIds"], `${label} guidance`);
    text(guidance.section, `${label} section`);
    text(guidance.excerpt, `${label} excerpt`);
    array(guidance.queryTerms, `${label} queryTerms`);
    guidance.queryTerms.forEach((term) => text(term, `${label} query term`));
    array(guidance.examples, `${label} examples`);
    subset(guidance.applicableDeclarationIds, declarations, `${label} declaration applicability`);
    if (guidance.examples.length > 2 || guidance.examples.some((example) => typeof example !== "string" || example.split(/\r?\n/).length > 12)) {
      throw new Error(`${label} may retain at most two examples of at most 12 lines.`);
    }
  }
}

export function searchInputAccounting(evidence) {
  const network = evidence.documents.filter((item) => item.retrieval.retrievalSource === "network");
  const guidance = evidence.documents.flatMap((document) => document.guidance);
  return {
    documentSelectionCount: evidence.documentSelections.length,
    uniqueDocumentsSelected: new Set(evidence.documentSelections.map((item) => item.catalogId)).size,
    documentsFetched: network.length,
    documentsReused: evidence.documents.length - network.length,
    documentBytesFetched: network.reduce((sum, item) => sum + item.retrieval.bytes, 0),
    documentBytesProcessed: evidence.documents.reduce((sum, item) => sum + item.retrieval.bytes, 0),
    discoveryOutcomeCount: evidence.discoveryResults.length + evidence.additionalSelections.length,
    guidanceExcerptsRetained: guidance.length,
    guidanceExcerptBytesRetained: guidance.reduce((sum, item) => sum + Buffer.byteLength(item.excerpt, "utf8"), 0),
  };
}

function relevantDeclarationSnippet(declaration, actual, action) {
  const snippet = declaration.sourceSnippet;
  if (!snippet?.lines?.length || !["add", "remove"].includes(action)) {
    return undefined;
  }
  const tokens = [
    ...new Set(
      `${actual ?? ""} ${declaration.qualifiedName ?? ""}`
        .toLowerCase()
        .match(/[a-z][a-z0-9_.@-]{3,}/g) ?? [],
    ),
  ];
  const shortName = declaration.qualifiedName?.split(".").at(-1)?.toLowerCase();
  const scores = snippet.lines.map((line) => {
    const normalized = line.toLowerCase();
    let score = tokens.reduce(
      (total, token) => total + (normalized.includes(token) ? 1 : 0),
      0,
    );
    if (/azure\.resourcemanager\.legacy/i.test(line)) score += 20;
    if (shortName && normalized.includes(shortName)) score += 8;
    if (/^\s*(?:model|interface|op|alias)\b/.test(line)) score += 4;
    if (/^\s*(?:import|using)\b/.test(line)) score -= 8;
    return score;
  });
  const best = scores.indexOf(Math.max(...scores));
  const start = Math.max(0, best - 3);
  const end = Math.min(snippet.lines.length, start + 12);
  const prefix = declaration.source?.revision === "base" ||
    (declaration.source?.revision === undefined && action === "remove")
    ? "-"
    : "+";
  return {
    path: declaration.sourcePath,
    hunkId: declaration.hunkIds?.[0],
    startLine: snippet.startLine + start,
    endLine: snippet.startLine + end - 1,
    lines: snippet.lines.slice(start, end).map((line) => `${prefix}${line}`),
  };
}

function legacyUsageSnippets(sources, hunkIds, declarationIds) {
  const allowed = new Set(hunkIds);
  const allowedDeclarations = new Set(declarationIds);
  const changedLines = sources
    .flatMap((source) =>
      (source.hunks ?? [])
        .filter((hunk) => allowed.has(hunk.id))
        .flatMap((hunk) => {
          const lines = hunk.lines ?? [];
          const index = lines.findIndex((line) => {
            if (!/^[+-](?![+-])/.test(line)) return false;
            const code = line.slice(1).trim();
            return (
              code.includes("Azure.ResourceManager.Legacy.") &&
              !code.startsWith("#suppress") &&
              !code.startsWith("//") &&
              !code.startsWith("*")
            );
          });
          if (index < 0) return [];
          const start = Math.max(0, index - 1);
          return [{
            path: source.path,
            hunkId: hunk.id,
            lines: lines.slice(start, Math.min(lines.length, index + 4)),
          }];
        }),
    )
    .filter((snippet) => snippet.lines.length);
  const declarationLines = sources.flatMap((source) =>
    (source.declarations ?? [])
      .filter(
        (declaration) =>
          allowedDeclarations.has(declaration.id) &&
          declaration.sourceSnippet?.lines?.length,
      )
      .flatMap((declaration) =>
        declaration.sourceSnippet.lines.flatMap((line, index) => {
          const code = line.trim();
          if (
            !code.includes("Azure.ResourceManager.Legacy.") ||
            code.startsWith("#suppress") ||
            code.startsWith("//") ||
            code.startsWith("*")
          ) {
            return [];
          }
          const prefix = declaration.source?.revision === "base" ? "-" : "+";
          const start = Math.max(0, index - 1);
          const end = Math.min(
            declaration.sourceSnippet.lines.length,
            index + 4,
          );
          return [{
            path: source.path,
            hunkId: declaration.hunkIds?.find((id) => allowed.has(id)),
            startLine: declaration.sourceSnippet.startLine + start,
            endLine: declaration.sourceSnippet.startLine + end - 1,
            lines: declaration.sourceSnippet.lines
              .slice(start, end)
              .map((context) => `${prefix}${context}`),
          }];
        }),
      ),
  );
  return [
    ...new Map(
      [...changedLines, ...declarationLines].map((snippet) => [
        `${snippet.path}\u0000${snippet.lines.join("\n")}`,
        snippet,
      ]),
    ).values(),
  ].slice(0, 2);
}

function sourceEvidence(request, declarationIds, hunkIds, sourceMap, actual) {
  const sources = request.sourceChangeIds.map((id) => sourceMap.get(id)).filter(Boolean);
  const declarations = sources.flatMap((source) => (source.declarations ?? [])
    .filter((item) => declarationIds.includes(item.id)).map((item) => ({ ...item, sourcePath: source.path })));
  const legacySnippets = /Azure\.ResourceManager\.Legacy/.test(actual ?? "")
    ? legacyUsageSnippets(sources, hunkIds, request.declarationIds)
    : [];
  const declarationSnippets = declarations
    .map((declaration) =>
      relevantDeclarationSnippet(
        declaration,
        actual,
        request.queryProfile.action,
      ),
    )
    .filter(Boolean);
  return {
    sourceLinks: declarations.map((item) => ({
      path: item.sourcePath, startLine: item.source?.startLine, endLine: item.source?.endLine, link: item.source?.link,
    })),
    codeSnippets: legacySnippets.length
      ? legacySnippets
      : declarationSnippets.length
      ? declarationSnippets.slice(0, 2)
      : sources.flatMap((source) => (source.hunks ?? []).filter((hunk) => hunkIds.includes(hunk.id)).map((hunk) => ({
          path: source.path, hunkId: hunk.id,
          lines: (hunk.lines ?? []).filter((line) => /^[+-](?![+-])/.test(line)).slice(0, 12),
        }))).filter((snippet) => snippet.lines.length),
  };
}

export function assembleCompliance({ requests, evidence, decisions, sourceChanges, initialBlockers = [] }) {
  if (evidence?.schemaVersion !== 3) {
    throw new Error("Unsupported ranked Azure Guidelines evidence; rerun deterministic analysis and Agent judgment with search evidence schemaVersion 3.");
  }
  assertKeys(evidence, ["schemaVersion", "queryProfiles", "documentSelections", "documents", "discoveryResults", "additionalSelections", "retrievalAttempts", "blockers", "inputAccounting"], "Azure Guidelines search evidence");
  for (const field of ["queryProfiles", "documentSelections", "documents", "discoveryResults", "additionalSelections", "retrievalAttempts", "blockers"]) array(evidence[field], `Azure Guidelines ${field}`);
  array(decisions, "Judgment.complianceDecisions");
  const catalog = readComplianceCatalog();
  const catalogById = new Map(catalog.map((item) => [item.catalogId, item]));
  const requestsById = new Map(requests.map((item) => [item.reviewUnitId, item]));
  const resolved = resolveDocumentSelections({ requests, ...evidence, catalog });
  if (canonicalJson(evidence.documentSelections) !== canonicalJson(resolved.documentSelections)) {
    throw new Error("Azure Guidelines document selections differ from immutable canonical routing or discovery provenance.");
  }
  exactCoverage(requests.map((item) => item.reviewUnitId), evidence.queryProfiles.map((item) => item.reviewUnitId), "Azure Guidelines query profile");
  for (const profile of evidence.queryProfiles) {
    assertKeys(profile, ["reviewUnitId", "queryProfile"], "Azure Guidelines query profile");
    if (canonicalJson(profile.queryProfile) !== canonicalJson(requestsById.get(profile.reviewUnitId).queryProfile)) throw new Error(`Azure Guidelines intent ${profile.reviewUnitId} changed its query profile.`);
  }
  const selectedIds = [...new Set(evidence.documentSelections.map((item) => item.catalogId))];
  subset(evidence.documents.map((item) => item.catalogId), selectedIds, "Fetched document selection provenance");
  const declarations = [...new Set(requests.flatMap((item) => item.declarationIds))];
  evidence.documents.forEach((item) => validateDocument(item, catalogById, declarations));
  subset(evidence.retrievalAttempts.map((item) => item.catalogId), selectedIds, "Failed retrieval selection provenance");
  for (const failure of evidence.retrievalAttempts) {
    assertKeys(failure, ["catalogId", "canonicalUrl", "status", "error"], "Failed retrieval");
    if (failure.canonicalUrl !== catalogById.get(failure.catalogId)?.canonicalUrl || failure.status !== "failed") throw new Error("Invalid retrieval failure.");
    text(failure.error, "Retrieval failure error");
    if (evidence.documents.some((item) => item.catalogId === failure.catalogId)) throw new Error("A document cannot be both fetched and failed.");
  }
  const blockers = initialBlockers.map((item) => ({
    ...(item?.reviewUnitId ? { reviewUnitId: item.reviewUnitId } : {}),
    message: String(item?.message ?? item),
  }));
  for (const blocker of evidence.blockers) {
    assertKeys(blocker, ["reviewUnitId", "message"], "Search blocker");
    if (!requestsById.has(blocker.reviewUnitId)) throw new Error("Search blocker has unknown intent ownership.");
    text(blocker.message, "Search blocker message");
  }
  blockers.push(...evidence.blockers, ...resolved.blockers);
  if (canonicalJson(evidence.inputAccounting) !== canonicalJson(searchInputAccounting(evidence))) throw new Error("Azure Guidelines search input accounting is inconsistent.");
  exactCoverage(requests.map((item) => item.reviewUnitId), decisions.map((item) => item.reviewUnitId), "Azure Guidelines decision");
  const sourceMap = new Map(sourceChanges.map((item) => [item.id, item]));
  const finalDocuments = evidence.documents.map(({ retrieval, ...document }) => {
    const { status: _status, ...provenance } = retrieval;
    return { ...document, retrieval, ...provenance };
  });
  const findings = [];
  const intentAssessments = requests.map((request) => {
    const decision = decisions.find((item) => item.reviewUnitId === request.reviewUnitId);
    const label = `Azure Guidelines decision ${request.reviewUnitId}`;
    assertKeys(decision, ["reviewUnitId", "reviewedCatalogIds", "applicableGuidance", "sourceChangeIds", "hunkIds", "declarationIds", "decision", "title", "severity", "expected", "actual", "rationale"], label);
    if (!DECISIONS.includes(decision.decision)) throw new Error(`${label} is incomplete.`);
    text(decision.actual, `${label} actual`);
    text(decision.rationale, `${label} rationale`);
    array(decision.applicableGuidance, `${label} applicableGuidance`);
    for (const field of ["sourceChangeIds", "hunkIds", "declarationIds"]) subset(decision[field], request[field], `${label} ${field}`);
    const selectedCatalogIds = [...new Set(evidence.documentSelections.filter((item) => item.reviewUnitId === request.reviewUnitId).map((item) => item.catalogId))];
    const availableIds = evidence.documents.map((item) => item.catalogId).filter((id) => selectedCatalogIds.includes(id));
    subset(decision.reviewedCatalogIds, availableIds, `${label} reviewedCatalogIds (fetched and selected)`);
    const missing = selectedCatalogIds.filter((id) => !decision.reviewedCatalogIds.includes(id));
    const intentBlockers = blockers.filter((item) => item.reviewUnitId === request.reviewUnitId).map((item) => item.message);
    if (missing.length) intentBlockers.push(`Required or discovered documents have not been retrieved and reviewed: ${missing.join(", ")}.`);
    if (intentBlockers.length && decision.decision !== "not-assessed") throw new Error(`${label} falsely claims completed review with missing mandatory coverage or blocked discovery: ${intentBlockers.join(" ")}`);
    if (decision.decision === "not-assessed" && !intentBlockers.length) intentBlockers.push(decision.rationale);
    for (const message of intentBlockers) {
      if (!blockers.some((item) => item.reviewUnitId === request.reviewUnitId && item.message === message)) blockers.push({ reviewUnitId: request.reviewUnitId, message });
    }
    if (decision.decision.startsWith("applicable-")) {
      if (!decision.expected?.trim() || !decision.applicableGuidance.length || !decision.sourceChangeIds.length || !decision.hunkIds.length || !decision.declarationIds.length) throw new Error(`${label} lacks applicable evidence.`);
    } else if (decision.applicableGuidance.length || decision.expected !== undefined) throw new Error(`${label} has inapplicable guidance.`);
    if (decision.decision === "applicable-fail") {
      if (!decision.title?.trim() || !["high", "medium", "low"].includes(decision.severity)) throw new Error(`${label} lacks finding presentation.`);
    } else if (decision.title !== undefined || decision.severity !== undefined) throw new Error(`${label} has unexpected finding presentation.`);
    if (duplicates(decision.applicableGuidance.map(canonicalJson)).length) throw new Error(`${label} has duplicate guidance references.`);
    const applicableGuidance = decision.applicableGuidance.map((reference) => {
      assertKeys(reference, ["canonicalDocumentUrl", "guidanceSection"], `${label} guidance`);
      const document = evidence.documents.find((item) => item.canonicalUrl === reference.canonicalDocumentUrl && decision.reviewedCatalogIds.includes(item.catalogId));
      const guidance = document?.guidance.find((item) => item.section === reference.guidanceSection && item.applicableDeclarationIds.some((id) => decision.declarationIds.includes(id)));
      if (!guidance) throw new Error(`${label} uses unfetched, unreviewed, or unowned normative guidance.`);
      return { ...reference, excerpt: guidance.excerpt };
    });
    const source = sourceEvidence(
      request,
      decision.declarationIds,
      decision.hunkIds,
      sourceMap,
      decision.actual,
    );
    if (decision.decision === "applicable-fail") findings.push({
      id: stableId("compliance", { reviewUnitId: request.reviewUnitId }), semanticIntentId: request.reviewUnitId,
      title: decision.title, severity: decision.severity, applicableGuidance,
      declarationIds: decision.declarationIds, sourceChangeIds: decision.sourceChangeIds, hunkIds: decision.hunkIds,
      expected: decision.expected, actual: decision.actual, gap: decision.rationale, ...source,
    });
    return {
      semanticIntentId: request.reviewUnitId, ...decision, gap: decision.rationale, ...source,
      ...(request.evidenceSetId ? { evidenceSetId: request.evidenceSetId } : {}),
      referenceCategories: request.referenceCategories,
      requiredCatalogIds: request.guidanceRouting.mandatoryCatalogIds,
      selectedCatalogIds, guidanceRouting: request.guidanceRouting, queryProfile: request.queryProfile,
      blockers: [...new Set(intentBlockers)],
    };
  });
  const unassessedIntentIds = intentAssessments.filter((item) => item.decision === "not-assessed").map((item) => item.reviewUnitId);
  const status = findings.length ? "failed" : blockers.length || unassessedIntentIds.length ? "not-assessed" : "passed";
  return {
    status,
    summary: findings.length ? `${findings.length} documentation-grounded Azure Guidelines finding(s).`
      : status === "not-assessed" ? "Azure Guidelines evidence or intent-scoped review coverage is incomplete."
        : decisions.some((item) => item.decision === "no-applicable-guidance")
          ? "Required review and targeted discovery completed; no applicable guidance was found for one or more intents. This is not an all-guidelines compliance pass."
          : requests.length ? "All assessed intents match their applicable reviewed guidance." : "No assessable Semantic intents require Azure Guidelines review.",
    coverage: {
      semanticIntentCount: requests.length, assessedIntentCount: requests.length - unassessedIntentIds.length,
      selectedDocumentCount: selectedIds.length, unassessedIntentIds,
    },
    sharedSearch: {
      documentSelections: evidence.documentSelections, documents: finalDocuments,
      discoveryResults: evidence.discoveryResults, additionalSelections: evidence.additionalSelections,
    },
    intentAssessments, findings, retrievalFailures: evidence.retrievalAttempts,
    blockers: [...new Map(blockers.map((item) => [canonicalJson(item), item])).values()],
  };
}
