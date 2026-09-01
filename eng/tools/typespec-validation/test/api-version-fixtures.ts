import { type TypeSpecMetadata } from "@azure-tools/specs-shared/typespec-metadata";

export const pythonEmitter = "@azure-tools/typespec-python";
export const javaEmitter = "@azure-tools/typespec-java";

export function serviceYaml(...versions: string[]) {
  return `versions:\n${versions
    .map((version) => `  - version: ${version}\n    source: typespec`)
    .join("\n")}\n`;
}

export function metadata(apiVersions: Record<string, string | undefined>): TypeSpecMetadata {
  return {
    emitterVersion: "0.3.0",
    generatedAt: "2026-08-18T00:00:00.000Z",
    typespec: {
      namespace: "Contoso.Management",
      type: "management",
    },
    languages: Object.fromEntries(
      Object.entries(apiVersions).map(([emitterName, apiVersion]) => [
        emitterName,
        [{ emitterName, apiVersion }],
      ]),
    ),
  };
}
