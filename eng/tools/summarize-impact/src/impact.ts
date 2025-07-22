#!/usr/bin/env node

import * as fs from "fs";
import { glob } from "glob";
import * as path from "path";

import * as commonmark from "commonmark";
import yaml from "js-yaml";
import * as _ from "lodash";

import { breakingChangesCheckType } from "@azure-tools/specs-shared/breaking-change";

import {
  DiffResult,
  ReadmeTag,
  FileTypes,
  ChangeTypes,
  PRChange,
  ChangeHandler,
} from "./diff-types.js";

import { PRType, Label, LabelContext } from "./labelling-types.js";

import { ImpactAssessment } from "./ImpactAssessment.js";
import { PRContext } from "./PRContext.js";

import { Readme } from "@azure-tools/specs-shared/readme";

export const breakingChangeLabelVarName = "breakingChangeVar";
export const crossVersionBreakingChangeLabelVarName = "crossVersionBreakingChangeVar";

// todo: we need to populate this so that we can tell if it's a new APIVersion down stream
export async function isNewApiVersion(context: PRContext): Promise<boolean> {
  const handlers: ChangeHandler[] = [];
  let isAddingNewApiVersion = false;
  const apiVersionSet = new Set<string>();

  const rpFolders = new Set<string>();

  const createSwaggerFileHandler = () => {
    return (e: PRChange) => {
      if (e.changeType === "Addition") {
        const apiVersion = getApiVersionFromSwaggerFile(e.filePath);
        if (apiVersion) {
          apiVersionSet.add(apiVersion);
        }
        const rpFolder = getRPFolderFromSwaggerFile(e.filePath);
        if (rpFolder !== undefined) {
          rpFolders.add(rpFolder);
        }
        console.log(`apiVersion: ${apiVersion}, rpFolder: ${rpFolder}`);
      } else if (e.changeType === "Update") {
        const rpFolder = getRPFolderFromSwaggerFile(e.filePath);
        if (rpFolder !== undefined) {
          rpFolders.add(rpFolder);
        }
      }
    };
  };

  handlers.push({ SwaggerFile: createSwaggerFileHandler() });
  await processPrChanges(context, handlers);

  console.log(`rpFolders: ${Array.from(rpFolders).join(",")}`);

  const firstRPFolder = Array.from(rpFolders)[0];

  console.log(`apiVersion: ${Array.from(apiVersionSet).join(",")}`);

  if (firstRPFolder === undefined) {
    console.log("RP folder not found.");
    return false;
  }

  const targetBranchRPFolder = path.resolve(context.targetDirectory, firstRPFolder);

  console.log(`targetBranchRPFolder: ${targetBranchRPFolder}`);

  const existingApiVersions = getAllApiVersionFromRPFolder(targetBranchRPFolder);

  console.log(`existingApiVersions: ${existingApiVersions.join(",")}`);

  for (const apiVersion of apiVersionSet) {
    if (!existingApiVersions.includes(apiVersion)) {
      console.log(`The apiVersion ${apiVersion} is added. and not found in existing ApiVersions`);
      isAddingNewApiVersion = true;
    }
  }
  return isAddingNewApiVersion;
}

