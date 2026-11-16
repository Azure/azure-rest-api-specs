import { parse, SyntaxKind } from "@typespec/compiler/ast";
import { ResolveModuleError, resolveModule } from "@typespec/compiler/module-resolver";
import { glob, readFile, stat } from "node:fs/promises";
import { dirname, extname, isAbsolute, join, resolve } from "pathe";
import { parse as parseYaml } from "yaml";

export interface UnresolvedImport {
  readonly specifier: string;
  /** File containing the import, or the config that declared it. */
  readonly from: string;
}

export interface TypeSpecProject {
  readonly path: string;
  /** `tspconfig.yaml` followed by every config it extends. */
  readonly configs: readonly string[];
  /** `client.tsp` and `main.tsp` when present, in compile-preference order. */
  readonly entrypoints: readonly string[];
  /** Local files the compilation reads: configs, transitively imported sources, and examples. */
  readonly inputs: readonly string[];
  /** Package imports, which are resolved from `node_modules` and not traversed. */
  readonly libraries: readonly string[];
  /** Other projects that own at least one of this project's inputs. */
  readonly dependencies: readonly string[];
  readonly unresolved: readonly UnresolvedImport[];
}

export interface TypeSpecProjectGraph {
  readonly projects: ReadonlyMap<string, TypeSpecProject>;
  /** Input files and the projects that read them. */
  readonly dependents: ReadonlyMap<string, readonly string[]>;
}

interface SourceImports {
  readonly local: string[];
  readonly libraries: string[];
  readonly unresolved: UnresolvedImport[];
}

const resolveHost = {
  // Keep symlinked paths as written so they match discovered project paths.
  realpath: (path: string) => Promise.resolve(path),
  stat: (path: string) => stat(path),
  readFile: (path: string) => readFile(path, "utf8"),
};

/**
 * Build the static input graph of TypeSpec projects without type-checking them.
 * Imports are resolved the same way as the compiler resolves relative imports; package imports
 * are recorded but not followed, since their sources come from installed dependencies.
 */
export async function buildProjectGraph(folders: readonly string[]): Promise<TypeSpecProjectGraph> {
  const paths = [...new Set(folders.map((folder) => resolve(folder)))].sort();
  const projectPaths = new Set(paths);
  const sources = new Map<string, Promise<SourceImports>>();
  const readImports = (file: string) => {
    let imports = sources.get(file);
    if (!imports) {
      imports = readSourceImports(file);
      sources.set(file, imports);
    }
    return imports;
  };

  const projects = new Map<string, TypeSpecProject>();
  for (const project of await Promise.all(
    paths.map((path) => buildProject(path, projectPaths, readImports)),
  )) {
    projects.set(project.path, project);
  }

  const dependents = new Map<string, string[]>();
  for (const project of projects.values()) {
    for (const file of project.inputs) {
      const users = dependents.get(file) ?? [];
      users.push(project.path);
      dependents.set(file, users);
    }
  }
  return { projects, dependents: new Map([...dependents].sort(([a], [b]) => a.localeCompare(b))) };
}

/** Projects whose inputs include any of the given absolute file paths. */
export function findAffectedProjects(
  graph: TypeSpecProjectGraph,
  files: readonly string[],
): string[] {
  const affected = new Set<string>();
  for (const file of files) {
    for (const project of graph.dependents.get(resolve(file)) ?? []) affected.add(project);
  }
  return [...affected].sort();
}

