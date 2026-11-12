import fs from "node:fs";
import { createRequire } from "node:module";
import path from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";
import { parseArgs } from "node:util";

const SCRIPT_DIR = path.dirname(fileURLToPath(import.meta.url));
const SHARED_EVAL_SCRIPT_DIR = path.resolve(SCRIPT_DIR, "../../../../../eng/common/scripts/eval");
const requireEval = createRequire(path.join(SHARED_EVAL_SCRIPT_DIR, "package.json"));

type SkillEnvironment = {
  skills?: string[];
  mcpServers?: Record<string, McpServerEnvironment>;
};

type McpServerEnvironment = {
  cwd?: string;
  command?: string;
  args?: string[];
};

type BenchmarkConfig = {
  dir: string;
  environments: Record<string, SkillEnvironment>;
  [key: string]: unknown;
};

type VallyConfigModule = {
  loadProjectConfig(startDir: string): Promise<BenchmarkConfig>;
};

export function configureSkillEnvironments(
  environments: Record<string, SkillEnvironment>,
  evalRoot: string,
  noSkill: boolean,
  skillRoot: string,
) {
  const author = path.resolve(evalRoot, "../SKILL.md");
  const requiresNaming = fs.readFileSync(author, "utf8").includes("azure-typespec-sdk-naming");
  for (const environment of Object.values(environments)) {
    if (environment.skills !== undefined) {
      environment.skills = noSkill
        ? []
        : environment.skills.flatMap((source) => {
            const directory = path.resolve(evalRoot, "evals", source);
            if (fs.existsSync(path.join(directory, "SKILL.md"))) {
              const staged = path.join(skillRoot, path.basename(directory));
              if (!fs.existsSync(staged)) {
                fs.mkdirSync(staged, { recursive: true });
                for (const entry of ["SKILL.md", "references"]) {
                  fs.cpSync(path.join(directory, entry), path.join(staged, entry), {
                    recursive: true,
                  });
                }
              }
              return [staged];
            }
            if (path.basename(directory) === "azure-typespec-sdk-naming" && !requiresNaming) {
              console.log(
                "Selected authoring skill predates naming; omitting the absent dependency.",
              );
              return [];
            }
            throw new Error(`Missing declared benchmark skill: ${directory}`);
          });
    }
    for (const server of Object.values(environment.mcpServers ?? {})) {
      if (server.cwd) server.cwd = path.resolve(evalRoot, server.cwd);
    }
  }
}

// Repository-local preparation. Common owns invocation, authentication and the verdict.
export async function prepareBenchmark(
  evalRoot: string,
  mode: string,
  skillRoot: string,
  mcpKind = process.env.AZSDK_EVAL_MCP_KIND,
) {
  if (!["forced", "trigger", "no-skill"].includes(mode)) {
    throw new Error("Benchmark mode must be forced, trigger or no-skill.");
  }
  if (mcpKind !== "live" && mcpKind !== "mock") {
    throw new Error("AZSDK_EVAL_MCP_KIND must be live or mock.");
  }
  evalRoot = path.resolve(evalRoot);
  // The isolated Vally install is resolved at runtime, so TypeScript cannot follow this module URL.
  const vallyModule = (await import(
    pathToFileURL(requireEval.resolve("@microsoft/vally")).href
  )) as VallyConfigModule;
  const config = await vallyModule.loadProjectConfig(evalRoot);
  if (config.dir !== evalRoot) {
    throw new Error("Benchmark setup requires a .vally.yaml in the eval root.");
  }
  const server = config.environments["azsdk-mcp"]?.mcpServers?.["azure-sdk-mcp"];
  if (!server?.cwd) {
    throw new Error(
      "The pipeline azsdk-mcp environment must define azure-sdk-mcp with a repository cwd.",
    );
  }
  const dllPath = path.resolve(
    evalRoot,
    server.cwd,
    mcpKind === "live" ? "artifacts/mcp/cli/azsdk.dll" : "artifacts/mcp/mock/azsdk-mock.dll",
  );
  if (!fs.statSync(dllPath, { throwIfNoEntry: false })?.isFile()) {
    throw new Error(`Prebuilt ${mcpKind} MCP binary does not exist or is not a file: ${dllPath}`);
  }
  configureSkillEnvironments(
    config.environments,
    evalRoot,
    mode === "no-skill",
    path.resolve(skillRoot),
  );
  server.command = "dotnet";
  server.args = mcpKind === "live" ? [dllPath, "mcp"] : [dllPath];
  const { dir: _dir, ...preparedConfig } = config;
  // Explicit -e paths reload their nearest .vally.yaml. Prepare that CI checkout,
  // rather than hiding overrides in a temporary project that Vally would ignore.
  fs.writeFileSync(
    path.join(evalRoot, ".vally.yaml"),
    JSON.stringify(preparedConfig, null, 2) + "\n",
  );
}

if (process.argv[1] && import.meta.url === pathToFileURL(process.argv[1]).href) {
  try {
    const { values } = parseArgs({
      options: {
        prepare: { type: "boolean" },
        "eval-root": { type: "string" },
        mode: { type: "string" },
        "skill-root": { type: "string" },
      },
    });
    if (values.prepare && values["eval-root"] && values.mode && values["skill-root"]) {
      await prepareBenchmark(values["eval-root"], values.mode, values["skill-root"]);
    } else {
      throw new Error("Use --prepare --eval-root --mode --skill-root.");
    }
  } catch (error) {
    console.error(error instanceof Error ? error.message : String(error));
    process.exit(1);
  }
}
