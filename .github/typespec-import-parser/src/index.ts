import { isImportStatement, parse } from "@typespec/compiler/ast";

const TYPESPEC_FILE_PATTERN = /\.tsp$/i;

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
            TYPESPEC_FILE_PATTERN.test(importPath),
        ),
    ),
  ].sort();
}