async function buildProject(
  path: string,
  projectPaths: ReadonlySet<string>,
  readImports: (file: string) => Promise<SourceImports>,
): Promise<TypeSpecProject> {
  const inputs = new Set<string>();
  const libraries = new Set<string>();
  const unresolved: UnresolvedImport[] = [];
  const pending: string[] = [];

  const configs = await readConfigChain(join(path, "tspconfig.yaml"), unresolved);
  for (const config of configs.files) inputs.add(config);
  for (const { specifier, from } of configs.imports) {
    if (!isLocalSpecifier(specifier)) libraries.add(specifier);
    else {
      const resolved = await resolveLocalImport(specifier, from);
      if (resolved) pending.push(resolved);
      else unresolved.push({ specifier, from });
    }
  }

  const entrypoints: string[] = [];
  for (const name of ["client.tsp", "main.tsp"]) {
    const file = join(path, name);
    if (await isFile(file)) {
      entrypoints.push(file);
      pending.push(file);
    }
  }

  while (pending.length > 0) {
    const file = pending.pop()!;
    if (inputs.has(file)) continue;
    inputs.add(file);
    if (extname(file) !== ".tsp") continue;
    const imports = await readImports(file);
    pending.push(...imports.local);
    for (const library of imports.libraries) libraries.add(library);
    unresolved.push(...imports.unresolved);
  }

  for await (const entry of glob("examples/**/*", { cwd: path, withFileTypes: true })) {
    if (entry.isFile()) inputs.add(resolve(entry.parentPath, entry.name));
  }

  const dependencies = new Set<string>();
  for (const file of inputs) {
    const owner = findOwningProject(file, projectPaths);
    if (owner && owner !== path) dependencies.add(owner);
  }

  return {
    path,
    configs: configs.files,
    entrypoints,
    inputs: [...inputs].sort(),
    libraries: [...libraries].sort(),
    dependencies: [...dependencies].sort(),
    unresolved,
  };
}

async function readSourceImports(file: string): Promise<SourceImports> {
  const result: SourceImports = { local: [], libraries: [], unresolved: [] };
  let text: string;
  try {
    text = await readFile(file, "utf8");
  } catch (error) {
    if (isMissing(error)) return result;
    throw error;
  }
  for (const statement of parse(text).statements) {
    if (statement.kind !== SyntaxKind.ImportStatement) continue;
    const specifier = statement.path.value;
    if (!isLocalSpecifier(specifier)) {
      result.libraries.push(specifier);
      continue;
    }
    const resolved = await resolveLocalImport(specifier, file);
    if (resolved) result.local.push(resolved);
    else result.unresolved.push({ specifier, from: file });
  }
  return result;
}

async function resolveLocalImport(specifier: string, from: string): Promise<string | undefined> {
  const target = resolve(dirname(from), specifier);
  if ([".tsp", ".js", ".mjs"].includes(extname(target))) {
    return (await isFile(target)) ? target : undefined;
  }
  try {
    const module = await resolveModule(resolveHost, specifier, {
      baseDir: dirname(from),
      directoryIndexFiles: ["main.tsp", "index.mjs", "index.js"],
      resolveMain: (pkg: { tspMain?: string; main: string }) => pkg.tspMain ?? pkg.main,
      conditions: ["typespec"],
      fallbackOnMissingCondition: true,
    });
    return module.type === "module" ? module.mainFile : module.path;
  } catch (error) {
    if (error instanceof ResolveModuleError) return undefined;
    throw error;
  }
}

async function readConfigChain(
  config: string,
  unresolved: UnresolvedImport[],
): Promise<{ files: string[]; imports: { specifier: string; from: string }[] }> {
  const files: string[] = [];
  const imports: { specifier: string; from: string }[] = [];
  let current: string | undefined = config;
  while (current && !files.includes(current)) {
    let text: string;
    try {
      text = await readFile(current, "utf8");
    } catch (error) {
      if (!isMissing(error)) throw error;
      if (current !== config) unresolved.push({ specifier: current, from: files.at(-1)! });
      break;
    }
    files.push(current);
    let value: unknown;
    try {
      value = parseYaml(text);
    } catch {
      // Invalid configs are reported by validation rules; the file itself is still an input.
      break;
    }
    const { extends: base, imports: configImports } = (value ?? {}) as {
      extends?: unknown;
      imports?: unknown;
    };
    if (Array.isArray(configImports)) {
      for (const specifier of configImports) {
        if (typeof specifier === "string") imports.push({ specifier, from: current });
      }
    }
    current = typeof base === "string" ? resolve(dirname(current), base) : undefined;
  }
  return { files, imports };
}

function findOwningProject(file: string, projects: ReadonlySet<string>): string | undefined {
  for (let dir = dirname(file); ; dir = dirname(dir)) {
    if (projects.has(dir)) return dir;
    if (dirname(dir) === dir) return undefined;
  }
}

function isLocalSpecifier(specifier: string) {
  return specifier.startsWith("./") || specifier.startsWith("../") || isAbsolute(specifier);
}

async function isFile(path: string) {
  try {
    return (await stat(path)).isFile();
  } catch (error) {
    if (isMissing(error)) return false;
    throw error;
  }
}

function isMissing(error: unknown) {
  return error instanceof Error && "code" in error && error.code === "ENOENT";
}
