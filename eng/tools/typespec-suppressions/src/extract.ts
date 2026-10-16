import {
  collectLinterDisables,
  compile,
  createSourceFile,
  NodeHost,
  resolveCompilerOptions,
} from "@typespec/compiler";
import type { CompilerHost, Diagnostic, SourceLocation } from "@typespec/compiler";
import { getSuppressions, SyntaxKind } from "@typespec/compiler/ast";
import type { SuppressionScope } from "@typespec/compiler/ast";
import path from "node:path";
import { normalizeRepoPath } from "./path-utils.ts";
import type { SuppressionRecord } from "./types.ts";

const scopeLabels: Partial<Record<SyntaxKind, string>> = {
  [SyntaxKind.NamespaceStatement]: "namespace",
  [SyntaxKind.ModelStatement]: "model",
  [SyntaxKind.ModelProperty]: "property",
  [SyntaxKind.InterfaceStatement]: "interface",
  [SyntaxKind.OperationStatement]: "op",
  [SyntaxKind.UnionStatement]: "union",
  [SyntaxKind.UnionVariant]: "variant",
  [SyntaxKind.EnumStatement]: "enum",
  [SyntaxKind.EnumMember]: "member",
  [SyntaxKind.ScalarStatement]: "scalar",
  [SyntaxKind.AliasStatement]: "alias",
};

function getAnchorPath(scope: readonly SuppressionScope[]): string {
  const segments: string[] = [];
  for (const { node, name } of scope) {
    const label = scopeLabels[node.kind];
    if (!label || !name) {
      continue;
    }
    // Preserve the report's namespace:A.B spelling when the compiler returns one entry per segment.
    if (label === "namespace" && segments.at(-1)?.startsWith("namespace:")) {
      segments[segments.length - 1] += `.${name}`;
    } else {
      segments.push(`${label}:${name}`);
    }
  }
  return segments.join("/");
}

function getReportLocation({ file, pos }: SourceLocation) {
  const { line, character } = file.getLineAndCharacterOfPosition(pos);
  return { line: line + 1, column: character + 1 };
}

function checkDiagnostics(sourcePath: string, diagnostics: readonly Diagnostic[]) {
  const errors = diagnostics.filter((diagnostic) => diagnostic.severity === "error");
  if (errors.length > 0) {
    throw new Error(
      `Failed to parse ${sourcePath}: ${errors.map((error) => error.message).join("; ")}`,
    );
  }
  for (const diagnostic of diagnostics) {
    console.warn(`Warning in ${sourcePath}: ${diagnostic.message}`);
  }
}

function compareSuppressions(left: SuppressionRecord, right: SuppressionRecord): number {
  return (
    left.sourceFile.localeCompare(right.sourceFile) ||
    left.location.line - right.location.line ||
    left.location.column - right.location.column ||
    left.ruleName.localeCompare(right.ruleName) ||
    left.anchorPath.localeCompare(right.anchorPath)
  );
}

