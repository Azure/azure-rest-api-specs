import { parseDocument, Scalar, visit } from "yaml";

export function parseYaml(
  content: string,
  { schema = "core" }: { schema?: "core" | "failsafe" } = {},
): unknown {
  const document = parseDocument(content, {
    schema,
    merge: schema === "core",
    customTags: schema === "core" ? ["timestamp"] : [],
    resolveKnownTags: schema === "core",
  });

  const error =
    document.errors[0] ??
    document.warnings.find((warning) => warning.code === "TAG_RESOLVE_FAILED");
  if (error) {
    throw error;
  }
  for (const warning of document.warnings) {
    process.emitWarning(warning);
  }

  if (document.contents === null) {
    return undefined;
  }

  if (schema === "failsafe") {
    // Preserve null for omitted values without coercing quoted empty strings or other scalars.
    visit(document, {
      Scalar(_key, node) {
        if (node.type === Scalar.PLAIN && node.source === "" && node.tag === undefined) {
          node.value = null;
        }
      },
    });
  }

  return document.toJS() as unknown;
}