export async function evaluateImpact(
  context: PRContext,
  labelContext: LabelContext,
): Promise<ImpactAssessment> {
  const typeSpecLabelShouldBePresent = await processTypeSpec(context, labelContext);

  // examine changed files. if changedpaths includes data-plane, add "data-plane"
  // same for "resource-manager". We care about whether resourcemanager will be present for a later check
  const { resourceManagerLabelShouldBePresent } = await processPRType(context, labelContext);

  // Has to be run in a PR context. Uses addition and update to understand
  // if the suppressions have been changed. If they have, suppressionReviewRequired must be added
  // as a label
  const suppressionRequired = await processSuppression(context, labelContext);
  console.log(`suppressionRequired: ${suppressionRequired}`);

  // Calculates whether or not BreakingChangeReviewRequired and VersioningReviewRequired labels should be present
  let versioningReviewRequiredLabelShouldBePresent: boolean = false;
  let breakingChangeReviewRequiredLabelShouldBePresent: boolean = false;
  try {
    ({
      versioningReviewRequiredLabelShouldBePresent,
      breakingChangeReviewRequiredLabelShouldBePresent,
    } = await processBreakingChangeLabels(context, labelContext));
  } catch (error) {
    console.error("Error processing breaking change labels:", error);
  }

  // needs to examine "after" context to understand if a readme that was changed is RPaaS or not
  const { rpaasLabelShouldBePresent } = await processRPaaS(context, labelContext);

  // Has to be in PR context. Uses the addition to understand if the newRPNamespace label should be present.
  const { newRPNamespaceLabelShouldBePresent } = await processNewRPNamespace(
    context,
    labelContext,
    resourceManagerLabelShouldBePresent,
  );

  // doesn't necessarily need to be in the PR context.
  // Uses the previous outputs that DID need to be a PR context, but otherwise only examines targetBranch and those
  // output labels.
  const { ciNewRPNamespaceWithoutRpaaSLabelShouldBePresent, rpaasExceptionLabelShouldBePresent } =
    await processNewRpNamespaceWithoutRpaasLabel(
      context,
      labelContext,
      resourceManagerLabelShouldBePresent,
      newRPNamespaceLabelShouldBePresent,
      rpaasLabelShouldBePresent,
    );

  // examines the additions. if the changetype is addition, then it will add the ciRpaasRPNotInPrivateRepo label
  const { ciRpaasRPNotInPrivateRepoLabelShouldBePresent } =
    await processRpaasRpNotInPrivateRepoLabel(
      context,
      labelContext,
      resourceManagerLabelShouldBePresent,
      rpaasLabelShouldBePresent,
    );

  const newApiVersion = await isNewApiVersion(context);

  return {
    suppressionReviewRequired: labelContext.toAdd.has("suppressionsReviewRequired"),
    versioningReviewRequired: versioningReviewRequiredLabelShouldBePresent,
    breakingChangeReviewRequired: breakingChangeReviewRequiredLabelShouldBePresent,
    rpaasChange: rpaasLabelShouldBePresent,
    newRP: newRPNamespaceLabelShouldBePresent,
    rpaasRPMissing: ciNewRPNamespaceWithoutRpaaSLabelShouldBePresent,
    rpaasRpNotInPrivateRepo: ciRpaasRPNotInPrivateRepoLabelShouldBePresent,
    resourceManagerRequired: resourceManagerLabelShouldBePresent,
    rpaasExceptionRequired: rpaasExceptionLabelShouldBePresent,
    typeSpecChanged: typeSpecLabelShouldBePresent,
    isNewApiVersion: newApiVersion,
    isDraft: context.isDraft,
    labelContext: labelContext,
    targetBranch: context.targetBranch,
  };
}

export function isManagementPR(filePaths: string[]): boolean {
  return filePaths.some((it) => it.includes("resource-manager"));
}

export function isDataPlanePR(filePaths: string[]): boolean {
  return filePaths.some((it) => it.includes("data-plane"));
}

export function getAllApiVersionFromRPFolder(rpFolder: string): string[] {
  const allSwaggerFilesFromRPFolder = glob.sync(`${rpFolder}/**/*.json`);
  console.log(`allSwaggerFilesFromRPFolder: ${allSwaggerFilesFromRPFolder}`);

  const apiVersions: Set<string> = new Set();
  for (const it of allSwaggerFilesFromRPFolder) {
    if (!it.includes("examples")) {
      const apiVersion = getApiVersionFromSwaggerFile(it);
      console.log(`Get api version from swagger file: ${it}, apiVersion: ${apiVersion}`);
      if (apiVersion) {
        apiVersions.add(apiVersion);
      }
    }
  }
  return [...apiVersions];
}

export function getApiVersionFromSwaggerFile(swaggerFile: string): string | undefined {
  const swagger = fs.readFileSync(swaggerFile).toString();
  const swaggerObject = JSON.parse(swagger);
  if (swaggerObject["info"] && swaggerObject["info"]["version"]) {
    return swaggerObject["info"]["version"];
  }
  return undefined;
}

export function getRPFolderFromSwaggerFile(swaggerFile: string): string | undefined {
  const resourceProvider = getResourceProviderFromFilePath(swaggerFile);

  if (resourceProvider === undefined) {
    return undefined;
  }

  const lastIdx = swaggerFile.lastIndexOf(resourceProvider!);
  return swaggerFile.substring(0, lastIdx + resourceProvider!.length);
}

