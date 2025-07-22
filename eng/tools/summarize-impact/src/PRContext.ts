import { join, dirname } from "path";
import * as fs from "fs";

import { parseMarkdown } from "@azure-tools/openapi-tools-common";
import * as amd from "@azure/openapi-markdown";

import { SpecModel } from "@azure-tools/specs-shared/spec-model";
import { Readme } from "@azure-tools/specs-shared/readme";
import {
  swagger,
  typespec,
  example,
  readme,
  specification,
} from "@azure-tools/specs-shared/changed-files";

import { LabelContext } from "./labelling-types.js";
import { DiffResult, ReadmeTag, TagDiff, TagConfigDiff } from "./diff-types.js";

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

/**
 * Represents the context of a Pull Request (PR) in a repository.
 * It contains information about the source and target directories, branches, SHA, and other relevant details while
 * providing methods to abstract the differences between the source and target states.
 */
export class PRContext {
  /**
   * Path to the source directory representing the code actually being changed.
   *
   * This directory contains all the files as they exist on the PR branch and is
   * compared against `targetDirectory` to compute additions, deletions, and modifications.
   */
  sourceDirectory: string;
  /**
   * Path to the source directory representing the code before the changes in the PR.
   *
   * This directory contains all the files as they exist on the target branch and is
   * compared against `sourceDirectory` to compute additions, deletions, and modifications.
   */
  targetDirectory: string;
  /**
   * The spec model for the source directory.
   *
   * This is used to analyze the TypeSpec files in the source directory.
   */
  sourceSpecModel?: SpecModel;
  /**
   * The spec model for the target directory.
   *
   * This is used to analyze the TypeSpec files in the target directory.
   */
  targetSpecModel?: SpecModel;
  /**
   * The information generated about the PR from getChangedFileStatuses() call.
   */
  fileList?: FileListInfo;
  /**
   * The branch from which the PR is created.
   */
  sourceBranch: string;
  /**
   * The branch into which the PR is merged.
   */
  targetBranch: string;
  /**
   * The SHA of the commit that is being merged in the PR. Originates from sourceBranch.
   */
  sha: string;
  /**
   * The repository where the PR is created.
   */
  repo: string;
  /**
   * The owner of the repository where the PR is created.
   */
  owner: string;
  /**
   * The pull request number.
   */
  prNumber: string;
  /**
   * Is the PR a draft PR?
   */
  isDraft: boolean;

  /**
   * The context for labels applied to the PR. This context is passed throughout the labeling actions, and
   * is used to determine which labels should be added or removed at the end of the labeling process.
   */
  labelContext: LabelContext;

