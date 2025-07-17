// import { join } from "path";


// import { Readme } from "@azure-tools/specs-shared/readme";
import { SpecModel } from "@azure-tools/specs-shared/spec-model";
import { swagger, typespec, example } from "@azure-tools/specs-shared/changed-files"; //readme,

export type FileTypes = "SwaggerFile" | "TypeSpecFile" | "ExampleFile" | "ReadmeFile";
export type ChangeTypes = "Addition" | "Deletion" | "Update";

export type PRChange = {
  fileType: FileTypes;
  changeType: ChangeTypes;
  filePath: string;
  additionalInfo?: any;
};

export type ReadmeTag = {
  readme: string;
  tags: DiffResult<string>;
};

export type ChangeHandler = {
  [key in FileTypes]?: (event: PRChange) => void | Promise<void>;
};

// type Pattern = {
//   includes: string[] | string;
//   excludes?: string[] | string;
// };

export type DiffResult<T> = {
  additions?: T[]
  deletions?: T[]
  changes?: T[]
}

// do I need to add minimatch as a dependency? What does it do?
// export const isPathMatch = (
//   path: string,
//   pattern: string[] | string
// ): boolean => {
//   if (typeof pattern === "string") {
//     return minimatch(path, pattern, minimatchConfig);
//   } else {
//     return pattern.some((it) => minimatch(path, it, minimatchConfig));
//   }
// };

// const isPatternMatch = (path: string, pattern: Pattern): boolean => {
//   if (pattern.excludes) {
//     if (isPathMatch(path, pattern.excludes)) {
//       return false;
//     }
//   }
//   return isPathMatch(path, pattern.includes);
// };

// export const enumerateFiles = async (path: string, pattern: Pattern) => {
//   let results: any[] = [];
//   if (await exists(path)) {
//     const runEnumerateFiles = (
//       include: string,
//       excludes: string[] | string | undefined
//     ) => {
//       const absolutelyPath = join(path, include);
//       let ignores: string[] = [];
//       if (excludes) {
//         ignores = ignores.concat(excludes);
//       }
//       const files = glob.sync(absolutelyPath, {
//         ignore: ignores,
//       });
//       return files;
//     };

//     if (Array.isArray(pattern.includes)) {
//       for (const pat of pattern.includes) {
//         results = results.concat(runEnumerateFiles(pat, pattern.excludes));
//       }
//     } else {
//       results = runEnumerateFiles(pattern.includes, pattern.excludes);
//     }
//   }
//   return results;
// };

// const exists = async (path: string) => {
//   return fs.existsSync(path);
// };

// const defaultFilePatterns = {
//   example: {
//     includes: "**/examples/**/*.json",
//     excludes: ["**/quickstart-templates/*.json", "**/schema/*.json", "**/scenarios/**/*.json","**/cadl/*.json"],
//   } as Pattern,

//   swagger: {
//     includes: "**/*.json",
//     excludes: [
//       "**/quickstart-templates/*.json",
//       "**/schema/*.json",
//       "**/scenarios/**/*.json",
//       "**/examples/**/*.json",
//       "**/package.json",
//       "**/package-lock.json",
//       "**/cadl/**/*.json"
//     ],
//   } as Pattern,

//   cadl: {
//     includes: "**/*.cadl",
//   } as Pattern,

//   typespec: {
//     includes: [
//       "**/*.tsp",
//       // We do not include tspconfig.yml because by design it is invalid. The PR should have tspconfig.yaml instead.
//       // If a PR author adds tspconfig.yml the TypeSpec validation will report issue, blocking the PR from proceeding.
//       // Source code of this validation can be found at:
//       // https://github.com/Azure/azure-rest-api-specs/blob/b8c74fd80b415fa1ebb6fa787d454694c39e0fd5/eng/tools/typespec-validation/src/rules/folder-structure.ts#L27C27-L27C41
//       // "**/*tspconfig.yml",
//       "**/*tspconfig.yaml"
//     ]
//   } as Pattern,