export const getResourceProviderFromFilePath = (filePath: string): string | undefined => {
  // Example filePath:
  //   specification/purview/data-plane/Azure.Analytics.Purview.Workflow/preview/2023-10-01-preview/purviewWorkflow.json
  // Match:
  //   /Azure.Analytics.Purview.Workflow/
  // Note:
  // The regex matches a directory name in the path of form: /Foo.Bar.Baz/, where:
  // - The directory name must have at least one period. If it would match 0 periods,
  //   then in the example path it would match to "/purview/" instead.
  // - The directory name can have one or more periods.
  //   The "Foo.Bar.Baz" example given above has two periods.
  const regex = /\/([a-z0-9]+(\.[a-z0-9]+)+)\//i;
  const match = filePath.match(regex);
  if (match && match.length > 0) {
    return match[1];
  }
  // Second matching attempt to cover scenarios in which:
  // - the resource provider is for data-plane
  // - and it has no dots in the name.
  //
  // Example filePath:
  //   specification/communication/data-plane/Sms/preview/2024-02-05-preview/communicationServicesSms.json
  // Match:
  //  /Sms/
  //
  // For details see: https://github.com/Azure/azure-sdk-tools/issues/7552
  const regexForDirImmediatelyAfterDataPlane = /\/data-plane\/([a-z0-9]+)\//i;
  const match2 = filePath.match(regexForDirImmediatelyAfterDataPlane);
  if (match2 && match2.length > 0) {
    return match2[1];
  }

  return undefined;
};

// todo: download the labels from the breaking change check run
// right now this logic is coded to parse the ADO build variables that are set
// by the breakingchange run in an earlier job.
async function processBreakingChangeLabels(
  prContext: PRContext,
  labelContext: LabelContext,
): Promise<{
  versioningReviewRequiredLabelShouldBePresent: boolean;
  breakingChangeReviewRequiredLabelShouldBePresent: boolean;
}> {
  console.log("ENTER definition processBreakingChangeLabels");

  // Debug the breakingChangesCheckType import
  console.log("breakingChangesCheckType:", breakingChangesCheckType);
  console.log("breakingChangesCheckType.SameVersion:", breakingChangesCheckType?.SameVersion);
  console.log("breakingChangesCheckType.CrossVersion:", breakingChangesCheckType?.CrossVersion);

  const prTargetsProductionBranch: boolean = checkPrTargetsProductionBranch(prContext);
  const breakingChangesLabelsFromOad = getBreakingChangesLabelsFromOad();

  const versioningReviewRequiredLabel = new Label(
    breakingChangesCheckType.SameVersion.reviewRequiredLabel,
    labelContext.present,
  );

  const breakingChangeReviewRequiredLabel = new Label(
    breakingChangesCheckType.CrossVersion.reviewRequiredLabel,
    labelContext.present,
  );

  const versioningApprovalLabels = breakingChangesCheckType.SameVersion.approvalLabels.map(
    (label: string) => new Label(label, labelContext.present),
  );
  const breakingChangeApprovalLabels = breakingChangesCheckType.CrossVersion.approvalLabels.map(
    (label: string) => new Label(label, labelContext.present),
  );

  // ----- Breaking changes label processing logic -----
  // These lines implement the set of rules determining which of the breaking change
  // labels should be present on given PR.
  // The doc describing breaking change review rules can be found here:
  // https://aka.ms/brch-dev

  // ❗ IMPORTANT ❗: this MUST be set BEFORE versioningReviewRequiredLabel.shouldBePresent
  // due to logical dependency
  breakingChangeReviewRequiredLabel.shouldBePresent =
    // "BreakingChangeReviewRequired" label should be present if
    // 1. The PR targets a production branch
    prTargetsProductionBranch &&
    // 2. AND given OAD run determined it is still applicable.
    breakingChangesLabelsFromOad.includes(breakingChangeReviewRequiredLabel.name);

  // ❗ IMPORTANT ❗: this MUST be set AFTER breakingChangeReviewRequiredLabel.shouldBePresent
  // due to logical dependency
  versioningReviewRequiredLabel.shouldBePresent =
    // "VersioningReviewRequired" label should be unconditionally removed if
    // the label "BreakingChangeReviewRequired" should be present.
    !breakingChangeReviewRequiredLabel.shouldBePresent &&
    // AND "VersioningReviewRequired" label should be present if
    // 1. The PR targets a production branch
    prTargetsProductionBranch &&
    // 2. AND given OAD run determined it is still applicable.
    breakingChangesLabelsFromOad.includes(versioningReviewRequiredLabel.name);

  versioningApprovalLabels.forEach((approvalLabel) => {
    approvalLabel.shouldBePresent =
      approvalLabel.present && versioningReviewRequiredLabel.shouldBePresent;
  });

  breakingChangeApprovalLabels.forEach((approvalLabel) => {
    approvalLabel.shouldBePresent =
      approvalLabel.present && breakingChangeReviewRequiredLabel.shouldBePresent;
  });

  // ----------

  applyLabelsStateChanges(labelContext.toAdd, labelContext.toRemove);

  logDiagInfo();

  return {
    versioningReviewRequiredLabelShouldBePresent: versioningReviewRequiredLabel.shouldBePresent,
    breakingChangeReviewRequiredLabelShouldBePresent:
      breakingChangeReviewRequiredLabel.shouldBePresent,
  };

  /**
   * Get labels denoting required breaking change or versioning review.
   * The labels are read from ADO pipeline environment variables.
   * These variables are set to appropriate value by BreakingChangesRuleManager.addBreakingChangeLabels().
   * Read that function's comment for details.
   */
  function getBreakingChangesLabelsFromOad(): string[] {
    const oadLabelsEnvVars = [
      breakingChangeLabelVarName.toUpperCase(),
      crossVersionBreakingChangeLabelVarName.toUpperCase(),
    ];
    let breakingChangeLabelsFromOad: string[] = _.uniq(
      oadLabelsEnvVars
        .map((labelSenderEnvVar) => process.env[labelSenderEnvVar])
        .filter((envVarValue) => envVarValue !== undefined)
        .map((envVarValue) => envVarValue?.split(",") || [])
        .reduce(
          (accumulatedLabels, currentEnvVarLabels) => accumulatedLabels.concat(currentEnvVarLabels),
          [],
        ),
    ).filter((label) => label);
    return breakingChangeLabelsFromOad;
  }

  function applyLabelsStateChanges(labelsToAdd: Set<string>, labelsToRemove: Set<string>) {
    breakingChangeReviewRequiredLabel.applyStateChange(labelsToAdd, labelsToRemove);
    versioningReviewRequiredLabel.applyStateChange(labelsToAdd, labelsToRemove);
    versioningApprovalLabels.forEach((approvalLabel) => {
      approvalLabel.applyStateChange(labelsToAdd, labelsToRemove);
    });
    breakingChangeApprovalLabels.forEach((approvalLabel) => {
      approvalLabel.applyStateChange(labelsToAdd, labelsToRemove);
    });
  }

  function logDiagInfo() {
    if (
      !prTargetsProductionBranch &&
      (breakingChangesLabelsFromOad.includes(breakingChangeReviewRequiredLabel.name) ||
        breakingChangesLabelsFromOad.includes(versioningReviewRequiredLabel.name))
    ) {
      // We are using this log as a metric to track and measure impact of the work on improving "breaking changes" tooling. Log statement added around 11/29/2023.
      // See: https://github.com/Azure/azure-sdk-tools/issues/7223#issuecomment-1839830834
      // Note it duplicates the label "shouldBePresent" ruleset logic.
      console.log(
        `processBreakingChangeLabels: PR: ${`https://github.com/${prContext.owner}/${prContext.repo}/pull/${prContext.prNumber}`}, targetBranch: ${prContext.targetBranch}. ` +
          `The addition of 'BreakingChangesReviewRequired' or 'VersioningReviewRequired' labels has been prevented ` +
          `because we checked that the PR is not targeting a production branch.`,
      );
    }

    console.log(
      `processBreakingChangeLabels returned. ` +
        `prTargetsProductionBranch: ${prTargetsProductionBranch}, ` +
        breakingChangeReviewRequiredLabel.logString() +
        versioningReviewRequiredLabel.logString(),
    );
  }
}

