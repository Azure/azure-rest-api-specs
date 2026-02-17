import debug from "debug";
import { writeFileSync } from "fs";
import { join } from "path";
import { simpleGit } from "simple-git";
import {
  getChangedFiles,
  resourceManager,
  swagger,
} from "../../shared/src/changed-files.js";
import { checkLease } from "./detect-arm-leases.js";
import { CoreLogger } from "./core-logger.js";
import { detectNewResourceTypes } from "./detect-new-resource-types.js";
import { LabelAction } from "./label.js";

// Enable simple-git debug logging to improve console output
debug.enable("simple-git");

// Match: specification/<service>/resource-manager/<ResourceProvider.Namespace>/...
const RESOURCE_MANAGER_PATTERN = /^specification\/([^/]+)\/resource-manager\/([^/]+)\//;

// Match with optional service group (folder NOT starting with stable/preview)
const RESOURCE_MANAGER_WITH_GROUP_PATTERN =
  /^specification\/[^/]+\/resource-manager\/([^/]+)\/(?!stable|preview)([^/]+)\//;

/** @readonly @enum {string} */
const NewRpLabel = Object.freeze({
  ArmModelingReviewRequired: "ARMModelingReviewRequired",
});

const DEFAULT_LABEL_ACTIONS = Object.freeze({
  [NewRpLabel.ArmModelingReviewRequired]: LabelAction.None,
});

function getLabelActions(hasNewResourceProviders) {
  if (!hasNewResourceProviders) {
    return {
      [NewRpLabel.ArmModelingReviewRequired]: LabelAction.Remove,
    };
  }

  return {
    [NewRpLabel.ArmModelingReviewRequired]: LabelAction.Add,
  };
}

/**
 * Extract resource provider namespaces, service names, and optional service
 * groups from changed file paths.
 *
 * @param {string[]} files - Array of changed file paths
 * @returns {Map<string, {serviceName: string, namespacePath: string, serviceGroup?: string}>}
 */
function extractResourceProviders(files) {
  const resourceProviders = new Map();

  for (const file of files) {
    const match = file.match(RESOURCE_MANAGER_PATTERN);
    if (!match) continue;

    const serviceName = match[1];
    const namespace = match[2];
    if (resourceProviders.has(namespace)) continue;

    const namespacePath = `specification/${serviceName}/resource-manager/${namespace}`;
    const groupMatch = file.match(RESOURCE_MANAGER_WITH_GROUP_PATTERN);
    resourceProviders.set(namespace, {
      serviceName,
      namespacePath,
      serviceGroup: groupMatch?.[2],
    });
  }

  return resourceProviders;
}

/**
 * @param {import("@actions/github-script").AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<{ status: string, labelActions: Record<string, string> }>}
 */
