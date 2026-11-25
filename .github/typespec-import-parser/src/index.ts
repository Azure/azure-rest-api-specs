import { createSourceFile, NodeHost, NoTarget, type CompilerHost } from "@typespec/compiler";
import { unsafe_createSourceLoader } from "@typespec/compiler/experimental";

const JAVASCRIPT_FILE_PATTERN = /\.[cm]?js$/i;

export async function getLocalTypeSpecImports(
  filePath: string,
  content: string,
): Promise<string[]> {
  const host: CompilerHost = {
    ...NodeHost,
    readFile: async (requestedPath) => {
      if (requestedPath !== filePath) {
        throw new Error(`Unexpected TypeSpec source request '${requestedPath}'`);
      }
      return createSourceFile(content, filePath);
    },
  };
  const loader = await unsafe_createSourceLoader(host, { externals: () => true });
  await loader.importFile(filePath, NoTarget, undefined, "entrypoint");
  const errors = loader.resolution.diagnostics.filter(
    (diagnostic) => diagnostic.severity === "error",
  );
  if (errors.length > 0) {
    throw new Error(
      `Unable to load TypeSpec imports from '${filePath}': ${errors.length} error diagnostic(s)`,
    );
  }

  return [
    ...new Set(
      loader.resolution.externals.filter(
        (importPath) =>
          (importPath.startsWith("./") || importPath.startsWith("../")) &&
          !JAVASCRIPT_FILE_PATTERN.test(importPath),
      ),
    ),
  ].sort();
}
