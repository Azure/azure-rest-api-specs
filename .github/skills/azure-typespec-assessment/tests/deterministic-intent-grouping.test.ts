import { assert, test } from "vitest";
import {
  dedupePublicationHunks,
  dedupeSemanticHunks,
  isPublicationGroupingUnit,
} from "../scripts/analyze-semantic-intents.ts";
import {
  attachSemanticChangeFacts,
  deriveSemanticChangeFacts,
  isVersionGovernanceOnly,
} from "../scripts/semantic-change-facts.ts";

type InternalSemanticUnit = import("../scripts/runtime-types.ts").InternalSemanticUnit;
type SourceIndex = import("../scripts/runtime-types.ts").SourceIndex;

function unit(id: string, overrides: Partial<InternalSemanticUnit> = {}): InternalSemanticUnit {
  return {
    id,
    projectId: "project",
    sourceChangeIds: [],
    hunkIds: [],
    declarationIds: [],
    declarationNames: [],
    ownedOperationIds: [],
    operations: [],
    operationIds: [],
    beforeFactIds: [],
    afterFactIds: [],
    changedAspects: [],
    ...overrides,
  };
}

const mixedSourceIndex = {
  sourceChanges: [
    {
      id: "source-main",
      path: "main.tsp",
      status: "modified",
      hunks: [
        {
          id: "hunk-mixed",
          base: { startLine: 10 },
          current: { startLine: 10 },
          lines: [
            "@@ -10,2 +10,3 @@",
            '-enum Versions { v1: "2025-01-01" }',
            '+enum Versions { v1: "2025-01-01", v2: "2026-01-01" }',
            "+model Widget { name: string; }",
          ],
        },
      ],
      declarations: [
        {
          id: "versions-base",
          kind: "enum",
          qualifiedName: "Versions",
          hunkIds: ["hunk-mixed"],
          source: { revision: "base", startLine: 10, endLine: 10 },
        },
        {
          id: "versions-current",
          kind: "enum",
          qualifiedName: "Versions",
          hunkIds: ["hunk-mixed"],
          source: { revision: "current", startLine: 10, endLine: 10 },
        },
        {
          id: "widget-current",
          kind: "model",
          qualifiedName: "Widget",
          hunkIds: ["hunk-mixed"],
          source: { revision: "current", startLine: 11, endLine: 11 },
        },
      ],
    },
  ],
} as unknown as SourceIndex;

void test("derives normalized declaration facts with exact evidence provenance", () => {
  const feature = unit("feature", {
    sourceChangeIds: ["source-main"],
    hunkIds: ["hunk-mixed"],
    declarationIds: ["widget-current"],
    declarationNames: ["Widget"],
  });

  const facts = deriveSemanticChangeFacts(feature, mixedSourceIndex);

  assert.equal(facts.length, 1);
  assert.equal(facts[0].changeType, "type");
  assert.equal(facts[0].qualifiedName, "Widget");
  assert.deepEqual(facts[0].evidenceRef, {
    artifact: "source/source-index.json",
    sourceChangeId: "source-main",
    hunkIds: ["hunk-mixed"],
    declarationIds: ["widget-current"],
  });
});

void test("keeps publication groups pure when a hunk also declares a feature", () => {
  const publication = attachSemanticChangeFacts(
    unit("publication", {
      sourceChangeIds: ["source-main"],
      hunkIds: ["hunk-mixed"],
      declarationIds: ["versions-base", "versions-current"],
      declarationNames: ["Versions"],
      groupingEvidence: {
        reasons: ["publication", "governance:api-version"],
        memberHunkIds: ["hunk-mixed"],
      },
    }),
    mixedSourceIndex,
  );
  const feature = attachSemanticChangeFacts(
    unit("feature", {
      sourceChangeIds: ["source-main"],
      hunkIds: ["hunk-mixed"],
      declarationIds: ["widget-current"],
      declarationNames: ["Widget"],
      groupingEvidence: {
        reasons: ["source:source-main"],
        memberHunkIds: ["hunk-mixed"],
      },
    }),
    mixedSourceIndex,
  );

  assert.equal(isVersionGovernanceOnly(publication), true);
  assert.equal(isPublicationGroupingUnit(publication), true);
  assert.equal(isVersionGovernanceOnly(feature), false);
  assert.equal(isPublicationGroupingUnit(feature), false);

  publication.intentType = "api-version-publication";
  const grouped = dedupeSemanticHunks(
    dedupePublicationHunks([publication, feature], mixedSourceIndex.sourceChanges),
    mixedSourceIndex.sourceChanges,
  );

  assert.equal(grouped.length, 1);
  assert.equal(grouped[0].id, "feature");
  assert.deepEqual(grouped[0].hunkIds, ["hunk-mixed"]);
  assert.deepEqual(grouped[0].declarationNames, ["Widget"]);
  assert.deepEqual(grouped[0].changeTypes, ["type"]);
});

void test("selects the same hunk owner regardless of input order", () => {
  const weak = unit("semantic-z", {
    sourceChangeIds: ["source-main"],
    hunkIds: ["hunk-mixed"],
    declarationIds: ["versions-current"],
    declarationNames: ["Versions"],
    changeTypes: ["versioning"],
    changeFacts: [
      {
        id: "fact-version",
        sourceChangeId: "source-main",
        hunkIds: ["hunk-mixed"],
        declarationIds: ["versions-current"],
        beforeDeclarationIds: [],
        afterDeclarationIds: ["versions-current"],
        changeType: "versioning",
        qualifiedName: "Versions",
        action: "add",
        facets: [],
        evidenceRef: {
          artifact: "source/source-index.json",
          sourceChangeId: "source-main",
          hunkIds: ["hunk-mixed"],
          declarationIds: ["versions-current"],
        },
      },
    ],
    groupingEvidence: { reasons: ["governance:api-version"], memberHunkIds: ["hunk-mixed"] },
  });
  const strong = unit("semantic-a", {
    sourceChangeIds: ["source-main"],
    hunkIds: ["hunk-mixed"],
    declarationIds: ["widget-current"],
    declarationNames: ["Widget"],
    changeTypes: ["type"],
    changeFacts: [
      {
        id: "fact-widget",
        sourceChangeId: "source-main",
        hunkIds: ["hunk-mixed"],
        declarationIds: ["widget-current"],
        beforeDeclarationIds: [],
        afterDeclarationIds: ["widget-current"],
        changeType: "type",
        qualifiedName: "Widget",
        action: "add",
        facets: [],
        evidenceRef: {
          artifact: "source/source-index.json",
          sourceChangeId: "source-main",
          hunkIds: ["hunk-mixed"],
          declarationIds: ["widget-current"],
        },
      },
    ],
    groupingEvidence: { reasons: ["feature:widgets"], memberHunkIds: ["hunk-mixed"] },
  });

  const forward = dedupeSemanticHunks([weak, strong], mixedSourceIndex.sourceChanges);
  const reverse = dedupeSemanticHunks([strong, weak], mixedSourceIndex.sourceChanges);

  assert.deepEqual(
    forward.map((item) => item.id),
    reverse.map((item) => item.id),
  );
  assert.equal(forward.length, 1);
  assert.equal(forward[0].declarationNames[0], "Widget");
});
