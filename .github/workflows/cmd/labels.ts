import { readFile } from "node:fs/promises";
import { parseArgs } from "node:util";
import { parseLabelCatalog, planLabels } from "../src/label-catalog.ts";

const { values } = parseArgs({
  options: { preview: { type: "boolean", default: false } },
});
const catalog = parseLabelCatalog(
  await readFile(new URL("../../labels.yaml", import.meta.url), "utf8"),
);
if (values.preview) {
  const { Octokit } = await import("@octokit/rest");
  const { listRepositoryLabels } = await import("../src/sync-repo-labels.ts");
  const github = new Octokit({ auth: process.env.GITHUB_TOKEN });
  const existing = await listRepositoryLabels(github, {
    owner: "Azure",
    repo: "azure-rest-api-specs",
  });
  console.log(
    JSON.stringify(
      { policy: catalog.unconfiguredLabels, ...planLabels(catalog, existing) },
      null,
      2,
    ),
  );
} else {
  console.log(
    `Validated ${catalog.labels.length} labels; unconfiguredLabels: ${catalog.unconfiguredLabels}`,
  );
}
