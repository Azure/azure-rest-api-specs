/**
 * This file contains types for the contents of the SDK suppressions file, sdk-suppressions.yml.
 * For details, see:
 * - https://microsoftapc-my.sharepoint.com/:w:/g/personal/raychen_microsoft_com/EbOAA9SkhQhGlgxtf7mc0kUB-25bFue0EFbXKXS3TFLTQA
 */

import { Ajv } from "ajv";
import { SdkName, sdkLabels } from "@azure-tools/specs-shared/sdk-types";

export const sdkSuppressionsFileName = "sdk-suppressions.yaml";

export type SdkSuppressionsYml = {
  suppressions: SdkSuppressionsSection;
};

export type SdkSuppressionsSection = {
  [sdkName in SdkName]?: SdkPackageSuppressionsEntry[];
};

export type SdkPackageSuppressionsEntry = {
  package: string;
  "breaking-changes": string[];
};

function exitWithError(error: string): never {
    console.error("Error:", error);
    process.exit(1);
}

export function validateSdkSuppressionsFile(
  suppressionContent: string | object | undefined | null,
): {
  result: boolean;
  message: string;
} {
  if (suppressionContent === null) {
    exitWithError("This suppression file is a empty file");
  }

  if (!suppressionContent) {
    exitWithError("This suppression file is not a valid yaml. Refer to https://aka.ms/azsdk/sdk-suppression for more information.");
  }

  const suppressionFileSchema = {
    type: "object",
    properties: {
      suppressions: {
        type: "object",
        propertyNames: {
          enum: Object.keys(sdkLabels),
        },
        patternProperties: {
          "^.*$": {
            type: "array",
            items: {
              type: "object",
              properties: {
                package: { type: "string" },
                "breaking-changes": { type: "array", items: { type: "string" } },
              },
              required: ["package", "breaking-changes"],
              additionalProperties: false,
            },
          },
        },
      },
    },
    required: ["suppressions"],
    additionalProperties: false,
  };

  const suppressionAjv = new Ajv({ allErrors: true });
  const suppressionAjvCompile = suppressionAjv.compile(suppressionFileSchema);

  const isValid = suppressionAjvCompile(suppressionContent);

  if (isValid) {
    return {
      result: true,
      message: "This suppression file is a valid yaml.",
    };
  } else {
    exitWithError("This suppression file is a valid yaml but the schema is wrong: " + suppressionAjv.errorsText(suppressionAjvCompile.errors, { separator: "\n" }));
  }
}
