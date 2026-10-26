import assert from "node:assert/strict";
import { spawnSync } from "node:child_process";
import { copyFileSync, mkdirSync, readFileSync, writeFileSync } from "node:fs";
import os from "node:os";
import path from "node:path";
import { isDeepStrictEqual } from "node:util";
import { fileURLToPath } from "node:url";

const project = fileURLToPath(new URL("../", import.meta.url));
const root = path.resolve(project, "../../../../..");
const version = "2026-09-15-preview";
const output = path.resolve(
  process.argv[2] ?? path.join(os.tmpdir(), "acs-egress-typespec"),
);
assert(
  !output.startsWith(project),
  "Use a scratch output directory outside the service",
);
mkdirSync(output, { recursive: true });
const emitter = "@azure-tools/typespec-autorest";
const compiler = path.join(root, "node_modules/@typespec/compiler/cmd/tsp.js");
const result = spawnSync(
  process.execPath,
  [
    compiler,
    "compile",
    project,
    "--option",
    `${emitter}.version=${version}`,
    "--option",
    `${emitter}.service-yaml=never`,
    "--option",
    `${emitter}.emitter-output-dir=${output}`,
    "--option",
    `${emitter}.arm-types-dir=${path.resolve(root, "specification/common-types/resource-management")}`,
  ],
  { cwd: root, encoding: "utf8", maxBuffer: 32 * 1024 * 1024 },
);
writeFileSync(
  path.join(output, "compile.log"),
  (result.stdout ?? "") + (result.stderr ?? ""),
);
process.stdout.write(result.stdout ?? "");
process.stderr.write(result.stderr ?? "");
assert.equal(
  result.status,
  0,
  "TypeSpec compilation must succeed before publishing output",
);

const generatedFile = path.join(
  output,
  `preview/${version}/cognitiveservices.json`,
);
const generated = JSON.parse(readFileSync(generatedFile, "utf8"));
const destination = path.join(
  project,
  `preview/${version}/cognitiveservices.json`,
);
const original = JSON.parse(readFileSync(destination, "utf8"));
const candidate = structuredClone(original);
candidate.definitions.RaiPolicyProperties.properties.egressPolicy.description =
  generated.definitions.RaiPolicyProperties.properties.egressPolicy.description;
const filenames = [
  "PutRaiPolicyAcsWithEgress.json",
  "GetRaiPolicyAcsWithEgress.json",
  "ListRaiPoliciesAcsWithEgress.json",
];
for (const filename of filenames) {
  const example = JSON.parse(
    readFileSync(path.join(project, `examples/${version}/${filename}`), "utf8"),
  );
  const route = Object.keys(generated.paths).find((routePath) =>
    Object.values(generated.paths[routePath]).some(
      (operation) => operation.operationId === example.operationId,
    ),
  );
  assert(route, `Missing operation ${example.operationId}`);
  const method = Object.keys(generated.paths[route]).find(
    (methodName) =>
      generated.paths[route][methodName].operationId === example.operationId,
  );
  const reference =
    generated.paths[route][method]["x-ms-examples"][example.title];
  assert.deepEqual(reference, { $ref: `./examples/${filename}` });
  candidate.paths[route][method]["x-ms-examples"][example.title] = reference;
}
const differences = [];
function compare(before, after, pointer = "") {
  if (isDeepStrictEqual(before, after)) return;
  if (
    before &&
    after &&
    typeof before === "object" &&
    typeof after === "object"
  ) {
    for (const key of new Set([
      ...Object.keys(before),
      ...Object.keys(after),
    ])) {
      compare(
        before[key],
        after[key],
        `${pointer}/${key.replaceAll("~", "~0").replaceAll("/", "~1")}`,
      );
    }
  } else {
    differences.push({ pointer, before, after });
  }
}
compare(candidate, generated);
const semanticDifferences = differences.filter(({ pointer, before, after }) => {
  if (
    !pointer.endsWith("/$ref") ||
    typeof before !== "string" ||
    typeof after !== "string"
  ) {
    return true;
  }
  const target = (file, reference) => {
    const [relative, fragment] = reference.split("#");
    return `${path.resolve(path.dirname(file), relative)}#${fragment ?? ""}`;
  };
  return target(destination, before) !== target(generatedFile, after);
});
writeFileSync(
  path.join(output, "full-emission-diff.json"),
  JSON.stringify(differences, null, 2) + "\n",
);
writeFileSync(
  path.join(output, "candidate.json"),
  JSON.stringify(candidate, null, 2) + "\n",
);
writeFileSync(
  path.join(output, "generation-comparison.json"),
  JSON.stringify(
    {
      version,
      completeGenerationMatchesScopedCandidate: differences.length === 0,
      excludedEmissionDifferences: differences.length,
      nonRelocationDifferences: semanticDifferences.length,
      copiedPaths: [
        "definitions.RaiPolicyProperties.properties.egressPolicy.description",
        ...filenames,
      ],
    },
    null,
    2,
  ) + "\n",
);
assert.equal(
  semanticDifferences.length,
  0,
  "Unexpected semantic emission changes; inspect full-emission-diff.json before changing the generation scope",
);
writeFileSync(destination, JSON.stringify(candidate, null, 2) + "\n");
for (const filename of filenames) {
  copyFileSync(
    path.join(project, `examples/${version}/${filename}`),
    path.join(project, `preview/${version}/examples/${filename}`),
  );
}
console.log(
  "Generated preview-only egress description and three example references; other Swagger semantics preserved.",
);
