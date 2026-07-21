import { createSourceFile } from "@typespec/compiler";
import { parse, SyntaxKind, visitChildren } from "@typespec/compiler/ast";
import path from "node:path";
import { isMap, LineCounter, parseDocument } from "yaml";
import { normalizeRepoPath } from "./path-utils.ts";
import type { SuppressionRecord } from "./types.ts";

type AstNode = {
  kind?: number;
  id?: { sv?: string };
  statements?: AstNode[] | AstNode;
  directives?: {
    target?: { sv?: string };
    arguments?: Array<{ value?: string; sv?: string; pos?: number; end?: number }>;
    pos?: number;
    end?: number;
  }[];
  pos?: number;
  end?: number;
};

type YamlNodeLike = {
  toJSON?: () => unknown;
  range?: number[];
};

function getStringValue(value: unknown): string | undefined {
  if (value && typeof value === "object") {
    const candidate = value as { value?: string; sv?: string };
    return candidate.value ?? candidate.sv;
  }
  return undefined;
}

function stringifyYamlValue(value: unknown): string {
  if (typeof value === "string") {
    return value;
  }

  if (typeof value === "number" || typeof value === "boolean") {
    return `${value}`;
  }

  return "";
}

function getNodeName(node: AstNode): string | undefined {
  return node.id?.sv;
}

function getScopeSegment(node: AstNode): string | undefined {
  const name = getNodeName(node);
  if (!name) {
    return undefined;
  }

  switch (node.kind) {
    case SyntaxKind.NamespaceStatement:
      return `namespace:${name}`;
    case SyntaxKind.ModelStatement:
      return `model:${name}`;
    case SyntaxKind.ModelProperty:
      return `property:${name}`;
    case SyntaxKind.InterfaceStatement:
      return `interface:${name}`;
    case SyntaxKind.OperationStatement:
    case SyntaxKind.OperationSignatureDeclaration:
      return `op:${name}`;
    case SyntaxKind.UnionStatement:
      return `union:${name}`;
    case SyntaxKind.UnionVariant:
      return `variant:${name}`;
    case SyntaxKind.EnumStatement:
      return `enum:${name}`;
    case SyntaxKind.EnumMember:
      return `member:${name}`;
    case SyntaxKind.ScalarStatement:
      return `scalar:${name}`;
    case SyntaxKind.AliasStatement:
      return `alias:${name}`;
    default:
      return undefined;
  }
}

function getDirectiveLocation(
  sourceFile: ReturnType<typeof createSourceFile>,
  position: number | undefined,
) {
  const resolvedPosition = position ?? 0;
  const { line, character } = sourceFile.getLineAndCharacterOfPosition(resolvedPosition);
  return {
    line: line + 1,
    column: character + 1,
  };
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

function getFileNamespaceSegments(node: AstNode): string[] {
  const namespaceNames: string[] = [];
  let current: AstNode | undefined = node;

  while (current?.kind === SyntaxKind.NamespaceStatement) {
    const name = getNodeName(current);
    if (name) {
      namespaceNames.push(name);
    }

    if (Array.isArray(current.statements) || !current.statements) {
      break;
    }

    current = current.statements;
  }

  return namespaceNames.length > 0 ? [`namespace:${namespaceNames.join(".")}`] : [];
}

function handleDirectives(
  node: AstNode,
  scope: string[],
  sourceFile: ReturnType<typeof createSourceFile>,
  sourcePath: string,
  specPath: string,
  text: string,
  suppressions: SuppressionRecord[],
) {
  for (const directive of node.directives ?? []) {
    if (directive.target?.sv !== "suppress") {
      continue;
    }

    const ruleName = getStringValue(directive.arguments?.[0]) ?? "<unknown-rule>";
    const justification = getStringValue(directive.arguments?.[1]) ?? "";
    const location = getDirectiveLocation(sourceFile, directive.pos);
    const anchorPath =
      scope.length > 0
        ? scope.join("/")
        : `source:${normalizeRepoPath(sourcePath)}@${location.line}:${location.column}`;

    suppressions.push({
      specPath,
      sourceKind: "inline",
      ruleName,
      justification,
      sourceFile: normalizeRepoPath(sourcePath),
      anchorPath,
      location,
      rawText: text.slice(directive.pos ?? 0, directive.end ?? directive.pos ?? 0).trim(),
    });
  }
}

export function extractInlineSuppressions(
  specPath: string,
  sourcePath: string,
  text: string,
): SuppressionRecord[] {
  const sourceFile = createSourceFile(text, sourcePath);
  const script = parse(sourceFile);
  const suppressions: SuppressionRecord[] = [];

  const walk = (node: AstNode, scope: string[]) => {
    if (
      node.kind === SyntaxKind.TypeSpecScript &&
      Array.isArray((node as { statements?: AstNode[] }).statements)
    ) {
      let statementScope = scope;
      for (const statement of (node as { statements: AstNode[] }).statements) {
        const fileNamespaceSegments =
          statement.kind === SyntaxKind.NamespaceStatement
            ? getFileNamespaceSegments(statement)
            : [];

        if (fileNamespaceSegments.length > 0) {
          statementScope = [...statementScope, ...fileNamespaceSegments];
          continue;
        }

        walk(statement, statementScope);
      }
      return;
    }

    const scopeSegment = getScopeSegment(node);
    const currentScope = scopeSegment ? [...scope, scopeSegment] : scope;
    handleDirectives(node, currentScope, sourceFile, sourcePath, specPath, text, suppressions);

    visitChildren(node as never, (child) => {
      walk(child as unknown as AstNode, currentScope);
      return undefined;
    });
  };

  walk(script as unknown as AstNode, []);
  return suppressions.sort(compareSuppressions);
}

export function extractTspconfigSuppressions(
  specPath: string,
  sourcePath: string,
  text: string,
): SuppressionRecord[] {
  const lineCounter = new LineCounter();
  const document = parseDocument(text, { lineCounter });

  if (document.errors.length > 0) {
    throw new Error(
      `Failed to parse ${sourcePath}: ${document.errors.map((error) => error.message).join("; ")}`,
    );
  }

  const linter = document.get("linter", true);
  if (!isMap(linter)) {
    return [];
  }

  const disable = linter.get("disable", true);
  if (!isMap(disable)) {
    return [];
  }

  const suppressions: SuppressionRecord[] = [];
  for (const item of disable.items) {
    const key = item.key as YamlNodeLike | null | undefined;
    const value = item.value as YamlNodeLike | null | undefined;
    const ruleName = stringifyYamlValue(key?.toJSON?.());
    const justification = stringifyYamlValue(value?.toJSON?.());
    if (!ruleName) {
      continue;
    }

    const keyStart = key?.range?.[0] ?? 0;
    const location = lineCounter.linePos(keyStart);
    suppressions.push({
      specPath,
      sourceKind: "tspconfig",
      ruleName,
      justification,
      sourceFile: normalizeRepoPath(sourcePath),
      anchorPath: `tspconfig:linter.disable.${ruleName}`,
      location: {
        line: location.line,
        column: location.col,
      },
      rawText: `${ruleName}: ${justification}`,
    });
  }

  return suppressions.sort(compareSuppressions);
}

export function isTypeSpecSourceFile(filePath: string): boolean {
  return filePath.endsWith(".tsp");
}

export function isTypeSpecConfigFile(filePath: string): boolean {
  return path.posix.basename(filePath) === "tspconfig.yaml";
}
