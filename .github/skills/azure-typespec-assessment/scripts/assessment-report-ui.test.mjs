import assert from "node:assert/strict";
import { existsSync, readFileSync } from "node:fs";
import test from "node:test";
import vm from "node:vm";
import {
  documentQualitySummary,
  downstreamMethodData,
  downstreamPresentationDimension,
  renderReportSections,
  sdkTypeName,
} from "./assessment-report-ui.mjs";
import {
  escapeHtml,
  renderAssessmentHtml as renderCurrentAssessmentHtml,
} from "./render-assessment-html.mjs";
import { normalizeRecordedAssessment, reportSection } from "./report-test-utils.mjs";

/** @typedef {import("./runtime-types.js").AssessmentFact} AssessmentFact */
/** @typedef {import("./runtime-types.js").AssessmentOutput} AssessmentOutput */
/** @typedef {import("./runtime-types.js").DocumentQualityDimension} DocumentQualityDimension */
/** @typedef {import("./runtime-types.js").DocumentQualityDecision} DocumentQualityDecision */
/** @typedef {import("./runtime-types.js").DocumentationDocument} DocumentationDocument */
/** @typedef {import("./runtime-types.js").DocumentationSnapshot} DocumentationSnapshot */
/** @typedef {import("./runtime-types.js").DownstreamAnalysis} DownstreamAnalysis */
/** @typedef {import("./runtime-types.js").SourceChange} SourceChange */
/** @typedef {NonNullable<Parameters<typeof renderCurrentAssessmentHtml>[1]>} RenderOptions */
/** @typedef {AssessmentOutput["dimensions"]["downstream"]} TestDownstreamDimension */
/**
 * @typedef {DocumentQualityDimension & {
 *   coverage: NonNullable<DocumentQualityDimension["coverage"]>,
 *   intentAssessments: (NonNullable<DocumentQualityDimension["intentAssessments"]>[number] & {
 *     documents: DocumentationDocument[],
 *     checks: DocumentQualityDecision[]
 *   })[],
 *   findings: (NonNullable<DocumentQualityDimension["findings"]>[number] & {
 *     document: DocumentationDocument,
 *     semanticIntentIds: string[]
 *   })[],
 *   blockers: unknown[]
 * }} TestDocumentQualityDimension
 */
/**
 * @typedef {{
 *   id: string,
 *   path: string,
 *   declarations: {
 *     kind: string,
 *     qualifiedName: string,
 *     source: {path: string, revision: string, startLine: number, endLine: number},
 *     compilerEvidence: {kind: string, referencedNames: string[]}
 *   }[]
 * }} DocumentationSourceFixture
 */

/**
 * @template T
 * @param {T | null | undefined} value
 * @param {string} [message]
 * @returns {T}
 */
function required(value, message = "Expected test fixture value.") {
  assert.ok(value, message);
  return value;
}

/**
 * @param {string} value
 * @param {RegExp} pattern
 * @param {number} [group]
 */
function requiredMatch(value, pattern, group = 0) {
  const match = value.match(pattern);
  assert.ok(match);
  const capture = match[group];
  assert.ok(capture);
  return capture;
}

/** @type {Parameters<typeof renderReportSections>[1]} */
const reportRenderHelpers = {
  escapeHtml,
  operationContractRows: () => [],
  restContractDelta: () => ({ area: "", before: "", after: "" }),
  findingMatchesOperation: () => false,
  complianceFindingGroups: () => [],
  complianceCode: () => "",
  renderSourceHunks: () => "",
  sourceLinks: () => "",
  legacyEvidence: () => "",
  contractAreaParts: () => ({ areaKind: "", member: "" }),
  directLegacyDownstreamFindings: () => [],
};

/** @param {URL} url @returns {AssessmentOutput} */
function readAssessment(url) {
  const value = /** @type {unknown} */ (JSON.parse(readFileSync(url, "utf8")));
  return /** @type {AssessmentOutput} */ (value);
}

/**
 * @param {AssessmentOutput} assessment
 * @param {RenderOptions} [options]
 */
function renderAssessmentHtml(assessment, options) {
  return renderCurrentAssessmentHtml(normalizeRecordedAssessment(assessment), options);
}

const recordedAssessmentTest = existsSync(new URL("../evals/assessments", import.meta.url))
  ? test
  : test.skip;

/** @returns {{dimension: TestDownstreamDimension, raw: DownstreamAnalysis}} */
function fixture() {
  /** @param {string} role @returns {AssessmentFact & {id: string}} */
  const typeFact = (role) => ({
    id: `type-${role}`,
    projectId: "project",
    comparisonRole: role,
    sourceCommit: role,
    apiVersion: "v1",
    factKind: "model",
    identity: "Contoso.Widget",
    properties:
      role === "baseline" ? [{ name: "old", type: { kind: "string" }, optional: true }] : [],
  });
  /**
   * @param {string} role
   * @param {string} [name]
   * @returns {AssessmentFact & {id: string, crossLanguageDefinitionId: string}}
   */
  const methodFact = (role, name = "updateAddressLocations") => ({
    id: `${name}-${role}`,
    projectId: "project",
    comparisonRole: role,
    sourceCommit: role,
    apiVersion: "v1",
    factKind: "method",
    crossLanguageDefinitionId: `Contoso.ServiceGateways.${name}${role === "baseline" ? "Lro" : ""}`,
    clientName: "ServiceGateways",
    name: `${name}${role === "baseline" ? "Lro" : ""}`,
    kind: role === "baseline" ? "lro" : "basic",
    parameters: [
      { name: "name", type: { kind: "string" } },
      { name: "afcManagedSync", optional: true, type: { kind: "boolean" } },
      { name: "parameters", type: { kind: "model", name: "Widget" } },
      { name: "contentType", type: { kind: "constant", value: "application/json" } },
    ],
    operation: {
      parameters: [
        { name: "name", kind: "path" },
        { name: "afcManagedSync", kind: "query" },
        {
          name: "contentType",
          kind: "header",
          serializedName: "Content-Type",
          type: { kind: "constant", value: "application/json" },
        },
      ],
      bodyParam: { name: "parameters", kind: "body" },
    },
    responseType: { kind: "model", name: "Widget" },
  });
  const before = typeFact("baseline");
  const after = typeFact("target");
  const methodBefore = methodFact("baseline");
  const methodAfter = methodFact("target");
  const listAfter = methodFact("target", "list");
  const typeFinding = {
    id: "type-change",
    rule: "model-property-removed",
    crossLanguageDefinitionId: "Contoso.Widget",
    expected: "Widget preserves property old.",
    actual: "Widget no longer exposes property old.",
    rationale: "Existing SDK callers use old.",
    relatedSemanticIntents: ["semantic-1"],
    rootCauseIds: ["root"],
    evidenceFactIds: [before.id, after.id],
    evidence: [before, after],
    severity: "high",
    sources: [{ path: "models.tsp", hunks: [{ id: "hunk", lines: ["- old?: string;"] }] }],
  };
  const directFinding = {
    id: "method-change",
    rule: "method-kind-changed",
    crossLanguageDefinitionId: methodBefore.crossLanguageDefinitionId,
    expected: "Existing method kind.",
    actual: "Changed method kind.",
    rationale: "The invocation changes.",
    relatedSemanticIntents: ["semantic-1"],
    evidenceFactIds: [methodBefore.id, methodAfter.id],
    evidence: [methodBefore, methodAfter],
    severity: "high",
    sources: typeFinding.sources,
  };
  const dimension = {
    status: "failed",
    findings: [typeFinding, directFinding],
    methodGroups: [
      {
        id: "direct-group",
        projectId: "project",
        symbol: methodBefore.crossLanguageDefinitionId,
        before: methodBefore,
        after: methodAfter,
        relatedSemanticIntents: ["semantic-1"],
        deltas: [{ findingId: "method-change", field: "kind", before: "lro", after: "basic" }],
      },
    ],
    typeImpacts: [
      {
        id: "impact",
        projectId: "project",
        type: "Contoso.Widget",
        findingIds: ["type-change"],
        rootCauseIds: ["root"],
        relatedSemanticIntents: ["semantic-1"],
        locations: ["request-body", "response-body"],
        summary: "Recorded Widget type change.",
        affectedMethodCount: 3,
        affectedMethods: [
          {
            symbol: methodBefore.crossLanguageDefinitionId,
            locations: ["request-body", "response-body"],
          },
          {
            symbol: methodAfter.crossLanguageDefinitionId,
            locations: ["request-body", "response-body"],
          },
          {
            symbol: listAfter.crossLanguageDefinitionId,
            locations: ["request-body", "response-body"],
          },
        ],
      },
    ],
  };
  const raw = {
    facts: Object.fromEntries(
      [before, after, methodBefore, methodAfter, listAfter].map((fact) => [
        fact.id,
        structuredClone(fact),
      ]),
    ),
    rootCauses: [
      {
        id: "root",
        directCandidateIds: ["type-change"],
        methodFactIds: [methodBefore.id, methodAfter.id, listAfter.id],
        referenceEvidence: [
          {
            fromFactId: methodBefore.id,
            toFactId: before.id,
            memberName: "body",
            location: "request-body",
          },
          {
            fromFactId: methodAfter.id,
            toFactId: after.id,
            memberName: "body",
            location: "request-body",
          },
          { fromFactId: listAfter.id, toFactId: after.id, location: "response-body" },
        ],
      },
    ],
    candidates: [typeFinding, directFinding].map(
      ({ id, rule, crossLanguageDefinitionId, evidenceFactIds }) => ({
        id,
        rule,
        crossLanguageDefinitionId,
        evidenceFactIds,
      }),
    ),
  };
  return /** @type {{dimension: TestDownstreamDimension, raw: DownstreamAnalysis}} */ (
    /** @type {unknown} */ ({ dimension, raw })
  );
}

/**
 * @param {TestDownstreamDimension} [downstream]
 * @returns {AssessmentOutput}
 */
