import { fileURLToPath } from "node:url";
import { parseArgs } from "node:util";
import { planLabels } from "../src/label-catalog.ts";
import { loadLabelCatalog } from "../src/label-catalog-loader.ts";

const { values } = parseArgs({
  options: { preview: { type: "boolean", default: false } },
});
const { catalog } = await loadLabelCatalog(
  fileURLToPath(new URL("../../labels.yaml", import.meta.url)),
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