//   readme: { includes: "**/readme.md" } as Pattern,
// };

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
    resourceManagerRequired: boolean,
    suppressionReviewRequired: boolean,
    versioningReviewRequired: boolean,
    breakingChangeReviewRequired: boolean,
    isNewApiVersion: boolean,
    rpaasExceptionRequired: boolean,
    rpaasRpNotInPrivateRepo: boolean,
    rpaasChange: boolean,
    newRP: boolean,
    rpaasRPMissing: boolean,
    typeSpecChanged: boolean,
    isDraft: boolean
}

export class Label {
  name: string;

  /** Is the label currently present on the pull request?
   *
   * This is determined at the time of construction of this object.
   */
  present?: boolean;

  /** Should this label be present on the pull request?
   *
   * Must be defined before applyStateChange is called.
   *
   * Not set at the construction time to facilitate determining desired presence
   * of multiple labels in single code block, without intermixing it with
   * label construction logic.
   */
  shouldBePresent: boolean | undefined = undefined;

  constructor(name: string, presentLabels?: Set<string>) {
    this.name = name;
    this.present = presentLabels?.has(this.name) ?? undefined;
  }

  /**
   * If the label should be added, add its name to labelsToAdd.
   * If the label should be removed, add its name to labelsToRemove.
   * Otherwise, do nothing.
   *
   * Precondition: this.shouldBePresent has been defined.
   */
  applyStateChange(
    labelsToAdd: Set<string>,
    labelsToRemove: Set<string>
  ): void {
    if (this.shouldBePresent === undefined) {
      console.warn(
        "ASSERTION VIOLATION! " +
          `Cannot applyStateChange for label '${this.name}' ` +
          "as its desired presence hasn't been defined. Returning early."
      );
      return;
    }

    if (!this.present && this.shouldBePresent) {
      if (!labelsToAdd.has(this.name)) {
        console.log(`Label.applyStateChange: '${this.name}' was not present and should be present. Scheduling addition.`);
        labelsToAdd.add(this.name);
      } else {
        console.log(`Label.applyStateChange: '${this.name}' was not present and should be present. It is already scheduled for addition.`);
      }
    } else if (this.present && !this.shouldBePresent) {
      if (!labelsToRemove.has(this.name)) {
        console.log(`Label.applyStateChange: '${this.name}' was present and should not be present. Scheduling removal.`);
        labelsToRemove.add(this.name);
      } else {
        console.log(`Label.applyStateChange: '${this.name}' was present and should not be present. It is already scheduled for removal.`);
      }
    } else if (this.present === this.shouldBePresent) {
      console.log(`Label.applyStateChange: '${this.name}' is ${this.present ? "present" : "not present"}. This is the desired state.`);
    } else {
      console.warn(
        "ASSERTION VIOLATION! " +
          `Label.applyStateChange: '${this.name}' is ${this.present ? "present" : "not present"} while it should be ${this.shouldBePresent ? "present" : "not present"}. `
          + `At this point of execution this should not happen.`
      );
    }
  }

  isEqualToOrPrefixOf(label: string): boolean {
    return this.name.endsWith("*")
      ? label.startsWith(this.name.slice(0, -1))
      : this.name === label;
  }

  logString(): string {
    return (
      `Label: name: ${this.name}, ` +
      `present: ${this.present}, ` +
      `shouldBePresent: ${this.shouldBePresent}. `
    );
  }
}

export type FileListInfo = {
  additions: string[];
  modifications: string[];
  deletions: string[];
  renames: { from: string; to: string }[];
  total: number;
};

export type PRContextOptions = {
  fileList?: FileListInfo;
  sourceBranch: string;
  targetBranch: string;
  sha: string;
  repo: string;
  owner: string;
  prNumber: string;
  isDraft: boolean;
};

