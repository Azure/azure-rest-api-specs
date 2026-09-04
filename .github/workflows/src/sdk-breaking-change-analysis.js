import { SdkName } from "../../shared/src/sdk-types.js";

/**
 * Resolve the target SDK repository from completed SDK Validation checks.
 *
 * @param {Object} params
 * @param {import('@actions/github-script').AsyncFunctionArguments['github']} params.github
 * @param {string} params.owner
 * @param {string} params.repo
 * @param {string} params.headSha
 * @param {number} params.pullNumber
 * @returns {Promise<string>}
 */
export async function resolveSdkValidationRepository({
  github,
  owner,
  repo,
  headSha,
  pullNumber,
}) {
  const checks = await github.paginate(github.rest.checks.listForRef, {
    owner,
    repo,
    ref: headSha,
    per_page: 100,
  });
  const sdkValidationChecks = checks
    .filter(
      (check) =>
        check.app?.name === "Azure Pipelines" &&
        check.name.includes("SDK Validation") &&
        check.status === "completed",
    )
    .sort((left, right) =>
      (right.completed_at ?? "").localeCompare(left.completed_at ?? ""),
    );

  for (const check of sdkValidationChecks) {
    const normalizedName = check.name.toLowerCase();
    const exactRepository = Object.values(SdkName).find((name) =>
      normalizedName.includes(name),
    );
    if (exactRepository) {
      return exactRepository;
    }
    if (normalizedName.includes("javascript")) return SdkName.Js;
    if (normalizedName.includes("python")) return SdkName.Python;
    if (normalizedName.includes(".net") || normalizedName.includes("dotnet"))
      return SdkName.Net;
    if (normalizedName.includes("java")) return SdkName.Java;
    if (normalizedName.includes("rust")) return SdkName.Rust;
    if (/\bgo\b/.test(normalizedName)) return SdkName.Go;
  }

  throw new Error(
    `No completed Azure Pipelines SDK Validation check with a recognized language found for PR #${pullNumber}.`,
  );
}
