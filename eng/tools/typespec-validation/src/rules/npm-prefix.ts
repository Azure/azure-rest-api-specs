import type { ILogger } from "@azure-tools/specs-shared/logger";
import { packageDirectory } from "package-directory";
import { resolve } from "pathe";
import { simpleGit } from "simple-git";
import { failure, type RuleResult } from "../rule-result.ts";
import { type Rule } from "../rule.ts";

export class NpmPrefixRule implements Rule {
  readonly name = "NpmPrefix";
  readonly description = "Verify spec is using root level package.json";

  async execute(folder: string, logger: ILogger): Promise<RuleResult> {
    const git = simpleGit(folder);

    let expected_npm_prefix: string | undefined;
    try {
      // If spec folder is inside a git repo, returns repo root
      expected_npm_prefix = resolve(await git.revparse("--show-toplevel"));
    } catch (err) {
      // If spec folder is outside git repo, or if problem running git, throws error
      return failure("npm-prefix", err instanceof Error ? err.message : String(err), {
        path: folder,
      });
    }

    const actual_npm_prefix = resolve((await packageDirectory({ cwd: folder })) ?? folder);

    logger.debug(
      "Expected npm prefix: " +
        expected_npm_prefix +
        "\n" +
        "Actual npm prefix: " +
        actual_npm_prefix,
    );
    if (expected_npm_prefix !== actual_npm_prefix) {
      return {
        ...failure(
          "npm-prefix",
          "TypeSpec folders MUST NOT contain a package.json, and instead MUST rely on the package.json at repo root",
          {
            path: folder,
          },
        ),
      };
    }

    return {
      success: true,
    };
  }
}
