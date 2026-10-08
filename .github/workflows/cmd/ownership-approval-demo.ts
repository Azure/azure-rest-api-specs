import {
  evaluateOwnershipApproval,
  renderOwnershipApproval,
  type OwnershipPolicy,
} from "../src/ownership-approval.ts";

const policy: OwnershipPolicy = {
  maintainers: "@Azure/example-maintainers",
  "client-team": "@Azure/example-client-team",
};
const codeowners = `
* @Azure/example-maintainers
/specification/storage/ @storage-owner
/specification/compute/ @compute-owner
`;
const members: Record<string, string[]> = {
  "@Azure/example-maintainers": ["repo-maintainer"],
  "@Azure/example-client-team": ["client-reviewer"],
};
const spec = "specification/storage/Storage/main.tsp";
const client = "specification/storage/Storage/client.tsp";
const cases = [
  {
    title: "Service owner reviews their specification",
    files: [spec],
    approvers: ["storage-owner"],
  },
  { title: "Client team reviews client.tsp", files: [client], approvers: ["client-reviewer"] },
  {
    title: "Client team cannot approve unrelated specification changes",
    files: [spec, client],
    approvers: ["client-reviewer"],
  },
  {
    title: "Maintainer reviews specification and engineering changes",
    files: [spec, client, "eng/tool.ts"],
    approvers: ["repo-maintainer"],
  },
];
for (const scenario of cases) {
  const result = await evaluateOwnershipApproval(
    scenario.files,
    codeowners,
    policy,
    scenario.approvers,
    (team, username) => Promise.resolve((members[team] ?? []).includes(username)),
  );
  console.log(`## ${scenario.title}: ${result.missing.length ? "BLOCKED" : "APPROVED"}\n`);
  console.log(`${renderOwnershipApproval(result)}\n`);
}
