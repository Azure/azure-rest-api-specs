import assert from "node:assert/strict";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import test from "node:test";
import {
  assertFreshOutput,
  blockedAssessment,
  buildModelInput,
} from "./run-assessment-analysis.mjs";

/** @typedef {Parameters<typeof buildModelInput>[0]} ModelInputOptions */
/** @typedef {Parameters<typeof blockedAssessment>} BlockedAssessmentParameters */
/** @typedef {ReturnType<typeof buildModelInput>["semanticReviewUnits"][number]} ModelSemanticReviewUnit */
/** @typedef {import("./runtime-types.js").AssessmentFact} AssessmentFact */
/**
 * @typedef {ReturnType<typeof buildModelInput> & {
 *   evidenceSets: Record<string, import("./runtime-types.js").EvidenceSet & {declarationCount?: number}>,
 *   sourceChanges?: unknown,
 *   deferredDimensions?: unknown,
 *   documentQualityAssessmentVersion?: unknown,
 *   documentQualityCriterion?: unknown,
 *   documentQualityReviewUnits?: unknown,
 *   inputAccounting: {
 *     budgetTier: string,
 *     omittedRedundant: {rawEmitterArtifacts: boolean, sourceChanges: boolean},
 *     retained: {
 *       documentQualityReviewUnits?: unknown,
 *       documentQualityDocuments?: unknown
 *     }
 *   }
 * }} TestModelInput
 */

/** @param {unknown} value */
function assertObjectFixture(value) {
  assert.ok(value && typeof value === "object");
}

/**
 * Deliberately crosses the type boundary for malformed fixture values.
 * @param {object} target
 * @param {PropertyKey} property
 * @param {unknown} value
 */
function setInvalid(target, property, value) {
  assert.equal(Reflect.set(target, property, value), true);
}

/**
 * @param {unknown} manifest
 * @param {unknown} semantic
 * @param {unknown} rest
 * @param {unknown} downstream
 */
function blockedAssessmentFromFixture(manifest, semantic, rest, downstream) {
  assertObjectFixture(manifest);
  assertObjectFixture(semantic);
  assertObjectFixture(rest);
  assertObjectFixture(downstream);
  return blockedAssessment(
    /** @type {BlockedAssessmentParameters[0]} */ (manifest),
    /** @type {BlockedAssessmentParameters[1]} */ (semantic),
    /** @type {BlockedAssessmentParameters[2]} */ (rest),
    /** @type {BlockedAssessmentParameters[3]} */ (downstream),
  );
}

/**
 * Keeps intentionally compact or malformed fixtures outside contextual typing.
 * @param {unknown} options
 * @returns {TestModelInput}
 */
function buildModelInputFromFixture(options) {
  assertObjectFixture(options);
  return /** @type {TestModelInput} */ (
    buildModelInput(/** @type {ModelInputOptions} */ (options))
  );
}

/**
 * @param {ModelSemanticReviewUnit} unit
 * @returns {NonNullable<ModelSemanticReviewUnit["deterministicCoverage"]>}
 */
function deterministicCoverage(unit) {
  assert.ok(unit.deterministicCoverage);
  return unit.deterministicCoverage;
}

/**
 * @param {TestModelInput} input
 * @param {string} factId
 * @returns {AssessmentFact}
 */
function assessmentFact(input, factId) {
  const fact = input.facts[factId];
  assertObjectFixture(fact);
  return /** @type {AssessmentFact} */ (fact);
}

void test("requires a fresh assessment output directory", () => {
  const root = fs.mkdtempSync(path.join(os.tmpdir(), "typespec-assessment-output-"));
  const missing = path.join(root, "new");
  try {
    assert.doesNotThrow(() => assertFreshOutput(missing));
    assert.doesNotThrow(() => assertFreshOutput(root));
    fs.writeFileSync(path.join(root, "workflow-state.json"), "{}");
    assert.throws(() => assertFreshOutput(root), /Assessment output directory must be empty/);
  } finally {
    fs.rmSync(root, { recursive: true, force: true });
  }
});

void test("blocked assessments preserve pull request metadata", () => {
  const pullRequest = {
    number: 123,
    url: "https://github.com/Azure/azure-rest-api-specs/pull/123",
  };
  const assessment = blockedAssessmentFromFixture(
    {
      repository: { remoteUrl: "https://github.com/Azure/azure-rest-api-specs" },
      pullRequest,
      comparison: {
        baseRef: "main",
        mergeBaseCommit: "base",
        headCommit: "head",
        workingTree: {},
      },
      projects: [],
      blockers: [],
    },
    { blockers: [] },
    { blockers: [] },
    { blockers: [] },
  );

  assert.deepEqual(assessment.pullRequest, pullRequest);
});