export async function extractInlineSuppressions(
  specPath: string,
  sources: ReadonlyMap<string, string>,
  snapshot: {
    readFile?: (sourcePath: string) => Promise<string | undefined>;
    stat?: (sourcePath: string) => Promise<Awaited<ReturnType<CompilerHost["stat"]>> | undefined>;
    reportSpecPath?: string;
    mapSourcePath?: (sourcePath: string) => string;
  } = {},
): Promise<SuppressionRecord[]> {
  const sourcePaths = [...sources.keys()].filter(isTypeSpecSourceFile);
  if (sourcePaths.length === 0) {
    return [];
  }

  // Keep snapshots virtual and resolve installed dependencies from the tool's own compiler.
  const snapshotRoot = path.resolve(import.meta.dirname, "../.suppression-snapshots");
  const entrypoint = path.join(snapshotRoot, specPath, ".suppression-entrypoint.tsp");
  const files = new Map(
    [...sources].map(([sourcePath, text]) => [path.resolve(snapshotRoot, sourcePath), text]),
  );
  files.set(entrypoint, "");
  const directories = new Set<string>();
  for (const filePath of files.keys()) {
    let directory = path.dirname(filePath);
    while (directory.startsWith(snapshotRoot)) {
      directories.add(directory);
      directory = path.dirname(directory);
    }
  }
  const reads = new Map<string, Promise<string | undefined>>();
  function isSnapshot(filePath: string) {
    return filePath === snapshotRoot || filePath.startsWith(`${snapshotRoot}${path.sep}`);
  }
  function readSnapshot(filePath: string) {
    if (files.has(filePath)) {
      return Promise.resolve(files.get(filePath));
    }
    let pending = reads.get(filePath);
    if (!pending) {
      pending = snapshot.readFile
        ? snapshot.readFile(normalizeRepoPath(path.relative(snapshotRoot, filePath)))
        : Promise.resolve(undefined);
      reads.set(filePath, pending);
    }
    return pending;
  }
  function notFound(filePath: string) {
    return Object.assign(new Error(`Snapshot file not found: ${filePath}`), { code: "ENOENT" });
  }
  const host: CompilerHost = {
    ...NodeHost,
    async readFile(filePath) {
      if (!isSnapshot(filePath)) {
        return NodeHost.readFile(filePath);
      }
      const text = await readSnapshot(filePath);
      if (text === undefined) {
        throw notFound(filePath);
      }
      return createSourceFile(text, filePath);
    },
    async stat(filePath) {
      if (!isSnapshot(filePath)) {
        return NodeHost.stat(filePath);
      }
      if (directories.has(filePath)) {
        return { isDirectory: () => true, isFile: () => false };
      }
      if (!files.has(filePath) && snapshot.stat) {
        const stats = await snapshot.stat(normalizeRepoPath(path.relative(snapshotRoot, filePath)));
        if (stats !== undefined) {
          return stats;
        }
        throw notFound(filePath);
      }
      if ((await readSnapshot(filePath)) !== undefined) {
        return { isDirectory: () => false, isFile: () => true };
      }
      throw notFound(filePath);
    },
    async realpath(filePath) {
      return isSnapshot(filePath) ? filePath : NodeHost.realpath(filePath);
    },
  };
  const projectDirectory = path.join(snapshotRoot, specPath);
  const [options, diagnostics] = await resolveCompilerOptions(host, {
    entrypoint: projectDirectory,
    cwd: projectDirectory,
    env: process.env,
  });
  checkDiagnostics(`${specPath}/tspconfig.yaml`, diagnostics);
  const program = await compile(host, entrypoint, {
    ...options,
    noEmit: true,
    additionalImports: [
      ...(options.additionalImports ?? []),
      ...sourcePaths.map((sourcePath) => path.resolve(snapshotRoot, sourcePath)),
    ],
  });
  for (const script of program.sourceFiles.values()) {
    checkDiagnostics(script.file.path, script.parseDiagnostics);
  }
  if (program.diagnostics.length > 0) {
    console.warn(
      `Compilation of ${specPath} reported diagnostics; suppression usage reflects only stages that ran: ${program.diagnostics.map((diagnostic) => diagnostic.message).join("; ")}`,
    );
  }
  return getSuppressions(program)
    .filter(({ location }) =>
      sources.has(normalizeRepoPath(path.relative(snapshotRoot, location.file.path))),
    )
    .map(({ directive, location: sourceLocation, scope, used }): SuppressionRecord => {
      const sourcePath = (snapshot.mapSourcePath ?? normalizeRepoPath)(
        normalizeRepoPath(path.relative(snapshotRoot, sourceLocation.file.path)),
      );
      const location = getReportLocation(sourceLocation);
      return {
        specPath: snapshot.reportSpecPath ?? specPath,
        sourceKind: "inline",
        ruleName: directive.code,
        justification: directive.message,
        sourceFile: normalizeRepoPath(sourcePath),
        anchorPath:
          getAnchorPath(scope) ||
          `source:${normalizeRepoPath(sourcePath)}@${location.line}:${location.column}`,
        location,
        rawText: sourceLocation.file.text.slice(sourceLocation.pos, sourceLocation.end).trim(),
        used,
      };
    })
    .sort(compareSuppressions);
}

export function extractTspconfigSuppressions(
  specPath: string,
  sourcePath: string,
  text: string,
): SuppressionRecord[] {
  const [disables, diagnostics] = collectLinterDisables(createSourceFile(text, sourcePath));
  checkDiagnostics(sourcePath, diagnostics);
  if (disables === undefined) {
    throw new Error(`Failed to collect suppressions from ${sourcePath}.`);
  }
  return disables
    .map(({ code, message, location }): SuppressionRecord => ({
      specPath,
      sourceKind: "tspconfig",
      ruleName: code,
      justification: message,
      sourceFile: normalizeRepoPath(sourcePath),
      anchorPath: `tspconfig:linter.disable.${code}`,
      location: getReportLocation(location),
      rawText: `${code}: ${message}`,
    }))
    .sort(compareSuppressions);
}

export function isTypeSpecSourceFile(filePath: string): boolean {
  return filePath.endsWith(".tsp");
}

export function isTypeSpecConfigFile(filePath: string): boolean {
  return path.posix.basename(filePath) === "tspconfig.yaml";
}