  constructor(
    sourceDirectory: string,
    targetDirectory: string,
    labelContext: LabelContext,
    options: PRContextOptions,
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

  getChangedFiles(): string[] {
    if (!this.fileList) {
      return [];
    }

    const changedFiles: string[] = (this.fileList.additions || [])
      .concat(this.fileList.modifications || [])
      .concat(this.fileList.deletions || [])
      .concat(this.fileList.renames.map((r) => r.to) || []);
    return changedFiles;
  }

  // todo store the results
  getTypeSpecDiffs(): DiffResult<string> {
    if (!this.fileList) {
      return {
        additions: [],
        deletions: [],
        changes: [],
      };
    }

    const additions = this.fileList.additions.filter((file) => typespec(file));
    const deletions = this.fileList.deletions.filter((file) => typespec(file));
    const changes = this.fileList.modifications.filter((file) => typespec(file));

    return {
      additions,
      deletions,
      changes,
    };
  }

  getSwaggerDiffs(): DiffResult<string> {
    if (!this.fileList) {
      return {
        additions: [],
        deletions: [],
        changes: [],
      };
    }

    const additions = this.fileList.additions.filter((file) => swagger(file));
    const deletions = this.fileList.deletions.filter((file) => swagger(file));
    const changes = this.fileList.modifications.filter((file) => swagger(file));

    return {
      additions,
      deletions,
      changes,
    };
  }

  getExampleDiffs(): DiffResult<string> {
    if (!this.fileList) {
      return {
        additions: [],
        deletions: [],
        changes: [],
      };
    }

    const additions = this.fileList.additions.filter((file) => example(file));
    const deletions = this.fileList.deletions.filter((file) => example(file));
    const changes = this.fileList.modifications.filter((file) => example(file));

    return {
      additions,
      deletions,
      changes,
    };
  }

  async getTagsFromReadme(readmePath: string): Promise<string[]> {
    const tags = await new Readme(readmePath).getTags();
    return [...tags.values()].map((tag) => tag.name);
  }

  async getPossibleParentConfigurations(): Promise<string[]> {
    console.log("ENTER definition getPossibleParentConfigurations");
    const changedFiles = await this.getChangedFiles();
    console.log(`Detect changes in the PR:\n${JSON.stringify(changedFiles, null, 2)}`);
    const readmes = changedFiles.filter((f) => readme(f));

    const visitedFolder = new Set<string>();
    changedFiles
      .filter((f) => [".md", ".json", ".yaml", ".yml"].some((p) => f.endsWith(p)))
      .forEach((f) => {
        let dir = dirname(f);
        if (visitedFolder.has(dir)) {
          return;
        }
        while (specification(dir)) {
          if (visitedFolder.has(dir)) {
            break;
          }
          visitedFolder.add(dir);
          const possibleReadme = join(dir, "readme.md");
          if (fs.existsSync(possibleReadme)) {
            if (!readmes.includes(possibleReadme)) {
              readmes.push(possibleReadme);
            }
            break;
          }
          dir = dirname(dir);
        }
      });
    console.log("RETURN definition getPossibleParentConfigurations");
    return readmes;
  }

  getAllTags(readMeContent: string): string[] {
    // todo: we should refactor this to use the spec model, but I haven't had the the time to explicitly
    // diff what oad does does here, so I'm leaving it alone for now until I can build some strong unit tests around this.
    const cmd = parseMarkdown(readMeContent);
    const allTags = new amd.ReadMeManipulator(
      { error: (_msg: string) => {} },
      new amd.ReadMeBuilder(),
    ).getAllTags(cmd);
    return [...allTags];
  }

  async getInputFiles(readMeContent: string, tag: string) {
    // todo: we should refactor this to use spec model, but I haven't had time to isolate exactly what
    // openapi-markdown is doing here, so I'm just going to use the same logic for now
    const cmd = parseMarkdown(readMeContent);
    return amd.getInputFilesForTag(cmd.markDown, tag);
  }

  async getChangingTags(): Promise<TagDiff[]> {
    // we are retrieving all the readme changes, no matter if they're additions, deletions, etc
    // Additionally, we're also retrieving all the readme files that may be affected by the changes in the PR, which means
    // climbing up the directory tree until we find a readme.md file if necessary.
    const allAffectedReadmes: string[] = await this.getPossibleParentConfigurations();
    console.log(`all affected readme are:`);
    console.log(JSON.stringify(allAffectedReadmes, null, 2));
    const Diffs: TagDiff[] = [];
    for (const readme of allAffectedReadmes) {
      const oldReadme = join(this.targetDirectory, readme);
      const newReadme = join(this.sourceDirectory, readme);
      // As the readme may be not existing , need to check if it's existing.
      // we are checking target and source individually, because the readme may not exist in the target branch
      const oldTags: string[] = fs.existsSync(oldReadme)
        ? [...(await new Readme(oldReadme).getTags()).keys()]
        : [];
      const newTags: string[] = fs.existsSync(newReadme)
        ? [...(await new Readme(newReadme).getTags()).keys()]
        : [];
      const intersect = oldTags
        .filter((t) => newTags.includes(t))
        .filter((tag) => tag !== "all-api-versions");
      const insertions = newTags.filter((t) => !oldTags.includes(t));
      const deletions = oldTags.filter((t) => !newTags.includes(t));
      const differences: TagConfigDiff[] = [];

      // todo: we need to ensure we get ALL effected swaggers by their relationships, not just the swagger files that are directly changed in the PR.
      // right now I'm just going to filter to the ones that are directly changed in the PR.
      // this is a temporary solution, we need to ensure we get all of the swagger files
      // that are affected by the changes in the readme. SpecModel will be useful for this
      // we want to get all of the swagger files that are affected by the changes in the readme.
      // we can do that using the specmodel
      // const allAffectedInputFiles = await this.getRealAffectedSwagger(readme)
      // talk to Mike and ask him how we could get all affected swagger files from a readme path.
      // I want to say that readme(readme).specModel.getAffectedSwaggerFiles will work?
      const allAffectedInputFiles = await (await this.getChangedFiles()).filter((f) => swagger(f));
      console.log(`all affected swagger files in ${readme} are:`);
      console.log(JSON.stringify(allAffectedInputFiles, null, 2));
      const getChangedInputFiles = async (tag: string) => {
        const readmeContent = await fs.promises.readFile(newReadme, "utf-8");
        const inputFiles = await this.getInputFiles(readmeContent, tag);
        if (inputFiles) {
          const changedInputFiles = (inputFiles as string[]).filter((f) =>
            allAffectedInputFiles.some((a) => a.endsWith(f)),
          );
          return changedInputFiles;
        }
        return [];
      };
      const changes: string[] = [];
      for (const tag of intersect) {
        const tagDiff: TagConfigDiff = { name: tag };
        const changedInputFiles = await getChangedInputFiles(tag);
        if (changedInputFiles.length) {
          console.log("found changed input files under tag:" + tag);
          tagDiff.changedInputFiles = changedInputFiles;
          changes.push(tag);
        }
      }
      Diffs.push({ readme, insertions, deletions, changes, differences });
    }
    return Diffs;
  }

  // this function is based upon LocalDirContext.getReadmeDiffs() and CommonPRContext.getReadmeDiffs() which are
  // very different from each other (because why not). This implementation is based MOSTLY on CommonPRContext
  async getReadmeDiffs(): Promise<DiffResult<ReadmeTag>> {
    const changedFiles = await this.fileList;
    const tagDiffs = (await this.getChangingTags()) || [];

    const readmeTagDiffs = tagDiffs
      ?.filter((tagDiff: TagDiff) => readme(tagDiff.readme))
      .map((tagDiff: TagDiff) => {
        return {
          readme: tagDiff.readme,
          tags: {
            changes: tagDiff.changes,
            deletions: tagDiff.deletions,
            additions: tagDiff.insertions,
          },
        } as ReadmeTag;
      });

    const readmeTagDiffsInAddedReadmeFiles: ReadmeTag[] = readmeTagDiffs.filter(
      (readmeTag: ReadmeTag): boolean =>
        Boolean(changedFiles?.additions.includes(readmeTag.readme)),
    );
    const readmeTagDiffsInDeletedReadmeFiles: ReadmeTag[] = readmeTagDiffs.filter(
      (readmeTag: ReadmeTag): boolean =>
        Boolean(changedFiles?.deletions.includes(readmeTag.readme)),
    );
    const readmeTagDiffsInChangedReadmeFiles: ReadmeTag[] = readmeTagDiffs.filter(
      (readmeTag: ReadmeTag): boolean => {
        // The README file that contains the API version tags that have been diffed in given readmeTag (i.e. readmeTag.tags)
        // has been modified.
        const readmeModified = changedFiles?.modifications.includes(readmeTag.readme);

        // The README was not modified, added or deleted; just the specs belonging to the API version tags in the README were modified.
        // In such case we assume the README is 'changed' in the sense the specs belonging to the API version tags in the README were modified.
        // The README file itself wasn't modified.
        // We assume here the README is present in the repository - otherwise it would show up as 'deleted' or would not
        // appear as readmeTag.readme in any of the readmeTagDiffs.
        const readmeUnchanged =
          !changedFiles?.additions.includes(readmeTag.readme) &&
          !changedFiles?.deletions.includes(readmeTag.readme);

        return readmeModified || readmeUnchanged;
      },
    );

    const result = {
      additions: readmeTagDiffsInAddedReadmeFiles,
      deletions: readmeTagDiffsInDeletedReadmeFiles,
      changes: readmeTagDiffsInChangedReadmeFiles,
    };

    console.log(
      `RETURN definition CommonPRContext.getReadmeDiffs. ` +
        `changedFiles: ${JSON.stringify(changedFiles)}, ` +
        `tagDiffs: ${JSON.stringify(tagDiffs)}, ` +
        `readmeTagDiffs: ${JSON.stringify(readmeTagDiffs)}, ` +
        `this.readmeDiffs: ${JSON.stringify(result)}.`,
    );

    return result;
  }
}
