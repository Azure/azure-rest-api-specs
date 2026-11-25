import { isImportStatement, parse } from "@typespec/compiler/ast";

const JAVASCRIPT_FILE_PATTERN = /\.[cm]?js$/i;

export function getLocalTypeSpecImports(filePath: string, content: string): string[] {
  const script = parse(content);
  if (script.parseDiagnostics.length > 0) {
    throw new Error(
      `Unable to parse TypeSpec imports from '${filePath}': ${script.parseDiagnostics.length} diagnostic(s)`,
    );
  }

  return [
    ...new Set(
      script.statements
        .filter(isImportStatement)
        .map((statement) => statement.path.value)
        .filter(
          (importPath) =>
            (importPath.startsWith("./") || importPath.startsWith("../")) &&
            !JAVASCRIPT_FILE_PATTERN.test(importPath),
        ),
    ),
  ].sort();
}