/**
 * The "production" branches are defined at https://aka.ms/azsdk/pr-brch-deep
 */
function checkPrTargetsProductionBranch(prContext: PRContext): boolean {
  const targetsPublicProductionBranch =
    prContext.repo.includes("azure-rest-api-specs") &&
    prContext.repo !== "azure-rest-api-specs-pr" &&
    prContext.targetBranch === "main";

  const targetsPrivateProductionBranch =
    prContext.repo === "azure-rest-api-specs-pr" && prContext.targetBranch === "RPSaaSMaster";

  return targetsPublicProductionBranch || targetsPrivateProductionBranch;
}

async function processTypeSpec(ctx: PRContext, labelContext: LabelContext): Promise<boolean> {
  console.log("ENTER definition processTypeSpec");
  const typeSpecLabel = new Label("TypeSpec", labelContext.present);
  // By default this label should not be present. We may determine later in this function that it should be present after all.
  typeSpecLabel.shouldBePresent = false;
  const handlers: ChangeHandler[] = [];
  const typeSpecFileHandler = () => {
    return (_: PRChange) => {
      // Note: this code will be executed if the PR has a diff on a TypeSpec file,
      // as defined in public/swagger-validation-common/src/context.ts/defaultFilePatterns/typespec
      typeSpecLabel.shouldBePresent = true;
    };
  };
  const swaggerFileHandler = () => {
    return (prChange: PRChange) => {
      if (prChange.changeType !== "Deletion" && isSwaggerGeneratedByTypeSpec(prChange.filePath)) {
        typeSpecLabel.shouldBePresent = true;
      }
    };
  };
  handlers.push({
    TypeSpecFile: typeSpecFileHandler(),
    SwaggerFile: swaggerFileHandler(),
  });
  await processPrChanges(ctx, handlers);
  typeSpecLabel.applyStateChange(labelContext.toAdd, labelContext.toRemove);
  console.log("RETURN definition processTypeSpec");

  return typeSpecLabel.shouldBePresent;
}