export class PRContext {
  // we are starting with checking out before and after to different directories
  // sourceDirectory corresponds to "after". EG the PR context is the "after" state of the PR.
  // The "before" state is the git root directory without the changes aka targetDirectory
  sourceDirectory: string;
  targetDirectory: string;
  sourceSpecModel?: SpecModel;
  targetSpecModel?: SpecModel;
  fileList?: FileListInfo;
  sourceBranch: string;
  targetBranch: string;
  sha: string;
  repo: string;
  owner: string;
  prNumber: string;
  isDraft: boolean;
  labelContext: LabelContext;

  constructor(
    sourceDirectory: string,
    targetDirectory: string,
    labelContext: LabelContext,
    options: PRContextOptions
  ) {
    this.sourceDirectory = sourceDirectory;
    this.targetDirectory = targetDirectory;
    this.sourceSpecModel = new SpecModel(sourceDirectory);
    this.targetSpecModel = new SpecModel(targetDirectory);
    this.labelContext = labelContext;
    this.sourceBranch = options.sourceBranch;
    this.targetBranch = options.targetBranch;
    this.sha = options.sha;
    this.repo = options.repo;
    this.prNumber = options.prNumber;
    this.fileList = options.fileList;
    this.isDraft = options.isDraft;
    this.owner = options.owner;
  }


  // todo get rid of async here not necessary
  // todo store the results
  async getTypeSpecDiffs(): Promise<DiffResult<string>> {
    if (!this.fileList) {
      return Promise.resolve({
        additions: [],
        deletions: [],
        changes: []
      });
    }

    const additions = this.fileList.additions.filter(file => typespec(file));
    const deletions = this.fileList.deletions.filter(file => typespec(file));
    const changes = this.fileList.modifications.filter(file => typespec(file));

    return Promise.resolve({
      additions,
      deletions,
      changes
    });
  }

  async getSwaggerDiffs(): Promise<DiffResult<string>> {
    if (!this.fileList) {
      return Promise.resolve({
        additions: [],
        deletions: [],
        changes: []
      });
    }

    const additions = this.fileList.additions.filter(file => swagger(file));
    const deletions = this.fileList.deletions.filter(file => swagger(file));
    const changes = this.fileList.modifications.filter(file => swagger(file));

    return Promise.resolve({
      additions,
      deletions,
      changes
    });
  }

  async getExampleDiffs(): Promise<DiffResult<string>> {
    if (!this.fileList) {
      return Promise.resolve({
        additions: [],
        deletions: [],
        changes: []
      });
    }

    const additions = this.fileList.additions.filter(file => example(file));
    const deletions = this.fileList.deletions.filter(file => example(file));
    const changes = this.fileList.modifications.filter(file => example(file));

    return Promise.resolve({
      additions,
      deletions,
      changes
    });
  }

  async getReadmeDiffs(): Promise<DiffResult<ReadmeTag>> {
    // get all the readme files
    // generate the diffresult from it.
    // Readme

    // console.log(`ahahahah readme tags are ${rmtags}`)


    // console.log("ENTER definition LocalDirContext.getReadmeDiffs")
    // if (this.readmeDiffs) {
    //   console.log("RETURN definition LocalDirContext.getReadmeDiffs - early return")
    //   return this.readmeDiffs;
    // }
    // const readmeDiffs = await enumerateFiles(
    //   this.context.swaggerDirs[0],
    //   this.options?.pattern?.readme || defaultFilePatterns.readme
    // );
    // const readmeTags = readmeDiffs.map((readmeDiff) => {
    //   return {
    //     readme: readmeDiff as string,
    //     tags: toDiffResult(getAllTags(readFileSync(readmeDiff as string).toString())),
    //   } as ReadmeTag;
    // });
    // this.readmeDiffs = { additions: readmeTags };
    // console.log("RETURN definition LocalDirContext.getReadmeDiffs")
    // return this.readmeDiffs;
    return Promise.resolve({
      additions: [],
      deletions: [],
      changes: []
    });
  }

}
