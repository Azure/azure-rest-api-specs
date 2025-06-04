import _ from "lodash";
import debug from "debug";
import { writeFileSync } from "fs";
import { simpleGit } from "simple-git";
import { sdkLabels, SdkName } from "@azure-tools/specs-shared/sdk-types";
import {
  SdkSuppressionsYml,
  SdkSuppressionsSection,
  sdkSuppressionsFileName,
  SdkPackageSuppressionsEntry,
  validateSdkSuppressionsFile,
} from "./sdkSuppressions.js";
import { getSDKSuppressionsChangedFiles, parseYamlContent } from "./common.js";

// Enable simple-git debug logging to improve console output
debug.enable("simple-git");

/**
 *
 * @param prChangeFiles
 * @param baseCommitHash
 * @param headCommitHash
 * @returns SdkName list
 * This part compares the suppression files of the head branch and the base branch.
 * To get the SDK, we need to identify which package name, SDK name, or breaking changes are different and apply the SDK suppression label accordingly in the next step.
 * change details can see at getSdkNamesWithChangedSuppressions function
 * on the other hand that the sdkName list will return an empty array if it does not have a suppression file or if the file is blank.
 */
export async function getSdkSuppressionsSdkNames(
  prChangeFiles: string[],
  baseCommitHash: string,
  headCommitHash: string,
): Promise<SdkName[]> {
  console.log(
    `Will compare base commit: ${baseCommitHash} and head commit: ${headCommitHash} to get different SDK.`,
  );
  console.log(`The pr origin changed files: ${prChangeFiles.join(", ")}`);
  let suppressionFileList = filterSuppressionList(prChangeFiles);
  console.log(`Will compare sdk-suppression.yaml files: ${suppressionFileList.join(", ")}`);
  let sdkNameList: SdkName[] = [];
  if (suppressionFileList.length > 0) {
    for (const suppressionFile of suppressionFileList) {
      let baseSuppressionContent = await getSdkSuppressionsFileContent(
        baseCommitHash,
        suppressionFile,
      );
      const headSuppressionContent = await getSdkSuppressionsFileContent(
        headCommitHash,
        suppressionFile,
      );

      // if the head suppression file is present but anything is wrong like schema error with it return
      const validateSdkSuppressionsFileResult =
        validateSdkSuppressionsFile(headSuppressionContent).result;
      if (!validateSdkSuppressionsFileResult) {
        return [];
      }
      // if base suppression file does not exist, set it to an empty object but has correct schema
      if (!baseSuppressionContent) {
        baseSuppressionContent = { suppressions: {} };
      }

      console.log(
        `updateSdkSuppressionsLabels: Will compare base suppressions content:\n ` +
          `${JSON.stringify(baseSuppressionContent)}\n ` +
          `and head suppressions content:\n ` +
          `${JSON.stringify(headSuppressionContent)} to get different SDK.`,
      );

      sdkNameList = getSdkNamesWithChangedSuppressions(
        headSuppressionContent as SdkSuppressionsYml,
        baseSuppressionContent as SdkSuppressionsYml,
      );
    }
  }

  return [...new Set(sdkNameList)];
}

export async function getSdkSuppressionsFileContent(
  ref: string,
  path: string,
): Promise<string | object | undefined | null> {
  try {
    const suppressionFileContent = await simpleGit().show([`${ref}:${path}`]);
    console.log(`Found content in ${ref}#${path}`);
    return parseYamlContent(suppressionFileContent, path).result;
  } catch (error) {
    console.log(`Not found content in ${ref}#${path}, Error: ${error}`);
    return null;
  }
}

function getSdksWithSuppressionsDefined(suppressions: SdkSuppressionsSection): SdkName[] {
  return _.keys(suppressions) as SdkName[];
}

/**
 *
 * @param headSuppressionFile
 * @param baseSuppressionFile
 * @returns SdkName[]
 *
 * Analyze the suppression files across three dimensions: language, package, and breaking-change. Finally, determine the outermost sdkName.
 */