function isSwaggerGeneratedByTypeSpec(swaggerFilePath: string): boolean {
  try {
    return !!JSON.parse(fs.readFileSync(swaggerFilePath).toString())?.info["x-typespec-generated"];
  } catch {
    return false;
  }
}

export async function processPrChanges(ctx: PRContext, Handlers: ChangeHandler[]) {
  console.log("ENTER definition processPrChanges");
  const prChanges = await getPRChanges(ctx);
  prChanges.forEach((prChange) => {
    Handlers.forEach((handler) => {
      if (prChange.fileType in handler) {
        handler?.[prChange.fileType]?.(prChange);
      }
    });
  });
  console.log("RETURN definition processPrChanges");
}

export async function processPRChangesAsync(ctx: PRContext, Handlers: ChangeHandler[]) {
  console.log("ENTER definition processPRChangesAsync");
  const prChanges = await getPRChanges(ctx);

  for (const prChange of prChanges) {
    for (const handler of Handlers) {
      if (prChange.fileType in handler) {
        await handler?.[prChange.fileType]?.(prChange);
      }
    }
  }

  console.log("RETURN definition processPRChangesAsync");
}

export async function getPRChanges(ctx: PRContext): Promise<PRChange[]> {
  console.log("ENTER definition getPRChanges");
  const results: PRChange[] = [];

  function newChange(
    fileType: FileTypes,
    changeType: ChangeTypes,
    filePath?: string,
    additionalInfo?: any,
  ) {
    if (filePath) {
      results.push({
        filePath,
        fileType,
        changeType,
        additionalInfo,
      });
    }
  }

  function newChanges(fileType: FileTypes, changeType: ChangeTypes, files?: string[]) {
    if (files) {
      files.forEach((filePath) => newChange(fileType, changeType, filePath));
    }
  }

  function genChanges(type: FileTypes, diffs: DiffResult<string>) {
    newChanges(type, "Addition", diffs.additions);
    newChanges(type, "Deletion", diffs.deletions);
    newChanges(type, "Update", diffs.changes);
  }

  function genReadmeChanges(readmeDiffs?: DiffResult<ReadmeTag>) {
    if (readmeDiffs) {
      readmeDiffs.additions?.forEach((d) => newChange("ReadmeFile", "Addition", d.readme, d.tags));
      readmeDiffs.changes?.forEach((d) => newChange("ReadmeFile", "Update", d.readme, d.tags));
      readmeDiffs.deletions?.forEach((d) => newChange("ReadmeFile", "Deletion", d.readme, d.tags));
    }
  }

  genChanges("SwaggerFile", ctx.getSwaggerDiffs());
  genChanges("TypeSpecFile", ctx.getTypeSpecDiffs());
  genChanges("ExampleFile", ctx.getExampleDiffs());
  genReadmeChanges(await ctx.getReadmeDiffs());

  console.log("RETURN definition getPRChanges");
  return results;
}

// related pending work:
// If a PR has both data-plane and resource-manager labels, it should fail with appropriate messaging #8144
// https://github.com/Azure/azure-sdk-tools/issues/8144
async function processPRType(
  context: PRContext,
  labelContext: LabelContext,
): Promise<{ resourceManagerLabelShouldBePresent: boolean }> {
  console.log("ENTER definition processPRType");
  const types: PRType[] = await getPRType(context);

  const resourceManagerLabelShouldBePresent = processPRTypeLabel(
    "resource-manager",
    types,
    labelContext,
  );
  processPRTypeLabel("data-plane", types, labelContext);

  console.log("RETURN definition processPRType");
  return { resourceManagerLabelShouldBePresent };
}

