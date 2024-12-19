import _ from "lodash";
import { writeFileSync } from "fs";
import { sdkLabels, SdkName } from "./sdk.js";
import {
  SdkSuppressionsYml,
  SdkSuppressionsSection,
  sdkSuppressionsFileName,
  SdkPackageSuppressionsEntry,
  validateSdkSuppressionsFile,
} from "./sdkSuppressions.js";
import { parseYamlContent, runGitCommand } from "./common.js";

// export type PullRequestContext = {
//   labels: string[];
//   number: number;
//   html_url: string;
// };

/**
 *
 * @param pr
 * @returns SdkName list
 * This part compares the suppression files of the head branch and the base branch.
 * To get the SDK, we need to identify which package name, SDK name, or breaking changes are different and apply the SDK suppression label accordingly in the next step.
 * change details can see at getSdkNamesWithChangedSuppressions function
 * on the other hand that the sdkName list will return an empty array if it does not have a suppression file or if the file is blank.
 */
export async function getSdkSuppressionsSdkNames(
  prChangeFiles: string,
  baseCommitHash: string,
  headCommitHash: string
): Promise<SdkName[]> {
  console.log(`Will compare base commit: ${baseCommitHash} and head commit: ${headCommitHash} to get different SDK.`);
  const filesChangedPaths = prChangeFiles.split(" ");
  let suppressionFileList = filterSuppressionList(filesChangedPaths);
  let sdkNameList: SdkName[] = [];
  if (suppressionFileList.length > 0) {
    for (const suppressionFile of suppressionFileList) {
      let baseSuppressionContent = await getSdkSuppressionsFileContent(baseCommitHash, suppressionFile);
      const headSuppressionContent = await getSdkSuppressionsFileContent(headCommitHash, suppressionFile);

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
        `updateSdkSuppressionsLabels: Will compare base suppressions content: ${JSON.stringify(
          baseSuppressionContent,
        )} and head suppressions content: ${JSON.stringify(headSuppressionContent)} to get different SDK.`,
      );

      sdkNameList = getSdkNamesWithChangedSuppressions(
        headSuppressionContent as SdkSuppressionsYml,
        baseSuppressionContent as SdkSuppressionsYml,
      );
    }
  }

  return [...new Set(sdkNameList)];
}

async function getSdkSuppressionsFileContent(
  ref: string,
  path: string,
): Promise<string | object | undefined | null> {
  try {
    const suppressionFileContent = await runGitCommand(`git show ${ref}:${path}`);
    console.log(`Found content in ${ref}#${path}`);
    return parseYamlContent(suppressionFileContent, path).result;
  } catch (error) {
    console.log(`Not found content in ${ref}#${path}`);
    return null;
  }
}

function getSdksWithSuppressionsDefined(suppressions: SdkSuppressionsSection): SdkName[] {
  return _.keys(suppressions) as SdkName[];
}

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
 * @param pr
 * This code segment is responsible for managing the sdk suppression label (e.g. BreakingChange-Go-Sdk-Suppression) for PRs.
 * 1. It applies the label automatically when a PR includes a new suppression file.
 * 2. It removes the label if the PR no longer contains the suppression file.
 * 3. It leaves the label unchanged if the PR already has both the suppression and the suppression approved labels.
 */
export async function updateSdkSuppressionsLabels(
  prLabels: string[],
  prChangeFiles: string,
  outputFile: string,
  baseCommitHash: string,
  headCommitHash: string,
): Promise<{ labelsToAdd: String[]; labelsToRemove: String[] }> {
  try {
    const status = await runGitCommand("git status");
    console.log("Git status:", status);
  } catch (err) {
    console.error("Error running git command:", err);
  }

  const sdkNames = await getSdkSuppressionsSdkNames(prChangeFiles, baseCommitHash, headCommitHash);
  console.log("Changed SdkNames", sdkNames);

  console.log(
    `updateSdkSuppressionsLabels: Get the required suppressions label based on compared SDK List ${sdkNames.join(", ")}`,
  );
  let addSdkSuppressionsLabels: string[] = [];
  let removeSdkSuppressionsLabels: string[] = [];
  console.log(`updateSdkSuppressionsLabels: Present labels: ${prLabels.join(", ")}`);
  const presentLabels = [...prLabels];
  // The sdkNames indicates whether any suppression files have been modified. If it is empty
  // then check if the suppression label was previously applied and remove it if so. Otherwise, no action is needed.
  if (sdkNames.length === 0) {
    const sdkSuppressionsLabels = Object.values(sdkLabels)
      .map((sdkName) => sdkName.breakingChangeSuppression)
      .filter((breakingChangeSuppressionLabel) => breakingChangeSuppressionLabel !== undefined);
    for (let prLabel of presentLabels) {
      if (sdkSuppressionsLabels.includes(prLabel)) {
        const sdkSuppressionsApprovedLabel =
          Object.values(sdkLabels).find((sdkName) => sdkName.breakingChangeSuppression === prLabel)
            ?.breakingChangeSuppressionApproved || "";
        if (!presentLabels.includes(sdkSuppressionsApprovedLabel)) {
          console.log(
            `updateSdkSuppressionsLabels: To remove the existed suppression label if there are no difference between head commit and base commit for the suppression content.`,
          );
          removeSdkSuppressionsLabels.push(prLabel);
        }
      }
    }
    if (removeSdkSuppressionsLabels.length > 0) {
      console.log(
        `updateSdkSuppressionsLabels: Remove label: ${removeSdkSuppressionsLabels.join(", ")}`,
      );
    } else {
      console.log(`updateSdkSuppressionsLabels: No Remove label`);
    }
  } else {
    // The presence of sdkNames indicates that the suppression file has changed between the head and base branch. The suppression label should be added if it is missing.

    for (let sdkName of sdkNames) {
      const sdkSuppressionsLabel = sdkLabels[sdkName].breakingChangeSuppression || "";
      if (!presentLabels.includes(sdkSuppressionsLabel)) {
        addSdkSuppressionsLabels.push(sdkSuppressionsLabel);
      }
    }
    if (addSdkSuppressionsLabels.length > 0) {
      console.log(
        `updateSdkSuppressionsLabels: add label: ${addSdkSuppressionsLabels.join(", ")}`,
      );
    } else {
      console.log(`updateSdkSuppressionsLabels: no add label`);
    }
  }

  const result = {
    labelsToAdd: addSdkSuppressionsLabels,
    labelsToRemove: removeSdkSuppressionsLabels,
  };
  writeFileSync(outputFile, JSON.stringify(result));
  console.log("JSON output saved to output.json");

  return result;
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