export default async function detectNewResourceProvider({ context, core }) {
  const cwd = process.env.GITHUB_WORKSPACE;
  const git = simpleGit(cwd);

  core.info("Detecting New Resource Providers");

  // Get base branch from context
  const baseBranch = context.payload.pull_request?.base?.ref;
  if (!baseBranch) {
    throw new Error("Could not determine base branch from pull request context");
  }

  // Get the merge base for proper PR comparison.
  // With fetch-depth: 2, HEAD is the PR merge commit and HEAD^ is the base commit.
  // git merge-base may fail if origin/<branch> isn't fetched, so fall back to HEAD^.
  let mergeBase;
  try {
    mergeBase = await git
      .raw(["merge-base", `origin/${baseBranch}`, "HEAD"])
      .then((s) => s.trim());
  } catch {
    mergeBase = "HEAD^";
  }

  const options = {
    cwd,
    paths: ["specification"],
    logger: new CoreLogger(core),
  };

  const changedFiles = await getChangedFiles(options);
  const rmFiles = changedFiles.filter(resourceManager);

  if (rmFiles.length === 0) {
    core.info("No changes to files containing path '/resource-manager/'");
    return {
      status: "no-changes",
      labelActions: DEFAULT_LABEL_ACTIONS,
    };
  }

  // Extract unique resource providers from changed files
  const changedResourceProviders = extractResourceProviders(rmFiles);

  // Determine which namespaces are brand new (no swagger files in base branch)
  const newResourceProviders = [];

  for (const [namespace, info] of changedResourceProviders) {
    try {
      const specFilesBaseBranch = await git.raw([
        "ls-tree",
        "-r",
        "--name-only",
        mergeBase,
        info.namespacePath,
      ]);

      const hasSwaggerInBase = specFilesBaseBranch
        .split("\n")
        .some((file) => resourceManager(file) && swagger(file));

      if (!hasSwaggerInBase) {
        newResourceProviders.push({ namespace, ...info });
      }
    } catch {
      // Directory doesn't exist in base — brand new RP
      newResourceProviders.push({ namespace, ...info });
    }
  }

  if (newResourceProviders.length === 0) {
    core.info("No brand new resource providers detected.");
    core.info("Checking for new resource types in existing RPs...");
    return await checkNewResourceTypesAndReturn({
      repoRoot: cwd,
      mergeBase,
      rmFiles,
      core,
    });
  }

  // Check ARM leases for new resource providers
  core.info(`Detected ${newResourceProviders.length} new resource provider(s)`);

  const leaseCheckResults = [];

  for (const rp of newResourceProviders) {
    const leaseValid = await checkLease(
      rp.serviceName,
      rp.namespace,
      rp.serviceGroup || "",
    );

    leaseCheckResults.push({
      namespace: rp.namespace,
      serviceName: rp.serviceName,
      serviceGroup: rp.serviceGroup,
      leaseValid,
      leaseMessage: leaseValid
        ? "Lease is valid"
        : "No lease file found or lease has expired",
    });

    core.info(
      `  - ${rp.namespace}: ${leaseValid ? "Lease valid" : "Lease invalid"}`,
    );
  }

  writeFileSync(
    join(cwd, ".github", "new-rp-output.json"),
    JSON.stringify({ newResourceProviders: leaseCheckResults }, null, 2),
  );

  const invalidLeases = leaseCheckResults.filter((rp) => !rp.leaseValid);
  const allLeasesValid = invalidLeases.length === 0;

  if (!allLeasesValid) {
    for (const rp of invalidLeases) {
      core.error(`${rp.namespace}: ${rp.leaseMessage}`);
    }
    core.setFailed(
      `${invalidLeases.length} new resource provider(s) detected without a valid ARM lease. ` +
        "Please schedule a discussion at ARM API Modeling Office Hours before merging: " +
        "https://outlook.office365.com/book/ARMOfficeHours1@microsoft.onmicrosoft.com/?ismsaljsauthenabled=true",
    );
  } else {
    core.info(
      "New resource provider(s) detected with valid ARM lease — no action required.",
    );
  }

  return {
    status: allLeasesValid ? "new-rp-all-leases-valid" : "new-rp-invalid-lease",
    labelActions: getLabelActions(!allLeasesValid),
  };
}

/**
 * Check for new resource types in existing RPs using ArmHelper from
 * azure-openapi-validator. If new resource types are detected and the RP
 * has no valid lease, fail the check.
 *
 * @param {Object} params
 * @param {string} params.repoRoot
 * @param {string} params.mergeBase
 * @param {string[]} params.rmFiles
 * @param {import("@actions/core")} params.core
 * @returns {Promise<{ status: string, labelActions: Record<string, string> }>}
 */
async function checkNewResourceTypesAndReturn({
  repoRoot,
  mergeBase,
  rmFiles,
  core,
}) {
  const newResourceTypes = await detectNewResourceTypes({
    repoRoot,
    mergeBase,
    rmFiles,
    core,
  });

  if (newResourceTypes.length === 0) {
    core.info("No new resource types detected in existing RPs.");
    return {
      status: "no-new-rp",
      labelActions: getLabelActions(false),
    };
  }

  core.info(
    `Detected new resource types in ${newResourceTypes.length} existing RP(s)`,
  );

  const invalidLeases = [];

  for (const rt of newResourceTypes) {
    const leaseValid = await checkLease(rt.serviceName, rt.namespace, "");
    const status = leaseValid ? "Lease valid" : "Lease invalid";
    core.info(
      `  - ${rt.namespace} (${rt.newResourceTypes.length} new resource type(s)): ${status}`,
    );
    if (!leaseValid) {
      invalidLeases.push(rt);
    }
  }

  if (invalidLeases.length > 0) {
    for (const rt of invalidLeases) {
      const typeNames = rt.newResourceTypes
        .map((t) => t.resourceType)
        .join(", ");
      core.error(
        `${rt.namespace}: ${rt.newResourceTypes.length} new resource type(s) detected ` +
          `(${typeNames}) but no valid ARM lease found.`,
      );
    }
    core.setFailed(
      `${invalidLeases.length} existing resource provider(s) have new resource types without a valid ARM lease. ` +
        "New resource types in existing RPs also require an ARM lease. " +
        "Please schedule a discussion at ARM API Modeling Office Hours before merging: " +
        "https://outlook.office365.com/book/ARMOfficeHours1@microsoft.onmicrosoft.com/?ismsaljsauthenabled=true",
    );
    return {
      status: "new-resource-types-invalid-lease",
      labelActions: getLabelActions(true),
    };
  }

  core.info(
    "New resource types detected with valid ARM lease — no action required.",
  );
  return {
    status: "new-resource-types-all-leases-valid",
    labelActions: getLabelActions(false),
  };
}