async function getPRType(context: PRContext): Promise<PRType[]> {
  console.log("ENTER definition getPRType");
  const prChanges: PRChange[] = await getPRChanges(context);

  logPRChanges(prChanges);

  const changedFilePaths: string[] = prChanges.map((it) => it.filePath);

  const prTypes: PRType[] = [];
  if (changedFilePaths.length > 0) {
    if (isDataPlanePR(changedFilePaths)) {
      prTypes.push("data-plane");
    }
    if (isManagementPR(changedFilePaths)) {
      prTypes.push("resource-manager");
    }
  }
  console.log("RETURN definition getPRType");
  return prTypes;

  function logPRChanges(prChanges: PRChange[]) {
    console.log(`PR changes table (count: ${prChanges.length}):`);
    console.log("LEGEND: changeType | fileType | filePath");
    prChanges
      .map((it) => `${it.changeType} | ${it.fileType} | ${it.filePath}`)
      .forEach((it) => console.log(it));
    console.log("END of PR changes table");

    console.log("PR changes with additionalInfo:");
    prChanges.filter((it) => it.additionalInfo != null).forEach((it) => console.log(it));
    console.log("END of PR changes with additionalInfo");
  }
}

function processPRTypeLabel(
  labelName: PRType,
  types: PRType[],
  labelContext: LabelContext,
): boolean {
  const label = new Label(labelName, labelContext.present);
  label.shouldBePresent = types.includes(labelName);

  label.applyStateChange(labelContext.toAdd, labelContext.toRemove);
  return label.shouldBePresent;
}

async function processSuppression(context: PRContext, labelContext: LabelContext) {
  console.log("ENTER definition processSuppression");

  const suppressionReviewRequiredLabel = new Label(
    "SuppressionReviewRequired",
    labelContext.present,
  );
  // By default this label should not be present. We may determine later in this function that it should be present after all.
  suppressionReviewRequiredLabel.shouldBePresent = false;
  const handlers: ChangeHandler[] = [];

  const createReadmeFileHandler = () => {
    return (e: PRChange) => {
      if (
        (e.changeType === "Addition" && getSuppressions(e.filePath).length) ||
        (e.changeType === "Update" &&
          diffSuppression(
            path.resolve(context.targetDirectory, e.filePath),
            path.resolve(context.sourceDirectory, e.filePath),
          ).length)
      ) {
        suppressionReviewRequiredLabel.shouldBePresent = true;
      }
    };
  };
  handlers.push({
    ReadmeFile: createReadmeFileHandler(),
  });
  await processPrChanges(context, handlers);

  suppressionReviewRequiredLabel.applyStateChange(labelContext.toAdd, labelContext.toRemove);
  console.log("RETURN definition processSuppression");

  return suppressionReviewRequiredLabel.shouldBePresent;
}

function getSuppressions(readmePath: string) {
  const walkToNode = (
    walker: commonmark.NodeWalker,
    cb: (node: commonmark.Node) => boolean,
  ): commonmark.Node | undefined => {
    let event = walker.next();

    while (event) {
      const curNode = event.node;
      if (cb(curNode)) {
        return curNode;
      }
      event = walker.next();
    }
    return undefined;
  };
  const getAllCodeBlockNodes = (startNode: commonmark.Node) => {
    const walker = startNode.walker();
    const result = [];
    while (true) {
      const a = walkToNode(walker, (n) => n.type === "code_block");
      if (!a) {
        break;
      }
      result.push(a);
    }
    return result;
  };
  let suppressionResult: any[] = [];
  try {
    const readme = fs.readFileSync(readmePath).toString();
    const codeBlocks = getAllCodeBlockNodes(new commonmark.Parser().parse(readme));
    for (const block of codeBlocks) {
      if (block.literal) {
        try {
          const blockObject = yaml.load(block.literal) as any;
          const directives = blockObject?.["directive"];
          if (directives && Array.isArray(directives)) {
            suppressionResult = suppressionResult.concat(directives.filter((s) => s.suppress));
          }
          const suppressions = blockObject?.["suppressions"];
          if (suppressions && Array.isArray(suppressions)) {
            suppressionResult = suppressionResult.concat(suppressions);
          }
        } catch (e) {}
      }
    }
  } catch (e) {}
  return suppressionResult;
}

export function diffSuppression(readmeBefore: string, readmeAfter: string) {
  const beforeSuppressions = getSuppressions(readmeBefore);
  const afterSuppressions = getSuppressions(readmeAfter);
  const newSuppressions = [];
  for (const suppression of afterSuppressions) {
    const properties = ["suppress", "from", "where", "code", "reason"];
    if (
      -1 ===
      beforeSuppressions.findIndex((s) => properties.every((p) => _.isEqual(s[p], suppression[p])))
    ) {
      newSuppressions.push(suppression);
    }
  }
  return newSuppressions;
}

