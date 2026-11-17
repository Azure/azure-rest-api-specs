import { assert, test } from "vitest";
import { matchRestFindingIntents } from "../scripts/assemble-assessment.ts";
import type { SourceDeclaration } from "../scripts/runtime-types.ts";

type Intent = Parameters<typeof matchRestFindingIntents>[1][number];
const model: SourceDeclaration = {
  id: "model",
  kind: "model",
  qualifiedName: "Service.CloudAccountProperties",
  decorators: [],
  versionedMembers: [],
  hunkIds: ["changed", "other"],
  source: { revision: "current", startLine: 1, endLine: 20 },
};
const member: SourceDeclaration = {
  ...model,
  id: "member",
  kind: "property",
  qualifiedName: "Service.CloudAccountProperties.principal",
  hunkIds: ["changed"],
};
function intent(id = "semantic-owner", projectId = "project"): Intent {
  return {
    id,
    projectId,
    declarationIds: ["model", "member"],
    hunkIds: ["changed"],
    operations: [],
    sources: [
      {
        id: "source",
        path: "models.tsp",
        status: "modified",
        origins: [],
        hunks: [],
        declarations: [model, member],
      },
    ],
  };
}
const finding: Parameters<typeof matchRestFindingIntents>[0] = {
  rule: "serialized-property-removed",
  contractChange: { location: "request body.principal" },
  operationIds: ["Accounts_Create"],
  sourceChangeIds: ["source"],
  evidence: [
    {
      projectId: "project",
      comparisonRole: "baseline",
      request: {
        kind: "body",
        schema: {
          kind: "object",
          reference: "#/definitions/CloudAccountProperties",
          properties: [
            {
              name: "principal",
              required: false,
              schema: { kind: "object", reference: "#/definitions/EntityInfo" },
            },
          ],
        },
      },
    },
  ],
};
test("model member finding links by changed declaration ownership without an operation mapping", () => {
  assert.deepEqual(
    matchRestFindingIntents(finding, [intent()]).map((i) => i.id),
    ["semantic-owner"],
  );
});
test("same source file or unowned declaration does not establish a relationship", () => {
  const unrelated = intent("unrelated");
  unrelated.declarationIds = ["different"];
  assert.deepEqual(matchRestFindingIntents(finding, [unrelated]), []);
});
test("same model in another member's intent is not linked", () => {
  const other = intent("other-member");
  other.hunkIds = ["other"];
  other.declarationIds = ["model"];
  assert.deepEqual(
    matchRestFindingIntents(finding, [intent(), other]).map((i) => i.id),
    ["semantic-owner"],
  );
});
test("cross-project and informational ownership are excluded", () => {
  assert.deepEqual(matchRestFindingIntents(finding, [intent("foreign", "other-project")]), []);
  assert.deepEqual(matchRestFindingIntents(finding, [{ ...intent(), informational: true }]), []);
});
test("ambiguous ownership is not guessed", () => {
  assert.deepEqual(matchRestFindingIntents(finding, [intent("one"), intent("two")]), []);
});
test("unique owning-model evidence works when compiler member declarations are unavailable", () => {
  const owner = intent();
  owner.sources[0].declarations = [model];
  assert.deepEqual(
    matchRestFindingIntents(finding, [owner]).map((i) => i.id),
    ["semantic-owner"],
  );
});
test("direct operation findings retain operation-identity matching", () => {
  const owner = intent();
  owner.operations = [
    {
      operationId: "Accounts_Create",
      matchBasis: "operation-identity",
      sourceChangeIds: ["source"],
      hunkIds: ["changed"],
      declarationIds: ["operation"],
    },
  ];
  assert.deepEqual(
    matchRestFindingIntents(
      { ...finding, rule: "path-changed", contractChange: { location: "path" } },
      [owner],
    ).map((i) => i.id),
    ["semantic-owner"],
  );
});
