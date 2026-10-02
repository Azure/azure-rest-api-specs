import { collectLinterDisables, createSourceFile } from "@typespec/compiler";
import type { Diagnostic, SourceLocation } from "@typespec/compiler";
import { collectSuppressions, parse, SyntaxKind } from "@typespec/compiler/ast";
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

export function extractInlineSuppressions(
  specPath: string,
  sourcePath: string,
  text: string,
): SuppressionRecord[] {
  const script = parse(createSourceFile(text, sourcePath));
  checkDiagnostics(sourcePath, script.parseDiagnostics);
  return collectSuppressions(script)
    .map(({ directive, location: sourceLocation, scope }): SuppressionRecord => {
      const location = getReportLocation(sourceLocation);
      return {
        specPath,
        sourceKind: "inline",
        ruleName: directive.code,
        justification: directive.message,
        sourceFile: normalizeRepoPath(sourcePath),
        anchorPath:
          getAnchorPath(scope) ||
          `source:${normalizeRepoPath(sourcePath)}@${location.line}:${location.column}`,
        location,
        rawText: text.slice(sourceLocation.pos, sourceLocation.end).trim(),
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
