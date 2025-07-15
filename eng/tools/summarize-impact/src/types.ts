import { dirname, join, resolve } from "path";

export type FileTypes = "SwaggerFile" | "TypeSpecFile" | "ExampleFile" | "ReadmeFile";
export type ChangeTypes = "Addition" | "Deletion" | "Update";

export type PRChange = {
  fileType: FileTypes;
  changeType: ChangeTypes;
  filePath: string;
  additionalInfo?: any;
};
export type ChangeHandler = {
  [key in FileTypes]?: (event: PRChange) => void;
};

type Pattern = {
  includes: string[] | string;
  excludes?: string[] | string;
};

export type DiffResult<T> = {
  additions?: T[]
  deletions?: T[]
  changes?: T[]
}

// do I need to add minimatch as a dependency? What does it do?
export const isPathMatch = (
  path: string,
  pattern: string[] | string
): boolean => {
  if (typeof pattern === "string") {
    return minimatch(path, pattern, minimatchConfig);
  } else {
    return pattern.some((it) => minimatch(path, it, minimatchConfig));
  }
};

const isPatternMatch = (path: string, pattern: Pattern): boolean => {
  if (pattern.excludes) {
    if (isPathMatch(path, pattern.excludes)) {
      return false;
    }
  }
  return isPathMatch(path, pattern.includes);
};

export const enumerateFiles = async (path: string, pattern: Pattern) => {
  let results: any[] = [];
  if (await exists(path)) {
    const runEnumerateFiles = (
      include: string,
      excludes: string[] | string | undefined
    ) => {
      const absolutelyPath = join(path, include);
      let ignores: string[] = [];
      if (excludes) {
        ignores = ignores.concat(excludes);
      }
      const files = glob.sync(absolutelyPath, {
        ignore: ignores,
      });
      return files;
    };

    if (Array.isArray(pattern.includes)) {
      for (const pat of pattern.includes) {
        results = results.concat(runEnumerateFiles(pat, pattern.excludes));
      }
    } else {
      results = runEnumerateFiles(pattern.includes, pattern.excludes);
    }
  }
  return results;
};

const exists = async (path: string) => {
  return existsSync(path);
};

const defaultFilePatterns = {
  example: {
    includes: "**/examples/**/*.json",
    excludes: ["**/quickstart-templates/*.json", "**/schema/*.json", "**/scenarios/**/*.json","**/cadl/*.json"],
  } as Pattern,

  swagger: {
    includes: "**/*.json",
    excludes: [
      "**/quickstart-templates/*.json",
      "**/schema/*.json",
      "**/scenarios/**/*.json",
      "**/examples/**/*.json",
      "**/package.json",
      "**/package-lock.json",
      "**/cadl/**/*.json"
    ],
  } as Pattern,

  cadl: {
    includes: "**/*.cadl",
  } as Pattern,

  typespec: {
    includes: [
      "**/*.tsp",
      // We do not include tspconfig.yml because by design it is invalid. The PR should have tspconfig.yaml instead.
      // If a PR author adds tspconfig.yml the TypeSpec validation will report issue, blocking the PR from proceeding.
      // Source code of this validation can be found at:
      // https://github.com/Azure/azure-rest-api-specs/blob/b8c74fd80b415fa1ebb6fa787d454694c39e0fd5/eng/tools/typespec-validation/src/rules/folder-structure.ts#L27C27-L27C41
      // "**/*tspconfig.yml",
      "**/*tspconfig.yaml"
    ]
  } as Pattern,

  readme: { includes: "**/readme.md" } as Pattern,
};

export type PRType = "resource-manager" | "data-plane";

/**
 * The LabelContext is used by prSummary.ts / summary() and downstream invocations.
 *
 * The "present" set represents the set of labels that are currently present on the PR
 * processed by given invocation of summary(). It is obtained via GitHub Octokit API at the beginning
 * of summary().
 *
 * The "toAdd" set is the set of labels to be added to the PR at the end of invocation of summary().
 * This is to be done by calling GitHub Octokit API to add the labels.
 *
 * The "toRemove" set is analogous to "toAdd" set, but instead it is the set of labels to be removed.
 *
 * The general pattern used in the code to populate "toAdd" or "toRemove" sets to be ready for
 * Octokit invocation is as follows:
 *
 * - the summary() function passes the context through its invocation chain.
 * - given function responsible for given label, like e.g. for label "ARMReview",
 *   creates a new instance of Label: const armReviewLabel = new Label("ARMReview", labelContext.present)
 * - the function then processes the label to determine if armReviewLabel.shouldBePresent is to be set to true or false.
 * - the function at the end of its invocation calls armReviewLabel.applyStateChanges(labelContext.toAdd, labelContext.toRemove)
 *   to update the sets.
 * - the function may optionally return { armReviewLabel.shouldBePresent } to allow the caller to pass this value
 *   further to downstream business logic that depends on it.
 * - at the end of invocation summary() calls Octokit passing it as input labelContext.toAdd and labelContext.toRemove.
 *
 * todo: this type is duplicated in JSDoc over in summarize-checks.js
 */
export type LabelContext = {
  present: Set<string>,
  toAdd: Set<string>,
  toRemove: Set<string>
}

export type ImpactAssessment = {
    prType: string[],
    suppressionsChanged: boolean,
    versioningReviewRequired: boolean,
    breakingChangeReviewRequired: boolean,
    rpaasChange: boolean,
    newRP: boolean,
    rpaasRPMissing: boolean
}
