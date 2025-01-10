// Copied from https://github.com/microsoft/typespec/blob/main/packages/compiler/src/yaml/types.ts

import { SourceFile } from "@typespec/compiler";
import { Document } from "yaml";

export interface YamlScript {
  readonly kind: "yaml-script";
  readonly file: SourceFile;
  /** Value of the yaml script. */
  readonly value: unknown;

  /** @internal yaml library document. We do not expose this as the "yaml" library is not part of the contract. */
  readonly doc: Document.Parsed;
}

/**
 * Represent the location of a value in a yaml script.
 */
export interface YamlPathTarget {
  kind: "path-target";
  script: YamlScript;
  path: string[];
}
export type YamlDiagnosticTargetType = "value" | "key";