void test("model input references canonical evidence without embedding sources", () => {
  const input = buildModelInputFromFixture({
    manifest: {
      comparison: {
        mergeBaseCommit: "base",
        headCommit: "head",
        baseRef: "origin/main",
        workingTree: {},
      },
      projects: [{ id: "p", path: "specification/widget" }],
      blockers: [],
    },
    sourceIndex: {
      sourceChanges: [
        {
          id: "source-1",
          path: "a.tsp",
          hunks: [{ id: "hunk-1", lines: ["+model Widget {}"] }],
          declarations: [
            {
              id: "declaration-1",
              kind: "model",
              qualifiedName: "Widget",
              hunkIds: ["hunk-1"],
            },
          ],
        },
        { id: "source-unused", path: "b.tsp", hunks: [], declarations: [] },
      ],
    },
    semantic: {
      status: "ready",
      facts: {
        "operation-1": { operationId: "Widgets_Get" },
        "operation-unused": { operationId: "Unused" },
      },
      reviewUnits: [
        {
          id: "semantic-1",
          sourceChangeIds: ["source-1"],
          hunkIds: ["hunk-1"],
          declarationIds: ["declaration-1"],
          operationIds: ["operation-1"],
          beforeFactIds: [],
          afterFactIds: ["operation-1"],
        },
      ],
      blockers: [],
    },
    rest: {
      status: "ready",
      facts: {},
      candidates: [],
      blockers: [],
    },
    downstream: {
      status: "ready",
      facts: {},
      candidates: [],
      blockers: [],
    },
  });
  assert.equal(input.sourceChanges, undefined);
  assert.deepEqual(input.artifactReferences, {
    sourceIndex: "source/source-index.json",
    semanticReviewUnits: "dimensions/semantic-intents-input.json",
    restCandidates: "dimensions/rest-breaking-input.json",
    downstreamCandidates: "dimensions/downstream-breaking-input.json",
    complianceSearchRequests: "dimensions/compliance-search-requests.json",
  });
  assert.equal(Object.keys(input.evidenceSets).length, 1);
  assert.deepEqual(Object.keys(input.facts), []);
  assert.equal(input.semanticReviewUnits[0].affectedOperationCount, 1);
  assert.deepEqual(input.semanticReviewUnits[0].representativeOperationIds, ["operation-1"]);
  assert.equal(input.complianceSearchRequests.length, 1);
  assert.equal(input.complianceSearchRequests[0].reviewUnitId, "semantic-1");
  assert.equal(
    input.complianceSearchRequests[0].evidenceSetId,
    input.semanticReviewUnits[0].evidenceSetId,
  );
  assert.equal(input.complianceSearchRequests[0].declarationIds, undefined);
  assert.equal(input.complianceSearchRequests[0].queryProfile, undefined);
  assert.equal(input.complianceSearchRequests[0].querySummary.qualifiedNameCount, 1);
  assert.match(input.complianceSearchRequests[0].requestId, /^compliance-search-/);
  const coverage = deterministicCoverage(input.semanticReviewUnits[0]);
  assert.deepEqual(coverage.coveredHunkIds, ["hunk-1"]);
  assert.deepEqual(coverage.uncoveredHunkIds, []);
  assert.equal(input.semanticReviewUnits[0].inferenceRequired, false);
  assert.deepEqual(input.inferenceRequests, []);
  assert.equal(input.deferredDimensions, undefined);
  assert.equal(input.documentQualityReviewUnits, undefined);
  assert.equal(input.documentQualityCriterion, undefined);
  assert.equal(input.inputAccounting.budgetTier, "small");
  assert.equal(input.inputAccounting.omittedRedundant.rawEmitterArtifacts, true);
  assert.equal(input.inputAccounting.omittedRedundant.sourceChanges, true);
});

