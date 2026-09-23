import { mkdir, readFile, readdir, realpath, stat, writeFile } from "node:fs/promises";
import { basename, delimiter, dirname, isAbsolute, join, relative, sep } from "node:path";
import { z } from "zod";
import { AnalysisResultSchema } from "./create-analysis-result.ts";
import { runCommand } from "./run-command.ts";

type MitigatedChange = {
  breakingChange: string;
  suggestedFix: string;
  isResolved: boolean;
  typespecChangesSummary?: string[];
};

type MitigationResult = {
  schemaVersion: 1;
  prNumber: number;
  headSha: string;
  sdkLanguage: string;
  mitigationWorkflowUrl: string;
  status: "success";
  customizationCode: string;
  projects: Array<{
    typespecProject: string;
    sdkPackage: string;
    breakingChanges: MitigatedChange[];
  }>;
};

export type MitigateSdkBreakingChangesOptions = {
  runnerTemp: string;
  analysisResultPath: string;
  mitigationResultPath: string;
  mitigationWorkflowUrl: string;
  specificationRepositoryPath: string;
  sdkRepositoryPath: string;
  azureSdkCliPath: string;
};

const CustomizedUpdateResultSchema = z.object({
  success: z.boolean().optional().default(false),
  typeSpecChangesSummary: z.array(z.string()).nullable().optional(),
});

async function findFiles(directory: string, name: string): Promise<string[]> {
  const entries = await readdir(directory, { withFileTypes: true });
  const matches = await Promise.all(
    entries.map(async (entry): Promise<string[]> => {
      const path = join(directory, entry.name);
      if (entry.isDirectory()) {
        return findFiles(path, name);
      }
      return entry.isFile() && entry.name === name ? [path] : [];
    }),
  );
  return matches.flat();
}

function isWithin(parent: string, child: string): boolean {
  const path = relative(parent, child);
  return path !== "" && path !== ".." && !path.startsWith(`..${sep}`) && !isAbsolute(path);
}

async function writeResult(path: string, result: MitigationResult): Promise<void> {
  await writeFile(path, `${JSON.stringify(result, null, 2)}\n`);
}

function cleanCustomizedUpdateResult(
  rawResult: unknown,
  breakingChange: string,
  suggestedFix: string,
): MitigatedChange {
  const envelope = z.record(z.string(), z.unknown()).parse(rawResult);
  const result = CustomizedUpdateResultSchema.parse(envelope.result ?? envelope);
  return {
    breakingChange,
    suggestedFix,
    isResolved: result.success,
    ...(result.typeSpecChangesSummary == null
      ? {}
      : { typespecChangesSummary: result.typeSpecChangesSummary }),
  };
}

export async function mitigateSdkBreakingChanges({
  runnerTemp,
  analysisResultPath,
  mitigationResultPath,
  mitigationWorkflowUrl,
  specificationRepositoryPath: unresolvedSpecificationRepositoryPath,
  sdkRepositoryPath: unresolvedSdkRepositoryPath,
  azureSdkCliPath,
}: MitigateSdkBreakingChangesOptions): Promise<void> {
  const analysisResult = AnalysisResultSchema.parse(
    JSON.parse(await readFile(analysisResultPath, "utf8")),
  );
  const specificationRepositoryPath = await realpath(unresolvedSpecificationRepositoryPath);
  const specificationRoot = await realpath(join(specificationRepositoryPath, "specification"));
  const sdkRepositoryPath = await realpath(unresolvedSdkRepositoryPath);
  const mitigationLog = join(runnerTemp, "sdk-breaking-change-mitigation.log");
  await writeFile(mitigationLog, "");
  await mkdir(dirname(mitigationResultPath), { recursive: true });

  const mitigationResult: MitigationResult = {
    schemaVersion: 1,
    prNumber: analysisResult.prNumber,
    headSha: analysisResult.headSha,
    sdkLanguage: analysisResult.sdkLanguage,
    mitigationWorkflowUrl,
    status: "success",
    customizationCode: "",
    projects: analysisResult.projects.map((project) => ({
      typespecProject: project.typespecProject,
      sdkPackage: project.sdkPackage,
      breakingChanges: [],
    })),
  };
  await writeResult(mitigationResultPath, mitigationResult);

  const locationPaths = await findFiles(sdkRepositoryPath, "tsp-location.yaml");
  for (const [projectIndex, project] of analysisResult.projects.entries()) {
    if (project.breakingChanges.length === 0) {
      console.log(`No SDK breaking changes found for ${project.typespecProject}.`);
      continue;
    }

    const typeSpecProjectPath = await realpath(
      join(specificationRepositoryPath, project.typespecProject),
    );
    if (
      !(await stat(typeSpecProjectPath)).isDirectory() ||
      !isWithin(specificationRoot, typeSpecProjectPath)
    ) {
      throw new Error(`Invalid TypeSpec project path: ${project.typespecProject}`);
    }

    const packagePaths = await Promise.all(
      locationPaths
        .map((locationPath) => dirname(locationPath))
        .filter((packagePath) => basename(packagePath) === project.sdkPackage)
        .map((packagePath) => realpath(packagePath)),
    );
    if (packagePaths.length !== 1 || !isWithin(sdkRepositoryPath, packagePaths[0])) {
      throw new Error(
        `Expected exactly one SDK package named ${project.sdkPackage}, found ${packagePaths.length}.`,
      );
    }

    for (const [changeIndex, change] of project.breakingChanges.entries()) {
      console.log(
        `Mitigating SDK breaking change ${changeIndex + 1} of ${project.breakingChanges.length} for ${project.typespecProject}.`,
      );
      const commandResultPath = join(runnerTemp, `sdk-mitigation-result-${changeIndex}.json`);
      const succeeded = await runCommand({
        command: "azsdk",
        args: [
          "typespec",
          "client",
          "customized-update",
          "--tsp-project-path",
          typeSpecProjectPath,
          "--package-path",
          packagePaths[0],
          "--customization-request",
          `Resolve this SDK breaking change: ${JSON.stringify({
            breakingChange: change.breakingChange,
            category: change.category,
            suggestedFix: change.suggestedFix,
          })}`,
          "--edit-scope",
          "2",
          "--output",
          "json",
        ],
        logPath: mitigationLog,
        outputPath: commandResultPath,
        env: {
          ...process.env,
          PATH: `${azureSdkCliPath}${delimiter}${process.env.PATH ?? ""}`,
        },
        throwOnFailure: false,
      });

      let cleanResult: MitigatedChange = {
        breakingChange: change.breakingChange,
        suggestedFix: change.suggestedFix,
        isResolved: false,
      };
      if (succeeded) {
        try {
          cleanResult = cleanCustomizedUpdateResult(
            JSON.parse(await readFile(commandResultPath, "utf8")),
            change.breakingChange,
            change.suggestedFix,
          );
        } catch {
          cleanResult.isResolved = false;
        }
      }
      mitigationResult.projects[projectIndex].breakingChanges.push(cleanResult);
      await writeResult(mitigationResultPath, mitigationResult);
      if (!succeeded) {
        throw new Error(`Mitigation failed for ${change.breakingChange}.`);
      }
    }
  }
}
