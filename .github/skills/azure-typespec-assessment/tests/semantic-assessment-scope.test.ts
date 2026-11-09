import { assert, test } from "vitest";
import {
  informationalIntentText,
  isApiVersionWideChangeIntent,
  isInformationalIntent,
  isInformationalPublicationIntent,
  partitionSemanticIntents,
  semanticIntentType,
} from "../scripts/semantic-assessment-scope.ts";

function publicationUnit(operationCount = 20) {
  return {
    id: "semantic-publication",
    groupingEvidence: {
      reasons: ["governance:api-version", "publication"],
    },
    operations: Array.from({ length: operationCount }, (_, index) => ({
      operationId: `Widgets_${index}`,
      matchBasis: "version-transition-change",
    })),
  };
}

void test("classifies every version publication intent as informational", () => {
  const publication = publicationUnit();
  const assessed = {
    id: "semantic-model-change",
    groupingEvidence: { reasons: ["feature:Widget"] },
    operations: [
      {
        operationId: "Widgets_Update",
        matchBasis: "compiler-reference",
      },
    ],
  };

  assert.equal(isInformationalPublicationIntent(publication), true);
  assert.equal(isInformationalPublicationIntent(publicationUnit(19)), true);
  assert.equal(isInformationalPublicationIntent(publicationUnit(0)), true);
  assert.deepEqual(partitionSemanticIntents([publication, assessed]), {
    assessed: [assessed],
    informational: [publication],
  });
  assert.match(informationalIntentText(publication).summary, /20 existing operations/);
});

void test("keeps mixed publication and feature facts in normal Agent coverage", () => {
  const mixed = {
    ...publicationUnit(),
    declarationNames: ["Versions", "Widget"],
    changeTypes: ["type", "versioning"],
    changeFacts: [{ qualifiedName: "Versions" }, { qualifiedName: "Widget" }],
  };

  assert.equal(semanticIntentType(mixed), "normal");
  assert.equal(isInformationalPublicationIntent(mixed), false);
  assert.equal(isInformationalIntent(mixed), false);
  assert.deepEqual(partitionSemanticIntents([mixed]), {
    assessed: [mixed],
    informational: [],
  });
});

void test("classifies version-wide changes without an operation threshold", () => {
  const versionWide = {
    id: "semantic-version-wide",
    declarationNames: ["Versions"],
    ownedOperationIds: [],
    operations: Array.from({ length: 2 }, (_, index) => ({
      operationId: `Widgets_${index}`,
      matchBasis: "version-transition-change",
    })),
  };
  const normal = {
    ...versionWide,
    id: "semantic-normal",
    declarationNames: ["Widgets"],
  };

  assert.equal(isInformationalPublicationIntent(versionWide), false);
  assert.equal(isApiVersionWideChangeIntent(versionWide), true);
  assert.equal(isInformationalIntent(versionWide), true);
  assert.equal(semanticIntentType(versionWide), "api-version-wide-change");
  assert.equal(isInformationalIntent(normal), false);
  assert.match(informationalIntentText(versionWide).summary, /2 affected operations/);
});