async function processRPaaS(
  context: PRContext,
  labelContext: LabelContext,
): Promise<{ rpaasLabelShouldBePresent: boolean }> {
  console.log("ENTER definition processRPaaS");
  const rpaasLabel = new Label("RPaaS", labelContext.present);
  // By default this label should not be present. We may determine later in this function that it should be present after all.
  rpaasLabel.shouldBePresent = false;

  const handlers: ChangeHandler[] = [];
  const createReadmeFileHandler = () => {
    return async (e: PRChange) => {
      if (
        e.changeType !== "Deletion" &&
        (await isRPSaaS(path.join(context.sourceDirectory, e.filePath)))
      ) {
        rpaasLabel.shouldBePresent = true;
      }
    };
  };
  handlers.push({
    ReadmeFile: createReadmeFileHandler(),
  });
  await processPRChangesAsync(context, handlers);

  rpaasLabel.applyStateChange(labelContext.toAdd, labelContext.toRemove);
  console.log("RETURN definition processRPaaS");
  return { rpaasLabelShouldBePresent: rpaasLabel.shouldBePresent };
}

async function isRPSaaS(readmeFilePath: string) {
  const config: any = await new Readme(readmeFilePath).getGlobalConfig();
  return config["openapi-subtype"] === "rpaas" || config["openapi-subtype"] === "providerHub";
}

async function processNewRPNamespace(
  context: PRContext,
  labelContext: LabelContext,
  resourceManagerLabelShouldBePresent: boolean,
): Promise<{ newRPNamespaceLabelShouldBePresent: boolean }> {
  console.log("ENTER definition processNewRPNamespace");
  const newRPNamespaceLabel = new Label("new-rp-namespace", labelContext.present);
  // By default this label should not be present. We may determine later in this function that it should be present after all.
  newRPNamespaceLabel.shouldBePresent = false;
  const handlers: ChangeHandler[] = [];

  let skip = false;

  const targetBranch = context.targetBranch;
  if (targetBranch !== "main" && targetBranch !== "ARMCoreRPDev") {
    console.log(`Not main or ARMCoreRPDev branch, skip new RP namespace check`);
    skip = true;
  }

  if (!skip && !resourceManagerLabelShouldBePresent) {
    console.log(`Not resource-manager, skip new RP namespace check`);
    skip = true;
  }

  if (!skip) {
    const createSwaggerFileHandler = () => {
      return (e: PRChange) => {
        if (e.changeType === "Addition") {
          const rpFolder = getRPFolderFromSwaggerFile(path.dirname(e.filePath));
          console.log(`Processing newRPNameSpace rpFolder: ${rpFolder}`);
          if (rpFolder !== undefined) {
            const rpFolderFullPath = path.resolve(context.targetDirectory, rpFolder);
            if (!fs.existsSync(rpFolderFullPath)) {
              console.log(`Adding newRPNameSpace rpFolder: ${rpFolder}`);
              newRPNamespaceLabel.shouldBePresent = true;
            }
          }
        }
      };
    };

    handlers.push({ SwaggerFile: createSwaggerFileHandler() });
    await processPrChanges(context, handlers);
  }

  newRPNamespaceLabel.applyStateChange(labelContext.toAdd, labelContext.toRemove);
  console.log("RETURN definition processNewRPNamespace");
  return { newRPNamespaceLabelShouldBePresent: newRPNamespaceLabel.shouldBePresent };
}

// CODESYNC:
// - see entries for related labels in https://github.com/Azure/azure-rest-api-specs/blob/main/.github/comment.yml
// - requiredLabelsRules.ts / requiredLabelsRules
async function processNewRpNamespaceWithoutRpaasLabel(
  context: PRContext,
  labelContext: LabelContext,
  resourceManagerLabelShouldBePresent: boolean,
  newRPNamespaceLabelShouldBePresent: boolean,
  rpaasLabelShouldBePresent: boolean,
): Promise<{
  ciNewRPNamespaceWithoutRpaaSLabelShouldBePresent: boolean;
  rpaasExceptionLabelShouldBePresent: boolean;
}> {
  console.log("ENTER definition processNewRpNamespaceWithoutRpaasLabel");
  const ciNewRPNamespaceWithoutRpaaSLabel = new Label(
    "CI-NewRPNamespaceWithoutRPaaS",
    labelContext.present,
  );
  // By default this label should not be present. We may determine later in this function that it should be present after all.
  ciNewRPNamespaceWithoutRpaaSLabel.shouldBePresent = false;

  const rpaasExceptionLabel = new Label("RPaaSException", labelContext.present);

  let skip = false;

  if (!resourceManagerLabelShouldBePresent) {
    console.log(`Not resource-manager, skip checking for 'CI-NewRPNamespaceWithoutRPaaS'`);
    skip = true;
  }

  if (!skip) {
    const branch = context.targetBranch;
    if (branch === "RPSaaSDev" || branch === "RPSaaSMaster") {
      console.log(
        `PR is targeting '${branch}' branch. Skip checking for 'CI-NewRPNamespaceWithoutRPaaS'`,
      );
      skip = true;
    }
  }

  if (!skip && newRPNamespaceLabelShouldBePresent && !rpaasLabelShouldBePresent) {
    console.log(
      "Adding new RP namespace, but not RPaaS. Label 'CI-NewRPNamespaceWithoutRPaaS' should be present.",
    );
    ciNewRPNamespaceWithoutRpaaSLabel.shouldBePresent = true;
  }

  rpaasExceptionLabel.shouldBePresent =
    rpaasExceptionLabel.present && ciNewRPNamespaceWithoutRpaaSLabel.shouldBePresent;

  ciNewRPNamespaceWithoutRpaaSLabel.applyStateChange(labelContext.toAdd, labelContext.toRemove);
  rpaasExceptionLabel.applyStateChange(labelContext.toAdd, labelContext.toRemove);
  console.log("RETURN definition processNewRpNamespaceWithoutRpaasLabel");

  return {
    ciNewRPNamespaceWithoutRpaaSLabelShouldBePresent:
      ciNewRPNamespaceWithoutRpaaSLabel.shouldBePresent,
    rpaasExceptionLabelShouldBePresent: rpaasExceptionLabel.shouldBePresent as boolean,
  };
}