function assessment(downstream = { status: "passed", findings: [] }) {
  return /** @type {AssessmentOutput} */ (
    /** @type {unknown} */ ({
      schemaVersion: 1,
      comparison: { baseCommit: "baseline", headCommit: "target" },
      confidence: "high",
      safety: { scope: "rest-and-downstream-only", status: downstream.status },
      dimensions: {
        semantic: {
          status: "assessed",
          sourceHunkIds: ["hunk"],
          items: [
            {
              id: "semantic-1",
              action: "modify",
              title: "Change the widget contract",
              summary: "Recorded intent, not a new judgment.",
              operations: [],
              relatedFindings: {
                downstream: (downstream.methodGroups ?? downstream.operationGroups ?? []).map(
                  (group) => group.id,
                ),
                typeImpact: (downstream.typeImpacts ?? downstream.sharedTypeImpacts ?? []).map(
                  (impact) => impact.id,
                ),
              },
              sources: [
                {
                  path: "models.tsp",
                  hunks: [{ id: "hunk", lines: ["- old?: string;", "+ current?: string;"] }],
                  declarations: [],
                },
              ],
            },
          ],
        },
        rest: { status: "passed", findings: [] },
        downstream,
        compliance: {
          status: "not-assessed",
          summary: "Evidence unavailable.",
          findings: [],
          intentAssessments: [],
          coverage: {
            semanticIntentCount: 0,
            assessedIntentCount: 0,
            selectedDocumentCount: 0,
            unassessedIntentIds: [],
          },
          retrievalFailures: [],
          blockers: [{ message: "compliance-search-input-missing: test has no guidance input." }],
        },
        documentQuality: {
          status: "not-assessed",
          summary: "Document Quality and Agent Friendliness is not assessed.",
        },
      },
      blockers: [],
      projects: [],
      changedFiles: [],
      provenance: {},
    })
  );
}

void test("merges direct methods and indirect types using target names and exact graph paths", () => {
  const { dimension, raw } = fixture();
  const input = structuredClone({ dimension, raw });
  const data = downstreamMethodData(dimension, raw);
  assert.equal(data.methods.length, 2);
  const method = required(
    data.methods.find((item) => item.name === "ServiceGateways.updateAddressLocations"),
  );
  assert.equal(method.cause, "mixed");
  assert.equal(method.types.length, 1);
  assert.deepEqual(
    method.types
      .flatMap((reference) => reference.paths)
      .map((item) => [item.path, item.role, item.location]),
    [
      ["body", "baseline", "request-body"],
      ["body", "target", "request-body"],
    ],
  );
  const list = required(data.methods.find((item) => item.name === "ServiceGateways.list"));
  assert.equal(list.cause, "indirect");
  assert.deepEqual(list.types[0].paths, [
    { path: "(returned type)", role: "target", location: "response-body" },
  ]);
  assert.deepEqual({ dimension, raw }, input);
});

void test("does not promote root-wide locations to per-method evidence without raw graph", () => {
  const { dimension } = fixture();
  const data = downstreamMethodData(dimension);
  assert.ok(
    data.methods.every((method) => method.types.every((reference) => reference.paths.length === 0)),
  );
  const html = renderAssessmentHtml(assessment(dimension));
  assert.match(html, /Aggregate root locations are not method-specific evidence/);
  assert.doesNotMatch(html, /class="report-reference-path"/);
});

void test("breaking explanations separate distinct consequences without truncation or duplicates", () => {
  const { dimension } = fixture();
  const first =
    "The method now returns a collection; callers must iterate items instead of reading the result wrapper.";
  const second =
    "An optional input precedes the body; positional callers must update arguments in languages exposing that order. <unsafe>";
  const direct = required(dimension.findings.find((finding) => finding.id === "method-change"));
  const methodGroup = required(dimension.methodGroups?.[0]);
  methodGroup.deltas = [first, second, first].map((rationale, index) => {
    const findingId = index === 0 ? direct.id : `${direct.id}-${index}`;
    if (index !== 0) dimension.findings.push({ ...direct, id: findingId, rationale });
    return { findingId, field: "kind", before: "lro", after: "basic", rationale };
  });
  const html = renderAssessmentHtml(assessment(dimension));
  assert.ok(
    html.includes(
      `<strong>Why this is breaking:</strong> <ul><li>${first}</li><li>${second.replace("<unsafe>", "&lt;unsafe&gt;")}</li></ul>`,
    ),
  );
  assert.doesNotMatch(html, /<unsafe>/);
});

void test("does not promote grouped type intent associations to each individual type", () => {
  const { dimension, raw } = fixture();
  required(required(dimension.typeImpacts?.[0]).relatedSemanticIntents).push(
    "semantic-for-another-type",
  );
  const data = downstreamMethodData(dimension, raw);
  assert.deepEqual(data.types[0].semanticIds, ["semantic-1"]);
  assert.ok(
    data.methods.every((method) => !method.semanticIds.includes("semantic-for-another-type")),
  );
});

void test("rejects a raw graph from a mismatched evidence or root snapshot", () => {
  const { dimension, raw } = fixture();
  const wrongFact = structuredClone(raw);
  required(required(wrongFact.facts["type-target"]).properties).push({ name: "invented" });
  assert.throws(
    () => downstreamMethodData(dimension, wrongFact),
    /snapshot mismatch: evidence fact/,
  );
  const wrongRoot = structuredClone(raw);
  required(wrongRoot.rootCauses[0]).id = "other-snapshot";
  assert.throws(
    () => downstreamMethodData(dimension, wrongRoot),
    /snapshot mismatch: missing root/,
  );
  const wrongAssociation = structuredClone(raw);
  required(wrongAssociation.rootCauses[0]).directCandidateIds = ["other-finding"];
  assert.throws(
    () => downstreamMethodData(dimension, wrongAssociation),
    /no matching confirmed finding/,
  );
  const wrongCandidate = structuredClone(raw);
  required(wrongCandidate.candidates[0]).rule = "different-rule";
  assert.throws(
    () => downstreamMethodData(dimension, wrongCandidate),
    /snapshot mismatch: candidate/,
  );
});

void test("legacy operationGroups and sharedTypeImpacts retain unmapped confirmed types", () => {
  const { dimension } = fixture();
  dimension.operationGroups = dimension.methodGroups;
  delete dimension.methodGroups;
  dimension.sharedTypeImpacts = required(dimension.typeImpacts).map(({ type, ...impact }) => ({
    ...impact,
    types: type ? [type] : [],
    affectedMethods: [],
    affectedMethodCount: 0,
  }));
  delete dimension.typeImpacts;
  const data = downstreamMethodData(dimension);
  assert.equal(data.methods[0].cause, "direct");
  assert.equal(data.unmapped[0].type, "Contoso.Widget");
  assert.equal(data.unmapped[0].findings[0].id, "type-change");
  const html = renderAssessmentHtml(assessment(dimension));
  assert.match(html, /Method mapping unavailable/);
  assert.match(html, /Downstream: Widget \(SDK type\)/);
});

void test("normalized method inputs exclude constants, retain locations and preserve unknown returns", () => {
  const { dimension } = fixture();
  const methodGroup = required(dimension.methodGroups?.[0]);
  const before = required(methodGroup.before);
  before.parameters = required(before.parameters).filter(
    (parameter) => parameter.name !== "afcManagedSync",
  );
  before.responseType = /** @type {AssessmentFact["responseType"]} */ (
    /** @type {unknown} */ (null)
  );
  const html = renderAssessmentHtml(assessment(dimension));
  assert.match(html, /1\. name \(path\): string/);
  assert.match(html, /2\. afcManagedSync\? \(query\): boolean/);
  assert.match(html, /3\. parameters \(body input\): Widget/);
  assert.doesNotMatch(html, /4\. contentType/);
  assert.match(html, /Constant headers \(not numbered caller inputs\)/);
  assert.match(html, /Content-Type \(header\): &quot;application\/json&quot;/);
  assert.match(html, /Return type \(body output\)/);
  assert.equal(sdkTypeName(undefined), "Not recorded");
  assert.equal(sdkTypeName(null), "void");
  const group = required(dimension.methodGroups?.[0]);
  delete required(group.before).responseType;
  required(group.after).responseType = /** @type {AssessmentFact["responseType"]} */ (
    /** @type {unknown} */ (null)
  );
  const rows = required(downstreamMethodData(dimension).methods.find((item) => item.group)).rows;
  assert.deepEqual(rows.at(-1), {
    area: "SDK method",
    label: "Return type (body output)",
    before: "Not recorded",
    after: "void",
  });
});

void test("comparison tables omit identical fields while retaining actual changes and evidence", () => {
  const { dimension } = fixture();
  const original = structuredClone(dimension);
  const html = renderAssessmentHtml(assessment(dimension));
  assert.doesNotMatch(
    html,
    /<strong>Normalized input order<\/strong>|<strong>Return type \(body output\)<\/strong>/,
  );
  assert.match(html, /<strong>Normalized method name<\/strong>/);
  assert.match(html, /<strong>Method kind<\/strong>/);
  assert.match(html, /Why this is breaking/);
  for (const [, before, after] of html.matchAll(
    /<tr><td>[\s\S]*?<\/td><td><pre>([\s\S]*?)<\/pre><\/td><td><pre>([\s\S]*?)<\/pre><\/td><\/tr>/g,
  )) {
    assert.notEqual(before, after);
  }
  assert.deepEqual(dimension, original);
});

void test("comparison tables are omitted when all their fields are unchanged", () => {
  const { dimension } = fixture();
  const group = required(dimension.methodGroups?.[0]);
  const before = required(group.before);
  const after = required(group.after);
  before.name = after.name;
  before.kind = after.kind;
  const delta = required(group.deltas[0]);
  delta.before = delta.after;
  delta.rationale = "Retained recorded explanation.";
  dimension.typeImpacts = [];
  dimension.findings = dimension.findings.filter((finding) => finding.id === "method-change");
  const html = renderAssessmentHtml(assessment(dimension));
  const downstream = reportSection(html, "downstream-breaking");
  assert.doesNotMatch(downstream, /class="report-table"|<tbody><\/tbody>/);
  assert.match(downstream, /Why this is breaking/);
});