void test("model input retains facts referenced by REST candidates", () => {
  const input = buildModelInputFromFixture({
    manifest: {
      comparison: {
        mergeBaseCommit: "base",
        headCommit: "head",
        baseRef: "origin/main",
        workingTree: {},
      },
      projects: [{ id: "p", path: "specification/widget" }],
      blockers: [],
    },
    sourceIndex: {
      sourceChanges: [
        {
          id: "source-1",
          path: "a.tsp",
          hunks: [{ id: "hunk-1", lines: ["+model Widget {}"] }],
          declarations: [],
        },
      ],
    },
    semantic: {
      status: "ready",
      facts: {},
      reviewUnits: [
        {
          id: "semantic-1",
          sourceChangeIds: ["source-1"],
          hunkIds: ["hunk-1"],
          declarationIds: [],
          operationIds: [],
          beforeFactIds: [],
          afterFactIds: [],
        },
      ],
      blockers: [],
    },
    rest: {
      status: "ready",
      facts: {
        "rest-before": { id: "rest-before", required: false },
        "rest-after": { id: "rest-after", required: true },
      },
      candidates: [
        {
          id: "rest-1",
          sourceChangeIds: ["source-1"],
          hunkIds: ["hunk-1"],
          declarationIds: [],
          evidenceFactIds: ["rest-before", "rest-after"],
        },
      ],
      blockers: [],
    },
    downstream: {
      status: "ready",
      facts: {},
      candidates: [],
      blockers: [],
    },
  });
  assert.deepEqual(Object.keys(input.facts), ["rest-after", "rest-before"]);
});

void test("model input excludes API-version-wide intents and their candidates", () => {
  const operations = ["Widgets_Get", "Widgets_List"].map((operationId, index) => ({
    operationId,
    beforeFactId: `before-${index}`,
    afterFactId: `after-${index}`,
    matchBasis: "version-transition-change",
    sourceChangeIds: ["source-1"],
    hunkIds: ["hunk-1"],
  }));
  const input = buildModelInputFromFixture({
    manifest: {
      comparison: {
        mergeBaseCommit: "base",
        headCommit: "head",
        baseRef: "origin/main",
        workingTree: {},
      },
      projects: [{ id: "p", path: "specification/widget" }],
      blockers: [],
    },
    sourceIndex: {
      sourceChanges: [
        {
          id: "source-1",
          path: "versions.tsp",
          hunks: [{ id: "hunk-1", lines: ["+v2"] }],
          declarations: [
            {
              id: "declaration-1",
              kind: "enum",
              qualifiedName: "Versions",
              hunkIds: ["hunk-1"],
            },
          ],
        },
      ],
    },
    semantic: {
      status: "ready",
      facts: {},
      reviewUnits: [
        {
          id: "semantic-version-wide",
          intentType: "api-version-wide-change",
          sourceChangeIds: ["source-1"],
          hunkIds: ["hunk-1"],
          declarationIds: ["declaration-1"],
          declarationNames: ["Versions"],
          ownedOperationIds: [],
          operations,
        },
      ],
      blockers: [],
    },
    rest: {
      status: "ready",
      facts: {
        "rest-before": { id: "rest-before" },
        "rest-after": { id: "rest-after" },
      },
      candidates: [
        {
          id: "rest-version-wide",
          sourceChangeIds: ["source-1"],
          hunkIds: ["hunk-1"],
          declarationIds: ["declaration-1"],
          operationIds: ["Widgets_Get", "Widgets_List"],
          evidenceFactIds: ["rest-before", "rest-after"],
        },
      ],
      blockers: [],
    },
    downstream: {
      status: "ready",
      facts: {},
      candidates: [],
      rootCauses: [],
      blockers: [],
    },
  });

  assert.deepEqual(input.semanticReviewUnits, []);
  assert.deepEqual(input.informationalSemanticIntentIds, ["semantic-version-wide"]);
  assert.deepEqual(input.restCandidates, []);
  assert.deepEqual(input.downstreamCandidates, []);
  assert.deepEqual(input.facts, {});
});

void test("documentation completeness is omitted from bounded Agent input", () => {
  const longDoc = "The amount of time, in seconds, to wait. ".repeat(10000);
  const unit = {
    reviewUnitId: "semantic-doc",
    status: "ready",
    sourceChangeIds: ["source-doc"],
    hunkIds: ["hunk-doc"],
    declarationIds: ["declaration-doc"],
    documents: [
      {
        id: "document-timeout",
        sourceChangeId: "source-doc",
        qualifiedName: "Options.timeout",
        kind: "property",
        before: null,
        after: {
          doc: longDoc,
          declaration: "timeout?: int32 = 30;",
          source: {
            path: "models.tsp",
            revision: "current",
            startLine: 2,
            endLine: 3,
          },
        },
      },
    ],
  };
  const options = {
    manifest: {
      comparison: { mergeBaseCommit: "base", headCommit: "head", workingTree: {} },
      projects: [],
      blockers: [],
    },
    sourceIndex: {
      sourceChanges: [
        {
          id: "source-doc",
          path: "models.tsp",
          hunks: [{ id: "hunk-doc", lines: ['+@doc("The timeout.")'] }],
          declarations: [],
        },
      ],
    },
    semantic: {
      status: "ready",
      reviewUnits: [
        {
          id: unit.reviewUnitId,
          sourceChangeIds: unit.sourceChangeIds,
          hunkIds: unit.hunkIds,
          declarationIds: unit.declarationIds,
        },
      ],
      facts: {},
      blockers: [],
    },
    rest: { status: "ready", candidates: [], facts: {}, blockers: [] },
    downstream: { status: "ready", candidates: [], facts: {}, blockers: [] },
    documentQuality: {
      schemaVersion: 3,
      status: "ready",
      reviewUnits: [unit],
      blockers: [],
    },
  };
  const input = buildModelInputFromFixture(options);
  assert.equal(input.documentQualityAssessmentVersion, undefined);
  assert.equal(input.documentQualityCriterion, undefined);
  assert.equal(input.documentQualityReviewUnits, undefined);
  assert.equal(JSON.stringify(input).includes(longDoc), false);
  assert.equal(input.artifactReferences.documentQuality, undefined);
  assert.equal(input.inputAccounting.retained.documentQualityReviewUnits, undefined);
  assert.equal(input.inputAccounting.retained.documentQualityDocuments, undefined);
  assert.deepEqual(input.inferenceRequests, []);
});

