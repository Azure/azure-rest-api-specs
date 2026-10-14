import { readFile } from "node:fs/promises";
import { join } from "node:path";
import { escapeMarkdown, inlineCode, link } from "@azure-tools/specs-shared/markdown";
import { z } from "zod";
import type { Core } from "../github.ts";

const ProjectResultSchema = z.object({
  typespecProjectPath: z.string().min(1),
  packageName: z.string().min(1),
  resultsPath: z.string().min(1),
});

const resultFiles = ["generate.json", "build.json", "breaking-changes.json"] as const;
const ERROR_LOG_LINE_LIMIT = 10;

async function tryReadFile(
  path: string,
  warning: (message: string) => void,
): Promise<string | undefined> {
  try {
    return await readFile(path, "utf8");
  } catch (error) {
    if (error instanceof Error && "code" in error && error.code === "ENOENT") {
      return undefined;
    }
    const message = error instanceof Error ? error.message : String(error);
    warning(`Failed to read ${path}: ${message}`);
    return undefined;
  }
}

function lastLines(value: string, count: number): string {
  const lines = value.replace(/\r\n?/g, "\n").split("\n");
  if (lines.at(-1) === "") lines.pop();
  return lines.slice(-count).join("\n");
}

export async function buildAnalysisSummary({
  resultsPath,
  jobStatus,
  analysisOutcome,
  analyzedSha,
  jobLogUrl,
  warning = console.warn,
}: {
  resultsPath: string;
  jobStatus: string;
  analysisOutcome: string;
  analyzedSha: string;
  jobLogUrl: string;
  warning?: (message: string) => void;
}): Promise<string> {
  const blocks = [
    "## SDK breaking-change analysis",
    analyzedSha ? `**Analyzed commit:** ${inlineCode(analyzedSha)}` : undefined,
  ];

  if (jobStatus === "failure") {
    blocks.push("Breaking change analysis failed.");
    const errorLog =
      analysisOutcome === "failure"
        ? await tryReadFile(join(resultsPath, "error.log"), warning)
        : undefined;
    blocks.push(
      errorLog
        ? `### Error\n\n${lastLines(errorLog, ERROR_LOG_LINE_LIMIT)
            .split("\n")
            .map((line) => `    ${line}`)
            .join("\n")}`
        : "Error output is available in the failed step log.",
      link("See failed step", jobLogUrl),
    );
    return blocks.filter((block) => block !== undefined).join("\n\n");
  }

  const manifest = await tryReadFile(join(resultsPath, "projects.json"), warning);
  if (!manifest) {
    return blocks.filter((block) => block !== undefined).join("\n\n");
  }

  const projects = z.array(ProjectResultSchema).parse(JSON.parse(manifest));
  for (const project of projects) {
    const projectBlocks = [
      `### ${escapeMarkdown(project.typespecProjectPath)}`,
      `**SDK Package:** ${escapeMarkdown(project.packageName)}`,
    ];
    const projectResultsPath = join(resultsPath, project.resultsPath);
    for (const resultFile of resultFiles) {
      const result = await tryReadFile(join(projectResultsPath, resultFile), warning);
      if (result !== undefined) {
        projectBlocks.push(`#### ${resultFile}\n\n\`\`\`json\n${result.trimEnd()}\n\`\`\``);
      }
    }
    blocks.push(projectBlocks.join("\n\n"));
  }

  return blocks.filter((block) => block !== undefined).join("\n\n");
}

export async function publishAnalysisSummary({
  core,
  ...options
}: Omit<Parameters<typeof buildAnalysisSummary>[0], "warning"> & { core: Core }): Promise<void> {
  const summary = await buildAnalysisSummary({
    ...options,
    warning: (message) => core.warning(message),
  });
  await core.summary.addRaw(summary).write();
}
