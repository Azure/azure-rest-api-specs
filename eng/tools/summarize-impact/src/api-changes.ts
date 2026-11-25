import { createHash } from "node:crypto";
import { readFileSync } from "node:fs";
import { basename, resolve } from "node:path";
import { swagger, tsp } from "@azure-tools/specs-shared/changed-files";
import type { PRContext } from "./PRContext.ts";

function isApiDefinition(file: string): boolean {
  const filename = basename(file).toLowerCase();
  if (tsp(file)) return filename !== "client.tsp";
  // Keep the existing Swagger path classifier, including definition fragments.
  return (
    swagger(file) &&
    !["package.json", "package-lock.json", "npm-shrinkwrap.json"].includes(filename) &&
    !/^(?:tsconfig|jsconfig)(?:\.[^.]+)*\.json$/.test(filename)
  );
}

/**
 * Supplies impact.ts with review-eligible files and verified unchanged moves.
 * Eligibility is path-based, not semantic: inline docs and formatting still count.
 *
 * The CLI uses --no-renames to retain both paths' service attribution.
 * typespec-suppressions and spec-change-policies consume Git renames; this matcher
 * instead pairs byte-identical content within the same service, plane, and file kind.
 * getServiceKey must use the supplied revision root (base for deletions, head for
 * additions) so a changed head config cannot hide a cross-plane move.
 */
export function getApiDefinitionChanges(
  context: PRContext,
  getServiceKey: (file: string, root: string) => string | undefined,
): { changedFiles: Set<string>; unchangedMoves: Map<string, string> } {
  const deletions = new Set(context.fileList?.deletions);
  const changedFiles = new Set(context.getChangedFiles().filter(isApiDefinition));
  const unchangedMoves = new Map<string, string>();
  const additions = (context.fileList?.additions ?? []).filter((file) => changedFiles.has(file));
  if (additions.length === 0) return { changedFiles, unchangedMoves };

  const servicesByAddition = new Map(
    additions.map((file) => [file, getServiceKey(file, context.sourceDirectory)]),
  );
  const addedServices = new Set(servicesByAddition.values());
  const deletedByService = new Map<string, Map<string, string[]>>();
  const fingerprint = (root: string, file: string) =>
    `${tsp(file) ? "tsp" : "swagger"}:${createHash("sha256")
      .update(readFileSync(resolve(root, file)))
      .digest("hex")}`;

  for (const file of deletions) {
    if (!changedFiles.has(file)) continue;
    const service = getServiceKey(file, context.targetDirectory);
    if (!service || !addedServices.has(service)) continue;
    let hashes = deletedByService.get(service);
    if (!hashes) {
      hashes = new Map();
      deletedByService.set(service, hashes);
    }
    const hash = fingerprint(context.targetDirectory, file);
    const matches = hashes.get(hash) ?? [];
    matches.push(file);
    hashes.set(hash, matches);
  }

  for (const file of additions) {
    const service = servicesByAddition.get(file);
    const hashes = service && deletedByService.get(service);
    if (!hashes) continue;
    // Consume each deletion once: an additional identical copy is still an addition.
    const from = hashes.get(fingerprint(context.sourceDirectory, file))?.pop();
    if (from === undefined) continue;
    unchangedMoves.set(file, from);
    changedFiles.delete(from);
    changedFiles.delete(file);
  }
  return { changedFiles, unchangedMoves };
}