void test("model input requests inference only for unknown hunks", () => {
  const input = buildModelInputFromFixture({
    manifest: {
      comparison: {
        mergeBaseCommit: "base",
        headCommit: "head",
        baseRef: "origin/main",
        workingTree: {},
      },
      projects: [{ id: "p", path: "specification/widget" }],
      blockers: [],
    },
    sourceIndex: {
      sourceChanges: [
        {
          id: "source-1",
          path: "back-compatible.tsp",
          hunks: [
            {
              id: "hunk-1",
              lines: [
                "@@clientLocation(Widgets.get, Contoso,",
                '-  "!csharp"',
                '+  "!csharp,!go"',
                ");",
              ],
            },
          ],
          declarations: [
            {
              id: "declaration-1",
              hunkIds: ["hunk-1"],
              kind: "model",
              qualifiedName: "Widget",
            },
          ],
        },
      ],
    },
    semantic: {
      status: "ready",
      facts: {
        "operation-1": {
          operationId: "Widgets_Get",
          method: "get",
          path: "/widgets",
        },
      },
      reviewUnits: [
        {
          id: "semantic-1",
          sourceChangeIds: ["source-1"],
          hunkIds: ["hunk-1"],
          declarationIds: ["declaration-1"],
          operations: [
            {
              operationId: "Widgets_Get",
              hunkIds: ["hunk-1"],
              afterFactId: "operation-1",
            },
          ],
        },
      ],
      blockers: [],
    },
    rest: {
      status: "ready",
      facts: {},
      candidates: [
        {
          id: "rest-1",
          operationIds: ["Widgets_Get"],
          sourceChangeIds: ["source-1"],
          evidenceFactIds: [],
        },
      ],
      blockers: [],
    },
    downstream: {
      status: "ready",
      facts: {},
      candidates: [],
      blockers: [],
    },
  });

  assert.equal(input.semanticReviewUnits[0].inferenceRequired, true);
  const coverage = deterministicCoverage(input.semanticReviewUnits[0]);
  assert.deepEqual(coverage.uncoveredHunkIds, ["hunk-1"]);
  assert.equal(input.inferenceRequests.length, 1);
  assert.match(input.inferenceRequests[0].requestId, /^inference-request-/);
  assert.equal(input.inferenceRequests[0].hunkId, "hunk-1");
  assert.deepEqual(input.inferenceRequests[0].evidenceRef, {
    artifact: "source/source-index.json",
    sourceChangeId: "source-1",
    hunkId: "hunk-1",
  });
  assert.deepEqual(input.inferenceRequests[0].allowedDimensions, ["rest", "downstream"]);
});