export function getSdkNamesWithChangedSuppressions(
  headSuppressionFile: SdkSuppressionsYml,
  baseSuppressionFile: SdkSuppressionsYml,
): SdkName[] {
  let sdkNamesWithChangedSuppressions: SdkName[] = [];

  const headSdkSuppressionsSection: SdkSuppressionsSection = headSuppressionFile.suppressions;
  const baseSdkSuppressionsSection: SdkSuppressionsSection = baseSuppressionFile.suppressions;

  const headSdksWithSuppressions: SdkName[] = getSdksWithSuppressionsDefined(
    headSdkSuppressionsSection,
  );
  const baseSdksWithSuppressions: SdkName[] = getSdksWithSuppressionsDefined(
    baseSdkSuppressionsSection,
  );

  if (headSdksWithSuppressions.length === 0) {
    if (baseSdksWithSuppressions.length > 0) {
      sdkNamesWithChangedSuppressions = [
        ...sdkNamesWithChangedSuppressions,
        ...baseSdksWithSuppressions,
      ];
    }
  }

  // 1. If modify Sdk in SdkSuppressionsSection, add SdkName to sdkNamesWithChangedSuppressions
  const differentSdkNamesWithChangedSuppressions = _.xorWith(
    headSdksWithSuppressions,
    baseSdksWithSuppressions,
    _.isEqual,
  );
  if (differentSdkNamesWithChangedSuppressions.length > 0) {
    sdkNamesWithChangedSuppressions = [
      ...sdkNamesWithChangedSuppressions,
      ...differentSdkNamesWithChangedSuppressions,
    ];
  }

  // 2. If modify SdkPackageSuppressionsEntry in SdkSuppressionsSection include package name and breaking changes
  //    add SdkName to sdkNamesWithChangedSuppressions
  const similarSdkNamesWithChangedSuppressions = _.intersectionWith(
    headSdksWithSuppressions,
    baseSdksWithSuppressions,
  );
  similarSdkNamesWithChangedSuppressions.forEach((sdkName: SdkName) => {
    const headSdkPackageSuppressionsEntry = headSdkSuppressionsSection[
      sdkName
    ] as SdkPackageSuppressionsEntry[];
    const baseSdkPackageSuppressionsEntry = baseSdkSuppressionsSection[
      sdkName
    ] as SdkPackageSuppressionsEntry[];
    // Determine whether packageName has changed
    const differentPackageNamesWithChangedSuppressions = _.xorWith(
      headSdkPackageSuppressionsEntry.map((entry) => entry.package),
      baseSdkPackageSuppressionsEntry.map((entry) => entry.package),
      _.isEqual,
    );
    if (differentPackageNamesWithChangedSuppressions.length > 0) {
      sdkNamesWithChangedSuppressions = [...sdkNamesWithChangedSuppressions, sdkName];
      return;
    }
    // Determine whether breaking-changes has changed
    headSdkPackageSuppressionsEntry.forEach((headEntry) => {
      const baseEntry = baseSdkPackageSuppressionsEntry.find(
        (entry) => entry.package === headEntry.package,
      );
      if (!baseEntry) {
        sdkNamesWithChangedSuppressions = [...sdkNamesWithChangedSuppressions, sdkName];
        return;
      }
      if (!_.isEqual(headEntry["breaking-changes"].sort(), baseEntry["breaking-changes"].sort())) {
        sdkNamesWithChangedSuppressions = [...sdkNamesWithChangedSuppressions, sdkName];
        return;
      }
    });
  });

  return [...new Set(sdkNamesWithChangedSuppressions)];
}

/**
 *
 * @param baseCommitHash
 * @param headCommitHash
 * @param prLabels
 * @param outputFile
 * @returns { labelsToAdd: String[]; labelsToRemove: String[] }
 * This code performs two key functions:
 * First, it retrieves the corresponding SDKNames based on the differences between the two sdk-suppression files.
 * Second, it compares the SDKNames obtained in the previous step with the existing PR labels and processes the PR labels accordingly.
 */
export async function updateSdkSuppressionsLabels(
  baseCommitHash: string,
  headCommitHash: string,
  prLabels: string,
  outputFile?: string,
): Promise<{ labelsToAdd: String[]; labelsToRemove: String[] }> {
  try {
    const result = await simpleGit().raw("status");
    console.log("Git status:", result);
  } catch (err) {
    console.error("Error running git command:", err);
  }

  const prChangeFiles = await getSDKSuppressionsChangedFiles();

  const sdkNames = await getSdkSuppressionsSdkNames(prChangeFiles, baseCommitHash, headCommitHash);

  console.log(
    `updateSdkSuppressionsLabels: Get the required suppressions label based on compared SDK List ${sdkNames.join(", ")}`,
  );

  const presentLabels = JSON.parse(prLabels) as string[];
  console.log(`updateSdkSuppressionsLabels: Present labels: ${presentLabels.join(", ")}`);

  const result = processLabels(presentLabels, sdkNames);

  if (outputFile) {
    writeFileSync(outputFile, JSON.stringify(result));
    console.log(`😊 JSON output saved to ${outputFile}`);
  }

  return result;
}

