import { SWAGGER_SUPPRESSION_TOOLS } from "@azure-tools/specs-shared/swagger-suppressions";
import { getSuppressionsForTools } from "@azure-tools/suppressions";
import { resolve } from "node:path";
import { pathExists } from "./util.ts";

export async function getUnsuppressedSwaggers(
  beforePath: string,
  afterPath: string,
  swaggerPaths: Set<string>,
): Promise<Set<string>> {
  const result = new Set<string>();

  for (const swaggerPath of swaggerPaths) {
    const afterSwaggerPath = resolve(afterPath, swaggerPath);
    const beforeSwaggerPath = resolve(beforePath, swaggerPath);
    const absoluteSwaggerPath = (await pathExists(afterSwaggerPath))
      ? afterSwaggerPath
      : beforeSwaggerPath;

    if (!(await pathExists(absoluteSwaggerPath))) {
      result.add(swaggerPath);
      continue;
    }

    const suppressions = await getSuppressionsForTools(
      [SWAGGER_SUPPRESSION_TOOLS.lintDiff, SWAGGER_SUPPRESSION_TOOLS.all],
      absoluteSwaggerPath,
    );
    const isSuppressed = suppressions.some(
      (suppression) => !suppression.rules?.length && !suppression.subRules?.length,
    );

    if (isSuppressed) {
      console.log(`Skipping suppressed Swagger file: ${swaggerPath}`);
    } else {
      result.add(swaggerPath);
    }
  }

  return result;
}