void test("model input bounds repeated review evidence and retains downstream facts", () => {
  const declarationIds = Array.from({ length: 100 }, (_, index) => `declaration-${index}`);
  const declarations = declarationIds.map((id, index) => ({
    id,
    kind: "model",
    qualifiedName: `Contoso.Model${index}`,
    hunkIds: ["hunk-1"],
    compilerEvidence: {
      referencedNames: [`Contoso.Reference${index}`],
    },
  }));
  const input = buildModelInputFromFixture({
    manifest: {
      comparison: {
        mergeBaseCommit: "base",
        headCommit: "head",
        baseRef: "origin/main",
        workingTree: {},
      },
      projects: [{ id: "p", path: "specification/widget" }],
      blockers: [],
    },
    sourceIndex: {
      sourceChanges: [
        {
          id: "source-1",
          path: "main.tsp",
          hunks: [{ id: "hunk-1", lines: ["+model Widget {}"] }],
          declarations,
        },
      ],
    },
    semantic: {
      status: "ready",
      facts: {},
      reviewUnits: [
        {
          id: "semantic-1",
          sourceChangeIds: ["source-1"],
          hunkIds: ["hunk-1"],
          declarationIds,
          operations: [],
        },
      ],
      blockers: [],
    },
    rest: { status: "ready", facts: {}, candidates: [], blockers: [] },
    downstream: {
      status: "ready",
      facts: {
        "sdk-fact-1": {
          id: "sdk-fact-1",
          projectId: "p",
          comparisonRole: "target",
          factKind: "model",
          identity: "Contoso.Widget",
        },
      },
      candidates: [
        {
          id: "downstream-1",
          rule: "type-changed",
          actual: "Changed",
          expected: "Stable",
          sourceChangeIds: ["source-1"],
          hunkIds: ["hunk-1"],
          declarationIds,
          evidenceFactIds: ["sdk-fact-1"],
          reviewRequired: true,
        },
      ],
      rootCauses: [],
      blockers: [],
    },
  });

  const unit = input.semanticReviewUnits[0];
  assert.ok(Array.isArray(unit.qualifiedNames));
  assert.ok(Array.isArray(unit.changedConstructs));
  assert.equal(unit.qualifiedNames.length, 24);
  assert.equal(unit.qualifiedNameCount, 100);
  assert.equal(unit.changedConstructs.length, 40);
  assert.equal(unit.changedConstructCount, 100);
  assert.equal(input.downstreamCandidates[0].declarationIds, undefined);
  assert.deepEqual(Object.keys(input.facts), ["sdk-fact-1"]);
  assert.ok(input.downstreamCandidates[0].evidenceSetId);
  assert.equal(
    input.evidenceSets[input.downstreamCandidates[0].evidenceSetId].declarationCount,
    100,
  );
});

void test("model input retains downstream method and bridge path facts", () => {
  const facts = Object.fromEntries(
    ["method", "wrapper", "type"].map((name) => [
      `sdk-${name}`,
      {
        id: `sdk-${name}`,
        projectId: "p",
        comparisonRole: "target",
        factKind: name === "method" ? "method" : "model",
        identity: `Contoso.${name}`,
        crossLanguageDefinitionId: `Contoso.${name}`,
      },
    ]),
  );
  const input = buildModelInputFromFixture({
    manifest: {
      comparison: {
        mergeBaseCommit: "base",
        headCommit: "head",
        baseRef: "origin/main",
        workingTree: {},
      },
      projects: [{ id: "p", path: "specification/widget" }],
      blockers: [],
    },
    sourceIndex: { sourceChanges: [] },
    semantic: { status: "ready", facts: {}, reviewUnits: [], blockers: [] },
    rest: { status: "ready", facts: {}, candidates: [], blockers: [] },
    downstream: {
      status: "ready",
      facts,
      candidates: [
        {
          id: "downstream-1",
          rule: "model-property-removed",
          actual: "Changed",
          expected: "Stable",
          sourceChangeIds: [],
          hunkIds: [],
          declarationIds: [],
          evidenceFactIds: ["sdk-type"],
          rootCauseIds: ["root-1"],
          reviewRequired: true,
        },
      ],
      rootCauses: [
        {
          id: "root-1",
          kind: "type-contract-propagation",
          directCandidateIds: ["downstream-1"],
          propagatedCandidateIds: [],
          methodFactIds: ["sdk-method"],
          typeFactIds: ["sdk-wrapper", "sdk-type"],
          referenceEvidence: [
            {
              fromFactId: "sdk-method",
              toFactId: "sdk-wrapper",
              kind: "response",
              location: "response-body",
            },
            {
              fromFactId: "sdk-wrapper",
              toFactId: "sdk-type",
              kind: "property",
              memberName: "value",
              location: "response-body",
            },
          ],
        },
      ],
      blockers: [],
    },
  });

  assert.deepEqual(Object.keys(input.facts), ["sdk-method", "sdk-type", "sdk-wrapper"]);
  assert.ok(
    input.downstreamRootCauses[0].referenceEvidence.every((edge) => {
      assert.ok(edge.fromFactId);
      assert.ok(edge.toFactId);
      return Boolean(input.facts[edge.fromFactId] && input.facts[edge.toFactId]);
    }),
  );
});