void test("semantic relationships are static, title-based and independent of operations", () => {
  const { dimension } = fixture();
  const html = renderAssessmentHtml(assessment(dimension));
  const semantic = reportSection(html, "semantic-intents");
  const summary = requiredMatch(
    semantic,
    /<details class="report-card intent"[^>]*>(<summary>[\s\S]*?<\/summary>)/,
    1,
  );
  assert.match(summary, /Impacts \(2\)/);
  assert.match(summary, /Downstream: ServiceGateways\.updateAddressLocations/);
  assert.doesNotMatch(summary, /Affected operations|SDK:|<button|>semantic-1</);
  assert.ok(semantic.indexOf("Changed TypeSpec source") < semantic.indexOf("Affected operations"));
  assert.match(semantic, /<details class="report-source" open>/);
  assert.doesNotMatch(semantic, /<details class="report-subdetails"[^>]* open/);
  const methods = reportSection(html, "downstream-breaking");
  const header = requiredMatch(methods, /<summary>[\s\S]*?<\/summary>/);
  assert.match(header, />Change the widget contract<\/a>/);
});

void test("fragment handlers reveal nested details without toggling relation labels", () => {
  const html = renderAssessmentHtml(assessment());
  const script = requiredMatch(html, /<script>([\s\S]*?)<\/script>/i, 1);
  /** @type {Record<string, (event?: {target?: Element, preventDefault?: () => void}) => unknown>} */
  const listeners = {};
  const outer = { tagName: "DETAILS", open: false, parentElement: null };
  const inner = { tagName: "DETAILS", open: false, parentElement: outer };
  let scrolls = 0;
  const target = { tagName: "SPAN", parentElement: inner, scrollIntoView: () => scrolls++ };
  class Element {
    /** @param {string} kind */
    constructor(kind) {
      this.kind = kind;
    }
    /** @param {string} selector */
    closest(selector) {
      if (selector.includes("report-intent-relations")) return this.kind !== "title" ? this : null;
      if (selector === "a" || selector === 'a[href^="#"]')
        return this.kind === "link" ? this : null;
      return null;
    }
    /** @returns {string} */
    getAttribute() {
      return "#target";
    }
  }
  const context = {
    Element,
    location: { hash: "#target" },
    document: {
      /** @param {string} id */
      getElementById: (id) => (id === "target" ? target : null),
      /** @param {string} event @param {(event?: {target?: Element, preventDefault?: () => void}) => unknown} callback */
      addEventListener: (event, callback) => {
        listeners[event] = callback;
      },
    },
    window: {
      /** @param {string} event @param {(event?: {target?: Element, preventDefault?: () => void}) => unknown} callback */
      addEventListener: (event, callback) => {
        listeners[event] = callback;
      },
      /** @param {() => unknown} callback */
      setTimeout: (callback) => callback(),
    },
  };
  vm.runInNewContext(script, context);
  assert.equal(outer.open, true);
  assert.equal(inner.open, true);
  outer.open = inner.open = false;
  let prevented = false;
  listeners.click({
    target: new Element("label"),
    preventDefault: () => {
      prevented = true;
    },
  });
  assert.equal(prevented, true);
  assert.equal(inner.open, false);
  prevented = false;
  listeners.click({
    target: new Element("title"),
    preventDefault: () => {
      prevented = true;
    },
  });
  assert.equal(prevented, false);
  listeners.click({ target: new Element("link"), preventDefault: () => {} });
  assert.equal(inner.open, true);
  assert.equal(scrolls, 2);
});

void test("retains every finding anchor and escapes intent and source text", () => {
  const { dimension, raw } = fixture();
  const input = assessment(dimension);
  const semanticItem = required(input.dimensions.semantic.items[0]);
  semanticItem.title = '<img src=x onerror="alert(1)">';
  required(required(semanticItem.sources[0]).hunks[0]).lines = [
    '+ "</script><script>alert(1)</script>"',
  ];
  const html = renderAssessmentHtml(input, { downstreamInput: raw });
  assert.doesNotMatch(html, /<img src=x|<script>alert/);
  assert.match(html, /&lt;img src=x onerror=&quot;alert\(1\)&quot;&gt;/);
  const ids = [...html.matchAll(/\bid="([^"]+)"/g)].map((match) => match[1]);
  assert.equal(ids.length, new Set(ids).size);
  for (const finding of dimension.findings) assert.ok(ids.includes(`finding-${finding.id}`));
  for (const [, id] of html.matchAll(/href="#([^"]+)"/g))
    assert.ok(ids.includes(id), `Missing anchor ${id}`);
});

void recordedAssessmentTest(
  "guideline cards retain every recorded diff once with distinct expected and actual sections",
  () => {
    const input = readAssessment(
      new URL("../evals/assessments/44742/assessment.json", import.meta.url),
    );
    const first = required(input.dimensions.compliance.findings[0]);
    first.actual = required(required(first.codeSnippets)[0]).lines?.join("\n") ?? "";
    const intent = input.dimensions.compliance.intentAssessments.find(
      (item) => item.semanticIntentId === first.semanticIntentId,
    );
    required(intent).actual = first.actual;
    const html = renderAssessmentHtml(input);
    const guidelines = reportSection(html, "azure-compliance");
    assert.equal((guidelines.match(/<h3>Expected<\/h3>/g) ?? []).length, 1);
    assert.equal((guidelines.match(/<h3>Actual<\/h3>/g) ?? []).length, 1);
    assert.equal(
      (guidelines.match(/class="diff"/g) ?? []).length,
      input.dimensions.compliance.findings.reduce(
        (count, finding) =>
          count +
          new Set((finding.codeSnippets ?? []).map((snippet) => JSON.stringify(snippet))).size,
        0,
      ),
    );
    assert.doesNotMatch(
      guidelines,
      /<table|comparison-details|class="severity|>high<|>medium<|>low</,
    );
    assert.match(guidelines, /class="remove"/);
    const firstBody = guidelines.slice(
      guidelines.indexOf(`id="compliance-finding-${first.id}"`),
      guidelines.indexOf(`id="compliance-finding-${input.dimensions.compliance.findings[1].id}"`),
    );
    assert.doesNotMatch(firstBody, /<p>-/);
    assert.equal(
      (firstBody.match(/class="diff"/g) ?? []).length,
      required(first.codeSnippets).length,
    );
    const semantic = reportSection(html, "semantic-intents");
    assert.match(semantic, /class="report-link" href="#compliance-finding-[^"]+">Azure Guidelines/);
    assert.ok(
      html.includes(
        '.report-link.impact,.report-link[href^="#compliance-finding-"]{color:#b91c1c;border-color:#fecaca;background:#fff1f2}',
      ),
    );
    assert.ok(
      html.includes(
        '.report-link.impact,.report-link[href^="#compliance-finding-"]{color:#fecaca;border-color:#7f1d1d;background:#431f29}',
      ),
    );
    for (const [, header] of semantic.matchAll(
      /<details class="report-card intent"[^>]*>(<summary>[\s\S]*?<\/summary>)/g,
    )) {
      const impacts = Number(header.match(/Impacts \((\d+)\)/)?.[1] ?? 0);
      assert.equal(impacts, (header.match(/class="report-link impact"/g) ?? []).length);
      assert.doesNotMatch(header, /class="report-link impact"[^>]*>Azure Guidelines/);
    }
  },
);