// CODESYNC: see entries for related labels in https://github.com/Azure/azure-rest-api-specs/blob/main/.github/comment.yml
async function processRpaasRpNotInPrivateRepoLabel(
  context: PRContext,
  labelContext: LabelContext,
  resourceManagerLabelShouldBePresent: boolean,
  rpaasLabelShouldBePresent: boolean,
): Promise<{ ciRpaasRPNotInPrivateRepoLabelShouldBePresent: boolean }> {
  console.log("ENTER definition processRpaasRpNotInPrivateRepoLabel");
  const ciRpaasRPNotInPrivateRepoLabel = new Label(
    "CI-RpaaSRPNotInPrivateRepo",
    labelContext.present,
  );
  // By default this label should not be present. We may determine later in this function that it should be present after all.
  ciRpaasRPNotInPrivateRepoLabel.shouldBePresent = false;

  let skip = false;

  if (!resourceManagerLabelShouldBePresent) {
    console.log(`Not resource-manager, skip RPaaSRPNotInPrivateRepo check`);
    skip = true;
  }

  if (!skip) {
    const targetBranch = context.targetBranch;
    if (targetBranch !== "main" || !rpaasLabelShouldBePresent) {
      console.log("Not main branch or not RPaaS PR, skip block PR when RPaaS RP not onboard");
      skip = true;
    }
  }

  // todo: retrieve the list and populate this value properly.
  // if (!skip) {
  //   // this is a request to get the list of RPaaS folders from azure-rest-api-specs-pr -> RPSaasMaster branch -> dump specification folder
  //   // names
  //   const rpaasRPFolderList = await getRPaaSFolderList();
  //   const rpFolderNames: string[] = rpaasRPFolderList.map((f) => f.name);

  //   console.log(`RPaaS RP folder list: ${rpFolderNames}`);

  //   const handlers: ChangeHandler[] = [];

  //   const processPrChange = () => {
  //     return (e: PRChange) => {
  //       if (e.changeType === "Addition") {
  //         const rpFolderName = getRPRootFolderName(e.filePath);
  //         console.log(
  //           `Processing processRpaasRpNotInPrivateRepoLabel rpFolderName: ${rpFolderName}`
  //         );

  //         if (rpFolderName === undefined) {
  //           console.log(`RP folder is undefined for changed file path '${e.filePath}'.`);
  //           return;
  //         }

  //         if (!rpFolderNames.includes(rpFolderName)) {
  //           console.log(
  //             `This RP is RPSaaS RP but could not find rpFolderName: ${rpFolderName} in RPFolderNames: ${rpFolderNames}. `
  //             + `Label 'CI-RpaaSRPNotInPrivateRepo' should be present.`
  //           );
  //           ciRpaasRPNotInPrivateRepoLabel.shouldBePresent = true;
  //         }
  //       }
  //     };
  //   };

  //   handlers.push({ SwaggerFile: processPrChange() });
  //   await processPrChanges(context, handlers);
  // }

  ciRpaasRPNotInPrivateRepoLabel.applyStateChange(labelContext.toAdd, labelContext.toRemove);
  console.log("RETURN definition processRpaasRpNotInPrivateRepoLabel");

  return {
    ciRpaasRPNotInPrivateRepoLabelShouldBePresent: ciRpaasRPNotInPrivateRepoLabel.shouldBePresent,
  };
}