void test("model input keeps unsupported unmapped decorators unknown", () => {
  const input = buildModelInputFromFixture({
    manifest: {
      comparison: {
        mergeBaseCommit: "base",
        headCommit: "head",
        baseRef: "origin/main",
        workingTree: {},
      },
      projects: [{ id: "p", path: "specification/widget" }],
      blockers: [],
    },
    sourceIndex: {
      sourceChanges: [
        {
          id: "source-1",
          path: "client.tsp",
          hunks: [
            {
              id: "hunk-1",
              lines: ["-@@access(Widget, Access.public);", "+@@access(Widget, Access.internal);"],
            },
          ],
          declarations: [],
        },
      ],
    },
    semantic: {
      status: "ready",
      facts: {},
      reviewUnits: [
        {
          id: "semantic-1",
          sourceChangeIds: ["source-1"],
          hunkIds: ["hunk-1"],
          declarationIds: [],
          operations: [],
        },
      ],
      blockers: [],
    },
    rest: { status: "ready", facts: {}, candidates: [], blockers: [] },
    downstream: { status: "ready", facts: {}, candidates: [], blockers: [] },
  });

  assert.equal(input.semanticReviewUnits[0].inferenceRequired, true);
  const coverage = deterministicCoverage(input.semanticReviewUnits[0]);
  assert.equal(coverage.classifications[0].reason, "unsupported-customization-not-represented");
});

void test("known decorators do not mask unsupported changes in the same hunk", () => {
  for (const lines of [
    ['+@@operationId(Widgets.get, "Widgets_Get");', "+@@access(Widget, Access.internal);"],
    [' @@operationId(Widgets.get, "Widgets_Get");', "+@@access(Widget, Access.internal);"],
    ['+@@clientName(Widget, "RenamedWidget");', "+@@access(Widget, Access.internal);"],
  ]) {
    const input = buildModelInputFromFixture({
      manifest: {
        comparison: {
          mergeBaseCommit: "base",
          headCommit: "head",
          baseRef: "origin/main",
          workingTree: {},
        },
        projects: [{ id: "p", path: "specification/widget" }],
        blockers: [],
      },
      sourceIndex: {
        sourceChanges: [
          {
            id: "source-1",
            path: "client.tsp",
            hunks: [{ id: "hunk-1", lines }],
            declarations: [],
          },
        ],
      },
      semantic: {
        status: "ready",
        facts: {},
        reviewUnits: [
          {
            id: "semantic-1",
            sourceChangeIds: ["source-1"],
            hunkIds: ["hunk-1"],
            declarationIds: [],
            operations: [],
          },
        ],
        blockers: [],
      },
      rest: { status: "ready", facts: {}, candidates: [], blockers: [] },
      downstream: { status: "ready", facts: {}, candidates: [], blockers: [] },
    });

    assert.equal(input.semanticReviewUnits[0].inferenceRequired, true);
    assert.equal(input.inferenceRequests.length, 1);
    const coverage = deterministicCoverage(input.semanticReviewUnits[0]);
    assert.equal(coverage.classifications[0].reason, "unsupported-customization-not-represented");
  }
});

void test("multiline decorator bodies remain inference-visible", () => {
  for (const lines of [
    [" @@clientName(Widget,", '-  "GoWidget",', '+  "RenamedWidget",', '   "go")'],
    [" @pattern(", '-  "old"', '+  "new"', " )"],
  ]) {
    const input = buildModelInputFromFixture({
      manifest: {
        comparison: {
          mergeBaseCommit: "base",
          headCommit: "head",
          baseRef: "origin/main",
          workingTree: {},
        },
        projects: [{ id: "p", path: "specification/widget" }],
        blockers: [],
      },
      sourceIndex: {
        sourceChanges: [
          {
            id: "source-1",
            path: "client.tsp",
            hunks: [{ id: "hunk-1", lines }],
            declarations: [],
          },
        ],
      },
      semantic: {
        status: "ready",
        facts: {},
        reviewUnits: [
          {
            id: "semantic-1",
            projectId: "p",
            projectIds: ["p"],
            sourceChangeIds: ["source-1"],
            hunkIds: ["hunk-1"],
            declarationIds: [],
            operations: [],
          },
        ],
        blockers: [],
      },
      rest: { status: "ready", facts: {}, candidates: [], blockers: [] },
      downstream: { status: "ready", facts: {}, candidates: [], blockers: [] },
    });

    assert.equal(input.semanticReviewUnits[0].inferenceRequired, true);
    assert.equal(input.inferenceRequests.length, 1);
  }
});