void test("five dimension headers and empty not-assessed states use the shared layout", () => {
  const input = assessment();
  input.dimensions.rest.status = "not-assessed";
  input.dimensions.rest.blockers = ["REST evidence unavailable."];
  input.dimensions.downstream.status = "not-assessed";
  input.dimensions.downstream.blockers = ["Downstream evidence unavailable."];
  input.safety.status = "not-assessed";
  const html = renderAssessmentHtml(input);
  assert.equal((html.match(/class="report-section-head"/g) ?? []).length, 5);
  assert.match(html, /REST breaking changes were not fully assessed/);
  assert.match(html, /Downstream breaking changes were not fully assessed/);
  assert.match(html, /Azure Guidelines could not be fully assessed/);
  const quality = reportSection(html, "document-quality");
  assert.match(quality, /not assessed/);
  assert.match(quality, /report-badge add">passed/);
  assert.match(quality, /0 findings/);
  assert.match(html, /@media\s*\(max-width:\s*760px\)/);
  assert.match(html, /@media\s*\(prefers-color-scheme:\s*dark\)/);
  assert.match(html, /grid-template-columns:\s*minmax\(0,\s*1fr\)\s+max-content/);
});

void test("legacy type findings remain visible when method mappings are unavailable", () => {
  const { dimension } = fixture();
  dimension.findings = dimension.findings.filter((finding) => finding.id === "type-change");
  dimension.methodGroups = [];
  const typeImpact = required(dimension.typeImpacts?.[0]);
  typeImpact.affectedMethods = [];
  typeImpact.affectedMethodCount = 0;
  const snapshot = structuredClone(dimension);
  const data = downstreamMethodData(dimension);
  assert.equal(data.methods.length, 0);
  assert.equal(data.unmapped.length, 1);
  assert.deepEqual(
    data.unmapped.flatMap((type) => type.findings.map((finding) => finding.id)),
    ["type-change"],
  );
  assert.ok(data.unmapped.every((type) => type.mapped.length === 0));
  const html = renderAssessmentHtml(assessment(dimension));
  assert.match(html, /Method mapping unavailable/);
  assert.match(html, /id="finding-type-change"/);
  assert.deepEqual(dimension, snapshot);
});

void test("explicit provenance sidecar bridges only root IDs and never changes authoritative data", () => {
  const { dimension, raw } = fixture();
  const input = assessment(dimension);
  input.repository = { remoteUrl: "https://github.com/Azure/azure-rest-api-specs" };
  const replay = structuredClone(input);
  input.dimensions.downstream.findings[0].rootCauseIds = ["unresolved-root"];
  required(input.dimensions.downstream.typeImpacts?.[0]).rootCauseIds = ["unresolved-root"];
  const snapshots = structuredClone({ input, replay, raw });
  assert.throws(
    () => downstreamMethodData(input.dimensions.downstream, raw),
    /missing root unresolved-root/,
  );
  const presentation = downstreamPresentationDimension(input, {
    downstreamInput: raw,
    downstreamAssessment: replay,
  });
  const data = downstreamMethodData(presentation, raw);
  assert.equal(data.methods.length, 2);
  assert.equal(data.unmapped.length, 0);
  assert.deepEqual(presentation.findings[0].rootCauseIds, ["root"]);
  const html = renderAssessmentHtml(input, { downstreamInput: raw, downstreamAssessment: replay });
  assert.match(html, /Representative method paths from recorded graph edges/);
  assert.deepEqual({ input, replay, raw }, snapshots);
  const wrongJudgment = structuredClone(replay);
  wrongJudgment.dimensions.downstream.findings[0].rationale = "Different judgment";
  assert.throws(
    () =>
      downstreamPresentationDimension(input, {
        downstreamInput: raw,
        downstreamAssessment: wrongJudgment,
      }),
    /provenance mismatch: finding/,
  );
  const wrongCommit = structuredClone(replay);
  wrongCommit.comparison.headCommit = "different";
  assert.throws(
    () =>
      downstreamPresentationDimension(input, {
        downstreamInput: raw,
        downstreamAssessment: wrongCommit,
      }),
    /repository or comparison/,
  );
  const missingFinding = structuredClone(replay);
  missingFinding.dimensions.downstream.findings.pop();
  assert.throws(
    () =>
      downstreamPresentationDimension(input, {
        downstreamInput: raw,
        downstreamAssessment: missingFinding,
      }),
    /finding coverage/,
  );
  assert.throws(
    () => downstreamPresentationDimension(input, { downstreamAssessment: replay }),
    /requires downstreamInput/,
  );
});

/**
 * @param {"pass" | "fail" | "not-assessed"} [decision]
 * @returns {TestDocumentQualityDimension}
 */
function documentDimension(decision = "fail") {
  const document = {
    id: "doc-widget",
    sourceChangeId: "source-widget",
    qualifiedName: "Contoso.Widget.count",
    kind: "property",
    before: {
      doc: "The number of widgets.",
      declaration: '@doc("The number of widgets.")\ncount: int32;',
      source: { path: "models.tsp", revision: "base", startLine: 4, endLine: 5 },
    },
    after: {
      doc: "The number of widgets.",
      declaration: '@doc("The number of widgets.")\n@minValue(1)\ncount: int32;',
      source: { path: "models.tsp", revision: "current", startLine: 4, endLine: 6 },
    },
  };
  const check = {
    reviewUnitId: "semantic-1",
    documentId: document.id,
    check: "meaning",
    decision,
    title: "Widget count documentation omits the positive-only constraint",
    expected: "Describe the count as a positive integer.",
    rationale: "The declaration now excludes zero; the doc does not explain this constraint.",
    docQuote: "The number of widgets.",
  };
  const status = decision === "pass" ? "passed" : decision === "fail" ? "failed" : "not-assessed";
  return /** @type {TestDocumentQualityDimension} */ (
    /** @type {unknown} */ ({
      status,
      summary: "Recorded @doc meaning assessment.",
      coverage: {
        semanticIntentCount: 1,
        assessedIntentCount: decision === "not-assessed" ? 0 : 1,
        documentCount: 1,
        assessedDocumentCount: decision === "not-assessed" ? 0 : 1,
        checkCount: 1,
        assessedCheckCount: decision === "not-assessed" ? 0 : 1,
        unassessedIntentIds: decision === "not-assessed" ? ["semantic-1"] : [],
        notApplicableIntentIds: [],
      },
      intentAssessments: [
        { reviewUnitId: "semantic-1", status, documents: [document], checks: [check] },
      ],
      findings:
        decision === "fail"
          ? [
              {
                ...check,
                id: "document-finding-widget",
                actual: document.after.doc,
                document,
                semanticIntentIds: ["semantic-1"],
                sources: [],
              },
            ]
          : [],
      blockers: [],
    })
  );
}

/**
 * @param {DocumentQualityDimension} dimension
 * @param {TestDownstreamDimension} [downstream]
 * @param {SourceChange[] | DocumentationSourceFixture[]} [sources]
 */
function presentationWithDocuments(dimension, downstream, sources) {
  const input = assessment(downstream);
  input.dimensions.documentQuality = dimension;
  if (sources) {
    required(input.dimensions.semantic.items[0]).sources = /** @type {SourceChange[]} */ (
      /** @type {unknown} */ (sources)
    );
  }
  const report = renderReportSections(input, reportRenderHelpers);
  return `${report.html}<section id="appendix"><details><summary>Appendix</summary>${report.appendixHtml}</details></section>`;
}

/** @param {string} html */
function documentationSections(html) {
  return {
    main: reportSection(html, "document-quality"),
    appendix: reportSection(html, "appendix"),
  };
}

/** @param {string} html */
function assertNoDocumentAppendixUi(html) {
  const body = html.includes("<main") ? html.slice(html.indexOf("<main")) : html;
  assert.doesNotMatch(
    body,
    /documentation-review-appendix|document-quality-passed-group|document-quality-not-assessed-group|document-quality-file|class="document-quality-document"/,
  );
}

function referencedDocumentationFixture() {
  const dimension = documentDimension();
  dimension.assessmentVersion = 2;
  const unit = dimension.intentAssessments?.[0];
  assert.ok(unit);
  const document = unit.documents?.[0];
  assert.ok(document);
  Object.assign(document, {
    qualifiedName: "Contoso.Response.body",
    before: null,
    after: {
      doc: "Empty response body.",
      declaration: "/** Empty response body. */\n@body\nbody: ResponseBody;",
      source: { path: "models.tsp", revision: "current", startLine: 69, endLine: 71 },
    },
  });
  const related = {
    id: "doc-response-body",
    sourceChangeId: document.sourceChangeId,
    qualifiedName: "Contoso.ResponseBody",
    kind: "model",
    before: null,
    after: {
      doc: "Empty success response.",
      declaration:
        '@doc("Empty success response.")\nmodel ResponseBody {\n  /** Operation status. */\n  @visibility(Lifecycle.Read)\n  status?: string;\n}',
      source: { path: "models.tsp", revision: "current", startLine: 56, endLine: 61 },
    },
  };
  unit.documents.push(related);
  const check = unit.checks?.[0];
  const finding = dimension.findings?.[0];
  assert.ok(check);
  assert.ok(finding);
  check.check = finding.check = "description";
  unit.checks?.push(
    /** @type {DocumentQualityDecision} */ (
      /** @type {unknown} */ ({
        documentId: related.id,
        check: "description",
        decision: "pass",
        rationale: "Not displayed.",
      })
    ),
  );
  const sources = [
    {
      id: document.sourceChangeId,
      path: "models.tsp",
      declarations: [document, related].map((item) => ({
        kind: item.kind,
        qualifiedName: item.qualifiedName.replace("Contoso.", ""),
        source: { ...item.after.source },
        compilerEvidence: {
          kind: "semantic-type",
          referencedNames:
            item === document
              ? ["ResponseBody", "ResponseBody.status", "string"]
              : ["ResponseBody.status", "string"],
        },
      })),
    },
  ];
  return { dimension, sources, document, related };
}

void test("new documentation failures show current code full-width with referenced model evidence", () => {
  const { dimension, sources, document, related } = referencedDocumentationFixture();
  const original = structuredClone({ dimension, sources });
  const html = presentationWithDocuments(dimension, undefined, sources);
  const main = documentationSections(html).main;
  const card = main.slice(main.indexOf('id="document-quality-document-finding-widget"'));
  assert.match(card, /class="report-document-snapshots single-snapshot"/);
  assert.match(card, /<h4>Current declaration<\/h4>/);
  assert.doesNotMatch(card, /No before snapshot|<h4>Before<\/h4>/);
  assert.match(card, /Related type definitions/);
  assert.ok(card.includes(escapeHtml(document.after.declaration)));
  assert.ok(card.includes(escapeHtml(related.after.declaration)));
  assert.match(card, /status\?: string;/);
  assert.match(card, /models.tsp:56-61 \(current\)/);
  assert.equal((card.match(/model ResponseBody/g) ?? []).length, 1);
  assert.deepEqual({ dimension, sources }, original);
});

void test("documentation type context never substitutes current source into a baseline snapshot", () => {
  const { dimension, sources, document } = referencedDocumentationFixture();
  document.before = {
    ...structuredClone(document.after),
    source: { ...document.after.source, revision: "base" },
  };
  const html = presentationWithDocuments(dimension, undefined, sources);
  const card = documentationSections(html).main;
  assert.doesNotMatch(card, /single-snapshot/);
  assert.doesNotMatch(
    card.slice(0, card.indexOf("<h4>After</h4>")),
    /Related type definitions|model ResponseBody/,
  );
  assert.match(card.slice(card.indexOf("<h4>After</h4>")), /Related type definitions/);
});

void test("documentation context requires unambiguous compiler references and exact source ownership", () => {
  /** @type {((fixture: ReturnType<typeof referencedDocumentationFixture>) => void)[]} */
  const invalidations = [
    ({ sources }) => {
      sources[0].declarations[0].compilerEvidence.referencedNames = [];
    },
    ({ sources }) => {
      sources[0].declarations[1].source.revision = "base";
    },
    ({ sources, related }) => {
      sources[0].declarations[1].source.revision = related.after.source.revision = "base";
    },
    ({ sources }) => {
      sources[0].declarations[1].source.startLine = 1;
    },
    ({ related }) => {
      related.after.source.path = "different.tsp";
    },
    ({ dimension, sources, related }) => {
      const duplicate = structuredClone(related);
      duplicate.id = "ambiguous-doc";
      duplicate.qualifiedName = "Other.ResponseBody";
      duplicate.sourceChangeId = "other-source";
      duplicate.after.source.path = "other.tsp";
      dimension.intentAssessments[0].documents.push(duplicate);
      sources.push({
        id: "other-source",
        path: "other.tsp",
        declarations: [{ ...sources[0].declarations[1], source: { ...duplicate.after.source } }],
      });
    },
  ];
  for (const invalidate of invalidations) {
    const fixture = referencedDocumentationFixture();
    invalidate(fixture);
    const html = presentationWithDocuments(fixture.dimension, undefined, fixture.sources);
    assert.doesNotMatch(html, /Related type definitions/);
  }
});

void test("document issues use doc-first collapsed cards and nonduplicated intent links", () => {
  const dimension = documentDimension();
  const original = structuredClone(dimension);
  const html = presentationWithDocuments(dimension);
  const quality = reportSection(html, "document-quality");
  const header = requiredMatch(
    quality,
    /<details class="report-card document-quality-check"[^>]*>(<summary>[\s\S]*?<\/summary>)/,
    1,
  );
  assert.match(header, /Widget count documentation omits the positive-only constraint/);
  assert.match(header, /<strong><span title="Contoso.Widget.count">Widget.count<\/span><\/strong>/);
  assert.doesNotMatch(header, /Affected intents|href="#intent-semantic-1"/);
  assert.match(quality, /href="#intent-semantic-1">Change the widget contract/);
  assert.doesNotMatch(header, /<pre>|Expected|<table|>semantic-1</);
  assert.match(quality, /<h3>Suggested change<\/h3><p>Describe the count as a positive integer\./);
  assert.match(quality, /<h3>Current description<\/h3>/);
  assert.match(quality, /<blockquote><mark>The number of widgets\.<\/mark><\/blockquote>/);
  assert.ok(quality.indexOf("<blockquote>") < quality.indexOf("<h3>Why this needs attention"));
  assert.ok(
    quality.indexOf("<h3>Why this needs attention") < quality.indexOf("<h3>Suggested change"),
  );
  assert.ok(quality.indexOf("<h3>Suggested change") < quality.indexOf("View supporting TypeSpec"));
  assert.match(
    quality,
    /<details class="report-subdetails document-quality-source"><summary>View supporting/,
  );
  const finding = dimension.findings?.[0];
  assert.ok(finding?.document);
  for (const side of /** @type {const} */ (["before", "after"])) {
    const value = finding.document[side];
    assert.ok(value);
    assert.ok(quality.includes(`<code>${escapeHtml(value.declaration)}</code>`));
    assert.ok(quality.includes(`models.tsp:4-${value.source.endLine} (${value.source.revision})`));
  }
  assert.match(quality, /Why this needs attention/);
  assert.equal((quality.match(/<pre><code>/g) ?? []).length, 2);
  assert.doesNotMatch(quality, /Recorded @doc text/);
  assert.doesNotMatch(
    quality,
    /<table|class="severity|>high<|>medium<|>low<|document-quality-check"[^>]* open/,
  );
  const semantic = reportSection(html, "semantic-intents");
  assert.match(semantic, /aria-label="Documentation Completeness findings"/);
  assert.match(semantic, /Documentation Completeness: Widget count documentation/);
  assert.match(semantic, /Impacts \(1\)/);
  assert.match(
    semantic,
    /class="report-link impact" href="#document-quality-document-finding-widget"/,
  );
  const ids = [...html.matchAll(/\bid="([^"]+)"/g)].map((match) => match[1]);
  assert.equal(ids.length, new Set(ids).size);
  for (const [, id] of html.matchAll(/href="#([^"]+)"/g))
    assert.ok(ids.includes(id), `Missing document relation ${id}`);
  assert.deepEqual(dimension, original);
});

void test("document summary API keeps coverage detail while HTML omits removed appendix content", () => {
  const passed = documentDimension("pass");
  passed.intentAssessments[0].checks[0].title = "Widget count meaning is accurate";
  const passedHtml = presentationWithDocuments(passed);
  assert.match(documentQualitySummary(passed).detail, /1\/1 checks assessed/);
  assert.match(documentQualitySummary(passed).detail, /1\/1 descriptions assessed/);
  assert.match(documentationSections(passedHtml).main, /0 findings · 1 description assessed/);
  assertNoDocumentAppendixUi(passedHtml);
  assert.equal(documentQualitySummary(passed).label, "Passed");
  const noDocs = /** @type {DocumentQualityDimension} */ (
    /** @type {unknown} */ ({
      status: "passed",
      summary: "No applicable @doc on this changed declaration.",
      coverage: {
        semanticIntentCount: 1,
        assessedIntentCount: 1,
        documentCount: 0,
        assessedDocumentCount: 0,
        checkCount: 0,
        assessedCheckCount: 0,
        unassessedIntentIds: [],
        notApplicableIntentIds: ["semantic-1"],
      },
      intentAssessments: [
        {
          reviewUnitId: "semantic-1",
          status: "not-applicable",
          reason: "No @doc is attached to the changed declaration.",
          documents: [],
          checks: [],
        },
      ],
      findings: [],
      blockers: [],
    })
  );
  const noDocsHtml = presentationWithDocuments(noDocs);
  assert.match(documentQualitySummary(noDocs).detail, /0\/0 checks assessed/);
  assert.match(documentQualitySummary(noDocs).detail, /1 intents with no applicable description/);
  assert.doesNotMatch(noDocsHtml, /No @doc is attached to the changed declaration/);
  assert.equal(documentQualitySummary(noDocs).label, "No applicable documentation");
  const noDocsQuality = reportSection(noDocsHtml, "document-quality");
  assert.match(noDocsQuality, /report-badge add">passed/);
  assert.match(noDocsQuality, /0 findings · 0 descriptions assessed/);
  assert.doesNotMatch(noDocsQuality, /No applicable documentation/);
  assertNoDocumentAppendixUi(noDocsHtml);
  assert.doesNotMatch(noDocsHtml, /Document Quality and Agent Friendliness is not assessed/);
  const legacy = presentationWithDocuments({
    status: "not-assessed",
    summary: "Historical documentation evidence unavailable.",
  });
  const legacyQuality = reportSection(legacy, "document-quality");
  assert.match(legacyQuality, /0 findings · Assessment count unavailable/);
  assert.doesNotMatch(legacyQuality, /checks assessed|Not reviewed/);
  assertNoDocumentAppendixUi(legacy);
  assert.equal(documentQualitySummary().label, "Not assessed");
});

void test("documentation completeness summarizes compiler declaration presence", () => {
  const dimension = /** @type {DocumentQualityDimension} */ (
    /** @type {unknown} */ ({
      assessmentVersion: 4,
      status: "failed",
      coverage: {
        semanticIntentCount: 2,
        assessedIntentCount: 2,
        declarationCount: 5,
        documentedDeclarationCount: 3,
        missingDeclarationCount: 2,
        unassessedIntentIds: [],
        notApplicableIntentIds: [],
      },
      findings: [{}, {}],
    })
  );
  const summary = documentQualitySummary(dimension);
  assert.deepEqual(summary.compactDetail, ["2 findings", "5 declarations checked"]);
  assert.match(summary.detail, /3\/5 declarations documented/);
});

void test("v5 documentation findings show the exact TypeSpec declaration", () => {
  const dimension = /** @type {DocumentQualityDimension} */ (
    /** @type {unknown} */ ({
      assessmentVersion: 5,
      status: "failed",
      coverage: {
        semanticIntentCount: 1,
        assessedIntentCount: 1,
        declarationCount: 1,
        documentedDeclarationCount: 0,
        missingDeclarationCount: 1,
        unassessedIntentIds: [],
        notApplicableIntentIds: [],
      },
      intentAssessments: [],
      findings: [
        {
          id: "document-finding-widget",
          reviewUnitId: "semantic-1",
          title: "Missing documentation for Widgets",
          actual: "The TypeSpec compiler returned no nonempty documentation for this declaration.",
          expected: "Add a nonempty TypeSpec documentation description.",
          semanticIntentIds: ["semantic-1"],
          sources: [{ path: "widgets.tsp" }],
          declaration: {
            qualifiedName: "Widgets",
            source: { startLine: 3, endLine: 5 },
          },
          codeSnippet: {
            path: "widgets.tsp",
            startLine: 3,
            endLine: 5,
            lines: ["@armResourceOperations", "interface Widgets {", "}"],
            truncated: false,
          },
        },
      ],
      blockers: [],
    })
  );
  const quality = reportSection(presentationWithDocuments(dimension), "document-quality");
  assert.match(
    quality,
    /<details class="report-subdetails document-quality-source"><summary>View TypeSpec declaration missing a description<\/summary>/,
  );
  assert.doesNotMatch(quality, /document-quality-source" open/);
  assert.match(quality, /widgets\.tsp:3-5/);
  assert.match(quality, /@armResourceOperations\ninterface Widgets \{\n\}/);
  assert.doesNotMatch(quality, /View supporting TypeSpec location/);
});

void test("41 passing descriptions stay out of HTML while summary data remains intact", () => {
  const dimension = documentDimension("pass");
  dimension.assessmentVersion = 3;
  const intent = dimension.intentAssessments[0];
  const document = intent.documents[0];
  const check = intent.checks[0];
  intent.documents = Array.from({ length: 41 }, (_, index) => ({
    ...document,
    id: `document-${index}`,
    qualifiedName: `Contoso.Model${index}`,
    kind: "model",
  }));
  intent.checks = intent.documents.map((item) => ({
    ...check,
    documentId: item.id,
    check: "description",
    rationale: "Individual passing rationale.",
  }));
  Object.assign(dimension.coverage, {
    documentCount: 41,
    assessedDocumentCount: 41,
    checkCount: 41,
    assessedCheckCount: 41,
  });
  const original = structuredClone(dimension);
  const html = presentationWithDocuments(dimension);
  const { main, appendix: quality } = documentationSections(html);
  assert.doesNotMatch(main, /document-quality-intent|document-quality-check/);
  assert.equal(
    quality,
    '<section id="appendix"><details><summary>Appendix</summary></details></section>',
  );
  assert.match(main, /0 findings · 41 descriptions assessed/);
  assert.match(documentQualitySummary(dimension).detail, /41\/41 descriptions assessed/);
  assert.match(documentQualitySummary(dimension).detail, /41 descriptions passed/);
  assertNoDocumentAppendixUi(html);
  assert.deepEqual(dimension, original);
});

void test("mixed documentation HTML keeps only failures while summary detail stays unchanged", () => {
  const dimension = documentDimension();
  const intent = dimension.intentAssessments[0];
  const passed = /** @type {DocumentQualityDecision} */ ({
    ...intent.checks[0],
    check: "correctness",
    decision: "pass",
    rationale: "Hidden passing rationale.",
  });
  const pending = /** @type {DocumentQualityDecision} */ ({
    ...intent.checks[0],
    documentId: "document-pending",
    decision: "not-assessed",
    rationale: "Distinct missing contract.",
  });
  intent.checks.push(passed, pending);
  intent.documents.push({
    ...intent.documents[0],
    id: pending.documentId,
    qualifiedName: "Contoso.Pending",
  });
  const html = presentationWithDocuments(dimension);
  const quality = reportSection(html, "document-quality");
  assert.equal((quality.match(/class="report-card document-quality-check"/g) ?? []).length, 1);
  assert.doesNotMatch(quality, /Hidden passing rationale|document-quality-check-summary/);
  assert.match(documentQualitySummary(dimension).detail, /1 legacy checks passed/);
  assert.match(quality, /<h3>Suggested change/);
  assert.doesNotMatch(quality, /Distinct missing contract|Contoso.Pending/);
  assertNoDocumentAppendixUi(html);
  assert.match(quality, /class="report-card document-quality-intent" open/);
  assert.doesNotMatch(quality, /class="report-card document-quality-check"[^>]* open/);
});

void test("failure cards without an intent assessment remain visible with their stable anchors", () => {
  const dimension = documentDimension();
  dimension.intentAssessments = [];
  const html = presentationWithDocuments(dimension);
  assert.match(html, /id="document-quality-document-finding-widget"/);
  assert.match(html, /<h3>Suggested change<\/h3>/);
  assert.match(html, /Widget count documentation omits/);
});

void test("mixed local and inherited coverage does not count inherited descriptions as passed", () => {
  const dimension = documentDimension("pass");
  dimension.assessmentVersion = 3;
  dimension.coverage.inheritedDocumentCount = 2;
  dimension.intentAssessments[0].inheritedDocumentIds = ["inherited-one", "inherited-two"];
  const html = presentationWithDocuments(dimension);
  assert.match(documentQualitySummary(dimension).detail, /1 descriptions passed/);
  assert.match(documentQualitySummary(dimension).detail, /2 inherited descriptions not reviewed/);
  assert.match(documentationSections(html).main, /0 findings · 1 description assessed/);
  assert.doesNotMatch(html, /3 passed|3 local descriptions|inherited descriptions not reviewed/);
  assertNoDocumentAppendixUi(html);
});

void test("blocked intent reasons stay in raw data and are omitted from HTML", () => {
  const dimension = documentDimension("not-assessed");
  const intent = dimension.intentAssessments[0];
  intent.reason = "Unique unresolved declaration.";
  dimension.blockers = [
    { reviewUnitId: intent.reviewUnitId, reason: intent.reason },
    { reason: "Separate source-read failure." },
  ];
  const original = structuredClone(dimension);
  const html = presentationWithDocuments(dimension);
  assert.doesNotMatch(html, /Unique unresolved declaration|Separate source-read failure/);
  assert.deepEqual(dimension, original);
});

void test("mixed documentation HTML omits deleted pass and blocker groups", () => {
  const dimension = documentDimension("fail");
  const passed = documentDimension("pass").intentAssessments[0];
  passed.reviewUnitId = "semantic-pass";
  const pending = documentDimension("not-assessed").intentAssessments[0];
  pending.reviewUnitId = "semantic-pending";
  pending.reason = "Missing <compiler> context.";
  dimension.intentAssessments.unshift(passed, pending);
  dimension.intentAssessments.push({
    reviewUnitId: "semantic-blocked",
    status: "not-assessed",
    reason: "Unresolved documentation ownership.",
    documents: [],
    checks: [],
  });
  Object.assign(dimension.coverage, {
    semanticIntentCount: 4,
    assessedIntentCount: 2,
    checkCount: 3,
    assessedCheckCount: 2,
    unassessedIntentIds: ["semantic-pending", "semantic-blocked"],
  });
  const original = structuredClone(dimension);
  const html = presentationWithDocuments(dimension);
  const quality = reportSection(html, "document-quality");
  assert.match(
    quality,
    /<div class="document-quality-scope"><details class="report-card document-quality-intent" open>/,
  );
  assertNoDocumentAppendixUi(html);
  assert.match(documentQualitySummary(dimension).detail, /1 legacy checks passed/);
  assert.match(documentQualitySummary(dimension).detail, /2 intent scopes incomplete/);
  assert.doesNotMatch(html, /Missing &lt;compiler&gt; context|Unresolved documentation ownership/);
  assert.deepEqual(dimension, original);
});

void test("HTML stays findings-based while summary detail distinguishes blocked and non-applicable scopes", () => {
  const dimension = documentDimension("pass");
  dimension.assessmentVersion = 3;
  dimension.status = "not-assessed";
  dimension.intentAssessments.push(
    {
      reviewUnitId: "semantic-blocked",
      status: "not-assessed",
      reason: "Unresolved documentation ownership.",
      documents: [],
      checks: [],
    },
    {
      reviewUnitId: "semantic-empty",
      status: "not-applicable",
      reason: "No local description.",
      documents: [],
      checks: [],
    },
  );
  Object.assign(dimension.coverage, {
    semanticIntentCount: 3,
    assessedIntentCount: 2,
    unassessedIntentIds: ["semantic-blocked"],
    notApplicableIntentIds: ["semantic-empty"],
  });
  const html = presentationWithDocuments(dimension);
  const main = documentationSections(html).main;
  assert.match(documentQualitySummary(dimension).detail, /2\/3 intent scopes resolved/);
  assert.match(
    documentQualitySummary(dimension).detail,
    /1 intents with no applicable description/,
  );
  assert.equal(documentQualitySummary(dimension).label, "Not assessed");
  assert.match(main, /class="report-badge add">passed/);
  assert.doesNotMatch(main, /No applicable documentation|Not assessed/);
  assert.doesNotMatch(html, /Unresolved documentation ownership|No local description/);
  assertNoDocumentAppendixUi(html);
});

void test("inherited-only documentation is present but not reviewed, never missing or passed", () => {
  const dimension = /** @type {DocumentQualityDimension} */ ({
    assessmentVersion: 3,
    status: "not-applicable",
    summary: "Inherited documentation is present; its quality is not reviewed in v1.",
    coverage: {
      semanticIntentCount: 1,
      assessedIntentCount: 1,
      documentCount: 0,
      assessedDocumentCount: 0,
      checkCount: 0,
      assessedCheckCount: 0,
      inheritedDocumentCount: 1,
      unassessedIntentIds: [],
      notApplicableIntentIds: ["semantic-1"],
    },
    intentAssessments: [
      {
        reviewUnitId: "semantic-1",
        status: "not-applicable",
        reason: "Inherited description not reviewed.",
        documents: [],
        checks: [],
        inheritedDocumentIds: ["document-inherited"],
      },
    ],
    findings: [],
    blockers: [],
  });
  assert.equal(documentQualitySummary(dimension).label, "Inherited documentation not reviewed");
  const html = presentationWithDocuments(dimension);
  const quality = reportSection(html, "document-quality");
  assert.match(quality, /0 findings · 0 descriptions assessed/);
  assert.match(documentQualitySummary(dimension).detail, /1 inherited descriptions not reviewed/);
  assert.doesNotMatch(
    quality,
    /No applicable documentation|no applicable @doc|Assessment blocked|document-quality-check/,
  );
  assertNoDocumentAppendixUi(html);
});

void test("v3 inherited descriptions are labeled and shown separately despite tag-only declaration comments", () => {
  const dimension = documentDimension();
  dimension.assessmentVersion = 3;
  const intent = dimension.intentAssessments[0];
  intent.checks[0].check = dimension.findings[0].check = "description";
  for (const side of /** @type {const} */ (["before", "after"])) {
    Object.assign(required(intent.documents[0][side]), {
      documentationOrigin: "inherited",
      doc: "Gets the <Widget> resource.",
      declaration: "/** @param id Resource identifier. */\nop get is Read<Widget>;",
    });
  }
  const html = presentationWithDocuments(dimension);
  assert.match(html, /title="Contoso.Widget.count">Widget.count<\/span>/);
  assert.match(documentQualitySummary(dimension).detail, /1\/1 descriptions assessed/);
  assert.doesNotMatch(html, /Legacy Correctness|Meaning \(legacy\)/);
  assert.equal((html.match(/<h5>Compiler-resolved inherited description/g) ?? []).length, 2);
  assert.equal((html.match(/Exact associated declaration source/g) ?? []).length, 2);
  assert.equal((html.match(/<code>Gets the &lt;Widget&gt; resource\.<\/code>/g) ?? []).length, 2);
  assert.ok(html.includes(escapeHtml(intent.documents[0].after.declaration)));
  const quality = reportSection(html, "document-quality");
  assert.match(quality, /class="report-card document-quality-intent" open/);
  assert.doesNotMatch(quality, /class="report-card document-quality-check"[^>]*\bopen/);
});

void test("incomplete doc evidence stays out of HTML while summary status remains honest", () => {
  const dimension = documentDimension("not-assessed");
  dimension.intentAssessments[0].documents[0].before = null;
  dimension.intentAssessments[0].reason = "Baseline declaration evidence unavailable.";
  dimension.intentAssessments[0].checks[0].rationale =
    "Meaning cannot be confirmed without the old contract.";
  delete dimension.intentAssessments[0].checks[0].expected;
  dimension.blockers = [{ reason: "Baseline @doc could not be read." }];
  const html = presentationWithDocuments(dimension);
  assert.match(documentQualitySummary(dimension).detail, /0\/1 checks assessed/);
  assert.doesNotMatch(documentationSections(html).main, /report-document-snapshot/);
  assert.doesNotMatch(
    html,
    /Baseline declaration evidence unavailable|Meaning cannot be confirmed without the old contract/,
  );
  assert.doesNotMatch(html, /Expected meaning or contract was not recorded|<h3>Expected<\/h3>/);
  assert.match(html, /Examples, external documentation, and agent execution are not assessed/);
  assertNoDocumentAppendixUi(html);
  assert.equal(documentQualitySummary(dimension).label, "Not assessed");
});

void test("every recorded doc, declaration, issue, rationale and source label is HTML escaped", () => {
  const dimension = documentDimension();
  const attack = '</code><img src=x onerror="alert(1)">&\'';
  const finding = dimension.findings[0];
  finding.title = finding.expected = finding.rationale = finding.actual = attack;
  finding.document.qualifiedName = attack;
  finding.document.after.doc = finding.document.after.declaration = attack;
  finding.document.after.source.path = attack;
  dimension.summary = attack;
  dimension.blockers = [{ message: attack }];
  const html = presentationWithDocuments(dimension);
  assert.doesNotMatch(html, /<img src=x|onerror="alert/);
  assert.ok(html.includes(escapeHtml(attack)));
  assert.ok(html.includes(`<code>${escapeHtml(attack)}</code>`));
  assert.ok(html.includes(`<span title="${escapeHtml(attack)}">${escapeHtml(attack)}</span>`));
});

void test("failed documentation links use the failure-impact style and contribute to semantic impact counts", () => {
  const { dimension } = fixture();
  const documentation = documentDimension();
  const second = structuredClone(documentation.findings[0]);
  second.id = "document-finding-second";
  second.documentId = second.document.id = "doc-second";
  second.document.qualifiedName = "Contoso.Other.count";
  documentation.findings.push(second);
  documentation.intentAssessments[0].documents.push(second.document);
  documentation.intentAssessments[0].checks.push({
    ...documentation.intentAssessments[0].checks[0],
    documentId: second.documentId,
  });
  const original = structuredClone({ dimension, documentation });
  const html = presentationWithDocuments(documentation, dimension);
  const semantic = reportSection(html, "semantic-intents");
  const header = requiredMatch(
    semantic,
    /<details class="report-card intent"[^>]*>(<summary>[\s\S]*?<\/summary>)/,
    1,
  );
  assert.match(header, /Impacts \(4\)/);
  assert.equal((header.match(/class="report-link impact"/g) ?? []).length, 4);
  assert.equal((header.match(/class="report-link impact"[^>]*>Downstream:/g) ?? []).length, 2);
  assert.match(header, /aria-label="Documentation Completeness findings"/);
  for (const finding of documentation.findings) {
    assert.ok(header.includes(`class="report-link impact" href="#document-quality-${finding.id}"`));
    assert.ok(html.includes(`id="document-quality-${finding.id}"`));
  }
  assertNoDocumentAppendixUi(html);
  assert.deepEqual({ dimension, documentation }, original);
});

void test("passing and incomplete documentation do not create failed semantic impact links or counts", () => {
  const { dimension } = fixture();
  for (const decision of /** @type {const} */ (["pass", "not-assessed"])) {
    const html = presentationWithDocuments(documentDimension(decision), dimension);
    const semantic = reportSection(html, "semantic-intents");
    const header = requiredMatch(
      semantic,
      /<details class="report-card intent"[^>]*>(<summary>[\s\S]*?<\/summary>)/,
      1,
    );
    assert.match(header, /Impacts \(2\)/);
    assert.equal((header.match(/class="report-link impact"/g) ?? []).length, 2);
    assert.doesNotMatch(header, /Documentation Completeness:|href="#document-quality-/);
    assertNoDocumentAppendixUi(html);
    const documentationOnly = presentationWithDocuments(documentDimension(decision));
    const documentationOnlyHeader = requiredMatch(
      reportSection(documentationOnly, "semantic-intents"),
      /<details class="report-card intent"[^>]*>(<summary>[\s\S]*?<\/summary>)/,
      1,
    );
    assert.doesNotMatch(documentationOnlyHeader, /Impacts \(|class="report-link impact"/);
  }
});

void test("failed doc findings keep incomplete-check coverage in the summary API only", () => {
  const dimension = documentDimension();
  const intent = dimension.intentAssessments[0];
  intent.reason = "The meaning review is blocked by missing evidence.";
  intent.checks.push({
    reviewUnitId: intent.reviewUnitId,
    documentId: intent.documents[0].id,
    check: "correctness",
    decision: "not-assessed",
    rationale: "The full contract is unavailable.",
  });
  Object.assign(dimension.coverage, {
    checkCount: 2,
    assessedCheckCount: 1,
    assessedIntentCount: 0,
    assessedDocumentCount: 0,
    unassessedIntentIds: [intent.reviewUnitId],
  });
  const html = presentationWithDocuments(dimension);
  assert.equal(documentQualitySummary(dimension).label, "Failed");
  assert.match(documentQualitySummary(dimension).detail, /1\/2 checks assessed/);
  assert.match(documentQualitySummary(dimension).detail, /0\/1 intent scopes resolved/);
  assert.doesNotMatch(
    html,
    /meaning review is blocked by missing evidence|Documentation not assessed for:|The full contract is unavailable/,
  );
});

void test("document snapshots show exact declaration source once when leading decorators already include @doc", () => {
  for (const declaration of [
    '@doc("The number of widgets.")\ncount: int32;',
    "/** The number of widgets. */\ncount: int32;",
    '/* source context */\n@extension("literal @doc(\\"unrelated\\")")\n@TypeSpec . doc("""\n  The number of widgets.\n  """)\ncount: int32;',
    '@extension(fn("nested"), { value: ")" })\n// context\n@doc ("The number of widgets.")\ncount: int32;',
  ]) {
    const dimension = documentDimension();
    dimension.findings[0].document.after.declaration = declaration;
    const html = presentationWithDocuments(dimension);
    const quality = reportSection(html, "document-quality");
    assert.equal((quality.match(/<pre><code>/g) ?? []).length, 2);
    assert.equal(
      quality.split(`<code>${escapeHtml(declaration)}</code>`).length - 1,
      declaration === required(dimension.findings[0].document.before).declaration ? 2 : 1,
    );
    assert.doesNotMatch(quality, /Recorded @doc text/);
  }
});

void test("declarations without their own @doc retain separately recorded doc text without source reconstruction", () => {
  for (const declaration of [
    "count: int32;",
    '/* @doc("comment, not evidence") */\ncount: int32;',
    '@extension("literal @doc(\\"not evidence\\")")\ncount: int32;',
    'model Widget {\n  @doc("Nested property documentation.")\n  count: int32;\n}',
  ]) {
    const dimension = documentDimension();
    const after = dimension.findings[0].document.after;
    after.doc = 'Augmented documentation with <markup> & "quotes".';
    after.declaration = declaration;
    const html = presentationWithDocuments(dimension);
    const quality = reportSection(html, "document-quality");
    assert.match(quality, /Recorded description/);
    assert.ok(quality.includes(`<code>${escapeHtml(after.doc)}</code>`));
    assert.ok(quality.includes(`<code>${escapeHtml(declaration)}</code>`));
    assert.equal((quality.match(/<pre><code>/g) ?? []).length, 3);
    assert.doesNotMatch(quality, /<markup>/);
  }
});

void test("mixed pass and fail descriptions keep only failures in HTML", () => {
  const dimension = documentDimension();
  dimension.assessmentVersion = 3;
  const unit = dimension.intentAssessments[0];
  unit.checks[0].check = dimension.findings[0].check = "description";
  const passed = structuredClone(unit.documents[0]);
  passed.id = "passed-document";
  passed.qualifiedName = "Contoso.PassingModel";
  passed.kind = "model";
  passed.after.source.path = "only-passed.tsp";
  passed.after.doc = "A separately reviewed description.";
  unit.documents.push(passed);
  unit.checks.push(
    /** @type {DocumentQualityDecision} */ (
      /** @type {unknown} */ ({
        documentId: passed.id,
        check: "description",
        decision: "pass",
        rationale: "Complete recorded pass rationale.",
      })
    ),
  );
  Object.assign(dimension.coverage, {
    documentCount: 2,
    assessedDocumentCount: 2,
    checkCount: 2,
    assessedCheckCount: 2,
  });
  const original = structuredClone(dimension);
  const html = presentationWithDocuments(dimension);
  const { main, appendix } = documentationSections(html);
  assert.match(main, /1 finding · 2 descriptions assessed/);
  assert.match(documentQualitySummary(dimension).detail, /2\/2 descriptions assessed/);
  assert.match(documentQualitySummary(dimension).detail, /1 descriptions passed/);
  assert.equal((main.match(/class="report-card document-quality-check"/g) ?? []).length, 1);
  assert.doesNotMatch(
    main,
    /PassingModel|only-passed.tsp|document-quality-file|document-quality-passed-group/,
  );
  assert.equal(
    appendix,
    '<section id="appendix"><details><summary>Appendix</summary></details></section>',
  );
  assertNoDocumentAppendixUi(html);
  assert.equal((html.match(/id="document-quality-document-finding-widget"/g) ?? []).length, 1);
  assert.deepEqual(dimension, original);
});

void test("blocked collected descriptions are omitted from HTML while summary counts stay immutable", () => {
  const dimension = documentDimension("not-assessed");
  dimension.assessmentVersion = 3;
  const unit = dimension.intentAssessments[0];
  unit.checks = [];
  unit.reason =
    "Contoso.Namespace: Cannot establish a supported named declaration context for this @doc.";
  unit.documents[0].after.doc = '  Retained <text> & "quotes".\nNot a judgment.\n';
  Object.assign(dimension.coverage, { documentCount: 0, checkCount: 0, inheritedDocumentCount: 3 });
  dimension.blockers = [{ reviewUnitId: unit.reviewUnitId, reason: unit.reason }];
  const original = structuredClone(dimension);
  const { main, appendix } = documentationSections(presentationWithDocuments(dimension));
  assert.match(main, /0 findings · 0 descriptions assessed/);
  assert.match(
    documentQualitySummary(dimension).detail,
    /0\/0 descriptions assessed.*0\/1 intent scopes resolved/,
  );
  assert.match(documentQualitySummary(dimension).detail, /1 retained descriptions not reviewed/);
  assert.match(documentQualitySummary(dimension).detail, /3 inherited descriptions not reviewed/);
  assert.doesNotMatch(main, /Contoso.Namespace|supported named declaration|document-quality-file/);
  assert.equal(
    appendix,
    '<section id="appendix"><details><summary>Appendix</summary></details></section>',
  );
  assertNoDocumentAppendixUi(appendix);
  assert.deepEqual(dimension, original);
});

void test("highlighting preserves the exact retained description and matches only literal nonempty quotes", () => {
  const doc = "  <tag attr=\"x\">& 'quote'\nA [value]. A [value].\n";
  for (const [quote, highlighted] of /** @type {[string | undefined, boolean][]} */ ([
    ["<tag attr=\"x\">& 'quote'", true],
    ["'quote'\nA [value]", true],
    ["A [value]", true],
    ["a [value]", false],
    ["A  [value]", false],
    [".*", false],
    ["Empty", false],
    ["", false],
    [undefined, false],
  ])) {
    const dimension = documentDimension();
    dimension.findings[0].document.after.doc = doc;
    dimension.findings[0].docQuote = quote;
    dimension.intentAssessments[0].checks[0].docQuote = quote;
    const main = documentationSections(presentationWithDocuments(dimension)).main;
    const current = requiredMatch(main, /<blockquote>([\s\S]*?)<\/blockquote>/, 1);
    assert.equal(current.replaceAll("<mark>", "").replaceAll("</mark>", ""), escapeHtml(doc));
    assert.equal((current.match(/<mark>/g) ?? []).length, highlighted ? 1 : 0);
    if (highlighted) assert.ok(current.includes(`<mark>${escapeHtml(quote)}</mark>`));
    assert.doesNotMatch(main, /<tag attr|<h3>Suggested wording|What the response can contain/);
  }
});

void test("missing current descriptions never borrow baseline strings or legacy actual prose", () => {
  const dimension = documentDimension();
  dimension.findings[0].document.after = /** @type {DocumentationSnapshot} */ (
    /** @type {unknown} */ (null)
  );
  dimension.findings[0].actual = "Legacy interpretation, not compiler text.";
  dimension.findings[0].docQuote = "The number of widgets.";
  const main = documentationSections(presentationWithDocuments(dimension)).main;
  assert.match(main, /Current description evidence unavailable/);
  assert.doesNotMatch(main, /<blockquote>|<mark>|Legacy interpretation/);
  assert.match(main, /report-document-snapshots single-snapshot/);
  assert.ok(main.indexOf("View supporting TypeSpec") < main.indexOf("The number of widgets"));

  dimension.findings[0].document = /** @type {DocumentationDocument} */ (
    /** @type {unknown} */ (undefined)
  );
  dimension.intentAssessments = [];
  const orphan = documentationSections(presentationWithDocuments(dimension)).main;
  assert.match(orphan, /Document identity unavailable|Document source snapshots unavailable/);
  assert.match(orphan, /Recorded description evidence/);
  assert.match(orphan, /Legacy interpretation, not compiler text/);
  assert.doesNotMatch(orphan, /<blockquote>|<mark>/);
  assert.match(orphan, /id="document-quality-document-finding-widget"/);
});

void test("empty compiler descriptions remain exact rather than turning into missing evidence", () => {
  const dimension = documentDimension();
  dimension.findings[0].document.after.doc = "";
  const main = documentationSections(presentationWithDocuments(dimension)).main;
  assert.match(main, /<blockquote><\/blockquote>/);
  assert.doesNotMatch(main, /Current description evidence unavailable|<mark>/);
});

void test("Documentation Completeness naming changes labels but not recorded legacy evidence", () => {
  const dimension = documentDimension();
  const evidence = "Document Quality and Agent Friendliness <literal evidence>.";
  dimension.findings[0].document.after.doc = evidence;
  dimension.findings[0].docQuote = "Document Quality";
  dimension.findings[0].expected = evidence;
  const original = structuredClone(dimension);
  const { main, appendix } = documentationSections(presentationWithDocuments(dimension));
  assert.match(main, /<h2>Documentation Completeness<\/h2>/);
  const description = requiredMatch(main, /<blockquote>([\s\S]*?)<\/blockquote>/, 1);
  assert.equal(
    description.replaceAll("<mark>", "").replaceAll("</mark>", ""),
    escapeHtml(evidence),
  );
  assert.ok(main.includes(`<h3>Suggested change</h3><p>${escapeHtml(evidence)}</p>`));
  assertNoDocumentAppendixUi(appendix);
  assert.deepEqual(dimension, original);

  assert.equal(documentQualitySummary().detail, "Documentation Completeness is not assessed.");
  for (const name of [
    "Document Quality and Agent Friendliness",
    "Agent Friendliness",
    "Doc Correctness",
  ]) {
    const legacy = /** @type {DocumentQualityDimension} */ ({
      status: "not-assessed",
      summary: `${name} is not assessed.`,
    });
    assert.equal(
      documentQualitySummary(legacy).detail,
      "Documentation Completeness is not assessed.",
    );
    assert.equal(legacy.summary, `${name} is not assessed.`);
    assert.doesNotMatch(presentationWithDocuments(legacy), new RegExp(escapeHtml(legacy.summary)));
  }
});

void test("failure cards preserve other affected intents without repeating the owning intent", () => {
  const dimension = documentDimension();
  dimension.findings[0].semanticIntentIds.push("semantic-2");
  const input = assessment();
  input.dimensions.documentQuality = dimension;
  input.dimensions.semantic.items.push({
    ...structuredClone(input.dimensions.semantic.items[0]),
    id: "semantic-2",
    title: "Another affected intent",
  });
  const report = renderReportSections(input, reportRenderHelpers);
  const main = reportSection(report.html, "document-quality");
  const header = requiredMatch(
    main,
    /<details class="report-card document-quality-check"[^>]*>(<summary>[\s\S]*?<\/summary>)/,
    1,
  );
  assert.match(header, /Affected intents \(1\)/);
  assert.match(header, /href="#intent-semantic-2">Another affected intent/);
  assert.doesNotMatch(header, /href="#intent-semantic-1"/);
  assert.match(main, /href="#intent-semantic-1">Change the widget contract/);
});

void recordedAssessmentTest(
  "PR44988 keeps failed findings, compact counts and stable fragments without doc appendix details",
  () => {
    const input = readAssessment(
      new URL("../evals/assessments/44988/assessment.json", import.meta.url),
    );
    const original = structuredClone(input);
    const html = renderAssessmentHtml(input);
    const { main, appendix } = documentationSections(html);
    const findings = required(input.dimensions.documentQuality.findings);
    assert.equal(
      (main.match(/class="report-card document-quality-check"/g) ?? []).length,
      findings.length,
    );
    assert.match(main, /20 findings · 881 declarations checked/);
    assert.match(
      documentQualitySummary(input.dimensions.documentQuality).detail,
      /861\/881 declarations documented/,
    );
    assert.match(
      documentQualitySummary(input.dimensions.documentQuality).detail,
      /1 intent scopes incomplete/,
    );
    assert.match(
      documentQualitySummary(input.dimensions.documentQuality).detail,
      /10\/11 intent scopes resolved/,
    );
    assert.doesNotMatch(
      main,
      /document-quality-file|document-quality-passed-group|document-quality-not-assessed-group/,
    );
    assert.doesNotMatch(
      appendix,
      /861\/881|Passed descriptions|Not assessed intents|retained descriptions not reviewed|inherited descriptions not reviewed/,
    );
    assertNoDocumentAppendixUi(html);
    const ids = [...html.matchAll(/\bid="([^"]+)"/g)].map((match) => match[1]);
    assert.equal(ids.length, new Set(ids).size);
    for (const [, id] of html.matchAll(/href="#([^"]+)"/g))
      assert.ok(ids.includes(id), `Missing fragment ${id}`);
    for (const finding of findings) {
      assert.ok(main.includes(`id="document-quality-${finding.id}"`));
      assert.ok(main.includes(escapeHtml(finding.expected)));
      const intentHeader = requiredMatch(
        html,
        new RegExp(
          `<details class="report-card intent" id="intent-${finding.reviewUnitId}">(<summary>[\\s\\S]*?<\\/summary>)`,
        ),
        1,
      );
      assert.ok(
        intentHeader.includes(`class="report-link impact" href="#document-quality-${finding.id}"`),
      );
    }
    assert.deepEqual(input, original);
  },
);

void recordedAssessmentTest(
  "appendix fragments open enclosing details on initial load, repeated clicks and hash changes",
  () => {
    const input = readAssessment(
      new URL("../evals/assessments/44988/assessment.json", import.meta.url),
    );
    const html = renderAssessmentHtml(input);
    const { main, appendix } = documentationSections(html);
    const findingId = `document-quality-${required(input.dimensions.documentQuality.findings?.[0]).id}`;
    assert.match(main, new RegExp(`id="${findingId}"`));
    assert.match(appendix, /id="potential-limits"/);
    const outer = { tagName: "DETAILS", open: false, parentElement: null };
    const finding = { tagName: "DETAILS", open: false, parentElement: outer, scrollIntoView() {} };
    const heading = { tagName: "H3", parentElement: outer, scrollIntoView() {} };
    /** @type {Record<string, typeof finding | typeof heading>} */
    const targets = { "potential-limits": heading, [findingId]: finding };
    /** @type {Record<string, (event?: {target?: Element, preventDefault?: () => void}) => unknown>} */
    const listeners = {};
    class Element {
      /** @param {string} selector */
      closest(selector) {
        return selector === 'a[href^="#"]' || selector === "a" ? this : null;
      }
      /** @returns {string} */
      getAttribute() {
        return "#potential-limits";
      }
    }
    const context = {
      Element,
      location: { hash: `#${findingId}` },
      document: {
        /** @param {string} id */
        getElementById: (id) => targets[id],
        /** @param {string} event @param {(event?: {target?: Element, preventDefault?: () => void}) => unknown} callback */
        addEventListener: (event, callback) => {
          listeners[event] = callback;
        },
      },
      window: {
        /** @param {string} event @param {(event?: {target?: Element, preventDefault?: () => void}) => unknown} callback */
        addEventListener: (event, callback) => {
          listeners[event] = callback;
        },
        /** @param {() => unknown} callback */
        setTimeout: (callback) => callback(),
      },
    };
    vm.runInNewContext(requiredMatch(html, /<script>([\s\S]*?)<\/script>/i, 1), context);
    assert.equal(outer.open, true);
    assert.equal(finding.open, true);
    for (let index = 0; index < 2; index++) {
      outer.open = false;
      listeners.click({ target: new Element(), preventDefault() {} });
      assert.equal(context.location.hash, "#potential-limits");
      assert.equal(outer.open, true);
    }
    outer.open = finding.open = false;
    context.location.hash = `#${findingId}`;
    listeners.hashchange();
    assert.equal(outer.open, true);
    assert.equal(finding.open, true);
  },
);