/**
 *
 * @param presentLabels
 * @param sdkNames
 * @returns {labelsToAdd: String[], labelsToRemove: String[]}
 *
 * Based on the various sdknames and existing labels, process the suppression label of PR.
 *
 * Add logic:    If the breakingChangeSuppression label corresponding to an SDK in sdkNames is not in the current presentLabels list,
 *               add the label to labelsToAdd.
 * Remove logic: If a label is in presentLabels and the corresponding breakingChangeSuppression is not in sdkNames
 *               and there is no corresponding breakingChangeSuppressionApproved label, then the label is deleted.
 *               Otherwise, the label is not deleted.
 */
export function processLabels(
  presentLabels: string[],
  sdkNames: string[],
): { labelsToAdd: String[]; labelsToRemove: String[] } {
  // The sdkNames indicates whether any suppression files have been modified. If it is empty
  // then check if the suppression label was previously applied and remove it if so. Otherwise, no action is needed.
  let addSdkSuppressionsLabels: string[] = [];
  let removeSdkSuppressionsLabels: string[] = [];
  sdkNames.forEach((sdkName) => {
    const sdk = sdkLabels[sdkName as SdkName];
    const breakingChangeSuppression = sdk.breakingChangeSuppression;
    // If breakingChangeSuppression is not in the existing labels, add it to labelsToAdd
    if (breakingChangeSuppression && !presentLabels.includes(breakingChangeSuppression)) {
      addSdkSuppressionsLabels.push(breakingChangeSuppression);
    }
  });

  presentLabels.forEach((label) => {
    // Check if it is a suppression label
    const suppressionLabelExists = Object.values(sdkLabels).some((sdk) => {
      return sdk.breakingChangeSuppression === label;
    });

    // If it is a suppression label
    if (suppressionLabelExists) {
      // Check if there is a corresponding approved label
      const hasApprovedLabel = Object.values(sdkLabels).some((sdk) => {
        return (
          sdk.breakingChangeSuppression === label &&
          sdk.breakingChangeSuppressionApproved &&
          presentLabels.includes(sdk.breakingChangeSuppressionApproved)
        );
      });
      // If there is no corresponding approved label and there is no suppression label in sdkNames, delete it.
      if (
        !hasApprovedLabel &&
        !sdkNames.some(
          (sdkName) => sdkLabels[sdkName as SdkName].breakingChangeSuppression === label,
        )
      ) {
        removeSdkSuppressionsLabels.push(label);
      }
    }
  });

  return {
    labelsToAdd: addSdkSuppressionsLabels,
    labelsToRemove: removeSdkSuppressionsLabels,
  };
}

/**
 *
 * @param filesChangedPaths
 * @returns string[]
 * check suppressionFileList is swagger suppression or tsp suppression
 * if the change includes both swagger suppression and tsp suppression, only handle the tsp suppression
 * others keep swagger suppression
 *
 * filter data-plane for swagger suppression and tsp suppression for each service
 */
export function filterSuppressionList(filesChangedPaths: string[]): string[] {
  let initialSuppressionFiles = filesChangedPaths.filter((suppressionFile) =>
    suppressionFile.split("/").includes(sdkSuppressionsFileName),
  );
  let tspSuppressionFileList = initialSuppressionFiles.filter((suppressionFile) =>
    suppressionFile.split("/").some((suppressionFile) => suppressionFile.endsWith(".Management")),
  );
  let swaggerSuppressionFileList = initialSuppressionFiles.filter((suppressionFile) =>
    suppressionFile.split("/").includes("resource-manager"),
  );

  let filterSuppressionFileList = [...tspSuppressionFileList, ...swaggerSuppressionFileList];

  const groupedSuppressionFileList = filterSuppressionFileList.reduce(
    (acc: { [key: string]: string[] }, path) => {
      const key = path.split("/")[1];
      if (!acc[key]) {
        acc[key] = [];
      }
      acc[key].push(path);

      return acc;
    },
    {},
  );

  let suppressionFileList: string[] = [];
  for (const serviceName in groupedSuppressionFileList) {
    if (groupedSuppressionFileList.hasOwnProperty(serviceName)) {
      let serviceSuppressionList = groupedSuppressionFileList[serviceName];
      if (
        serviceSuppressionList.some((suppressionFile) =>
          suppressionFile
            .split("/")
            .some((suppressionFile) => suppressionFile.endsWith(".Management")),
        )
      ) {
        suppressionFileList = suppressionFileList.concat(
          serviceSuppressionList.filter((suppressionFile) =>
            suppressionFile
              .split("/")
              .some((suppressionFile) => suppressionFile.endsWith(".Management")),
          ),
        );
      } else {
        suppressionFileList = suppressionFileList.concat(serviceSuppressionList);
      }
    }
  }

  return suppressionFileList;
}