void test("context-only scoped decorators do not force inference", () => {
  const input = buildModelInputFromFixture({
    manifest: {
      comparison: {
        mergeBaseCommit: "base",
        headCommit: "head",
        baseRef: "origin/main",
        workingTree: {},
      },
      projects: [{ id: "p", path: "specification/widget" }],
      blockers: [],
    },
    sourceIndex: {
      sourceChanges: [
        {
          id: "source-1",
          path: "main.tsp",
          hunks: [
            {
              id: "hunk-1",
              lines: [
                ' @@clientLocation(Widgets.get, Contoso, "go");',
                "-model Widget {}",
                "+model Widget { name?: string; }",
              ],
            },
          ],
          declarations: [
            {
              id: "declaration-1",
              hunkIds: ["hunk-1"],
              kind: "model",
              qualifiedName: "Widget",
            },
          ],
        },
      ],
    },
    semantic: {
      status: "ready",
      facts: {},
      reviewUnits: [
        {
          id: "semantic-1",
          sourceChangeIds: ["source-1"],
          hunkIds: ["hunk-1"],
          declarationIds: ["declaration-1"],
          operations: [],
        },
      ],
      blockers: [],
    },
    rest: { status: "ready", facts: {}, candidates: [], blockers: [] },
    downstream: { status: "ready", facts: {}, candidates: [], blockers: [] },
  });

  assert.equal(input.semanticReviewUnits[0].inferenceRequired, false);
});

void test("parentheses in context decorator strings do not leak decorator scope", () => {
  const input = buildModelInputFromFixture({
    manifest: {
      comparison: {
        mergeBaseCommit: "base",
        headCommit: "head",
        baseRef: "origin/main",
        workingTree: {},
      },
      projects: [{ id: "p", path: "specification/widget" }],
      blockers: [],
    },
    sourceIndex: {
      sourceChanges: [
        {
          id: "source-1",
          path: "main.tsp",
          hunks: [
            {
              id: "hunk-1",
              lines: [
                ' @@clientLocation(Widgets.get, Contoso, "go(");',
                "-model Widget {}",
                "+model Widget { name?: string; }",
              ],
            },
          ],
          declarations: [
            {
              id: "declaration-1",
              hunkIds: ["hunk-1"],
              kind: "model",
              qualifiedName: "Widget",
            },
          ],
        },
      ],
    },
    semantic: {
      status: "ready",
      facts: {},
      reviewUnits: [
        {
          id: "semantic-1",
          sourceChangeIds: ["source-1"],
          hunkIds: ["hunk-1"],
          declarationIds: ["declaration-1"],
          operations: [],
        },
      ],
      blockers: [],
    },
    rest: { status: "ready", facts: {}, candidates: [], blockers: [] },
    downstream: { status: "ready", facts: {}, candidates: [], blockers: [] },
  });

  assert.equal(input.semanticReviewUnits[0].inferenceRequired, false);
});

void test("direct doc decorator changes remain semantic-only", () => {
  const input = buildModelInputFromFixture({
    manifest: {
      comparison: {
        mergeBaseCommit: "base",
        headCommit: "head",
        baseRef: "origin/main",
        workingTree: {},
      },
      projects: [{ id: "p", path: "specification/widget" }],
      blockers: [],
    },
    sourceIndex: {
      sourceChanges: [
        {
          id: "source-1",
          path: "main.tsp",
          hunks: [
            {
              id: "hunk-1",
              lines: ['-@doc("old")', '+@doc("new")'],
            },
          ],
          declarations: [],
        },
      ],
    },
    semantic: {
      status: "ready",
      facts: {},
      reviewUnits: [
        {
          id: "semantic-1",
          sourceChangeIds: ["source-1"],
          hunkIds: ["hunk-1"],
          declarationIds: [],
          operations: [],
        },
      ],
      blockers: [],
    },
    rest: { status: "ready", facts: {}, candidates: [], blockers: [] },
    downstream: { status: "ready", facts: {}, candidates: [], blockers: [] },
  });

  assert.equal(input.semanticReviewUnits[0].inferenceRequired, false);
  const coverage = deterministicCoverage(input.semanticReviewUnits[0]);
  assert.equal(coverage.classifications[0].status, "semantic-only");
});

void test("direct unsupported decorators remain inference-visible", () => {
  const input = buildModelInputFromFixture({
    manifest: {
      comparison: {
        mergeBaseCommit: "base",
        headCommit: "head",
        baseRef: "origin/main",
        workingTree: {},
      },
      projects: [{ id: "p", path: "specification/widget" }],
      blockers: [],
    },
    sourceIndex: {
      sourceChanges: [
        {
          id: "source-1",
          path: "main.tsp",
          hunks: [
            {
              id: "hunk-1",
              lines: ['-@myCustom("old")', '+@myCustom("new")', " model Widget {}"],
            },
          ],
          declarations: [
            {
              id: "declaration-1",
              hunkIds: ["hunk-1"],
              kind: "model",
              qualifiedName: "Widget",
            },
          ],
        },
      ],
    },
    semantic: {
      status: "ready",
      facts: {},
      reviewUnits: [
        {
          id: "semantic-1",
          sourceChangeIds: ["source-1"],
          hunkIds: ["hunk-1"],
          declarationIds: ["declaration-1"],
          operations: [],
        },
      ],
      blockers: [],
    },
    rest: { status: "ready", facts: {}, candidates: [], blockers: [] },
    downstream: { status: "ready", facts: {}, candidates: [], blockers: [] },
  });

  assert.equal(input.semanticReviewUnits[0].inferenceRequired, true);
  const coverage = deterministicCoverage(input.semanticReviewUnits[0]);
  assert.equal(coverage.classifications[0].reason, "unsupported-customization-not-represented");
});

void test("mapped hunks remain blocked when deterministic analysis is blocked", () => {
  const input = buildModelInputFromFixture({
    manifest: {
      comparison: {
        mergeBaseCommit: "base",
        headCommit: "head",
        baseRef: "origin/main",
        workingTree: {},
      },
      projects: [{ id: "p", path: "specification/widget" }],
      blockers: [],
    },
    sourceIndex: {
      sourceChanges: [
        {
          id: "source-1",
          path: "main.tsp",
          hunks: [{ id: "hunk-1", lines: ["+op getWidget(): Widget;"] }],
          declarations: [],
        },
      ],
    },
    semantic: {
      status: "ready",
      facts: {},
      reviewUnits: [
        {
          id: "semantic-1",
          sourceChangeIds: ["source-1"],
          hunkIds: ["hunk-1"],
          declarationIds: [],
          operations: [{ operationId: "Widgets_Get", hunkIds: ["hunk-1"] }],
        },
      ],
      blockers: [],
    },
    rest: {
      status: "blocked",
      facts: {},
      candidates: [],
      blockers: [{ code: "rest-blocked", message: "REST unavailable." }],
    },
    downstream: { status: "ready", facts: {}, candidates: [], blockers: [] },
  });

  const coverage = deterministicCoverage(input.semanticReviewUnits[0]);
  assert.equal(coverage.classifications[0].status, "blocked");
  assert.equal(input.semanticReviewUnits[0].inferenceRequired, false);
});

void test("model input retains facts relevant to inference hunks", () => {
  /** @type {AssessmentFact} */
  const widgetFact = {
    id: "sdk-fact-widget",
    projectId: "p",
    comparisonRole: "target",
    sourceRevision: "current",
    sourceCommit: "head",
    apiVersions: ["2025-01-01"],
    factKind: "model",
    identity: "Contoso.Widget",
    crossLanguageDefinitionId: "Contoso.Widget",
    name: "Widget",
    operation: {
      operationId: "Widgets_Get",
      method: "get",
      path: "/widgets",
    },
    access: "public",
    usage: [],
    properties: [],
    reachable: true,
  };
  setInvalid(widgetFact, "usage", 1);

  const input = buildModelInputFromFixture({
    manifest: {
      comparison: {
        mergeBaseCommit: "base",
        headCommit: "head",
        baseRef: "origin/main",
        workingTree: {},
      },
      projects: [{ id: "p", path: "specification/widget" }],
      blockers: [],
    },
    sourceIndex: {
      sourceChanges: [
        {
          id: "source-1",
          path: "client.tsp",
          hunks: [
            {
              id: "hunk-1",
              lines: ["-@@access(Widget, Access.public);", "+@@access(Widget, Access.internal);"],
            },
          ],
          declarations: [],
        },
      ],
    },
    semantic: {
      status: "ready",
      facts: {},
      reviewUnits: [
        {
          id: "semantic-1",
          projectId: "p",
          projectIds: ["p"],
          sourceChangeIds: ["source-1"],
          hunkIds: ["hunk-1"],
          declarationIds: [],
          operations: [],
        },
      ],
      blockers: [],
    },
    rest: { status: "ready", facts: {}, candidates: [], blockers: [] },
    downstream: {
      status: "ready",
      facts: {
        "sdk-fact-widget": widgetFact,
      },
      candidates: [],
      blockers: [],
    },
  });

  assert.deepEqual(Object.keys(input.facts), ["sdk-fact-widget"]);
  const fact = assessmentFact(input, "sdk-fact-widget");
  assert.equal(fact.comparisonRole, "target");
  assert.equal(fact.sourceRevision, "current");
  assert.equal(fact.sourceCommit, "head");
  assert.deepEqual(fact.apiVersions, ["2025-01-01"]);
  assert.deepEqual(fact.operation, {
    operationId: "Widgets_Get",
    method: "get",
    path: "/widgets",
  });
});
