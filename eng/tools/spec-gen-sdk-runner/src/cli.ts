import { parseArgsWithHelp } from "@azure-tools/specs-shared/cli";
import { exit } from "node:process";

function stringOption(description: string) {
  return { type: "string", default: "", description } as const;
}

export function parseCliArguments(args = process.argv.slice(2)) {
  const parsed = parseArgsWithHelp({
    args,
    options: {
      scp: stringOption("Local spec repository path (default: runner directory)."),
      lang: stringOption("SDK repository name (default: azure-sdk-for-net)."),
      sdp: stringOption("Local SDK repository path (default: sibling of the spec repository)."),
      wf: stringOption("Working folder (default: parent of the spec repository)."),
      "batch-type": stringOption("Batch of specs to generate; takes precedence over --pr-number."),
      "pr-number": stringOption("Pull request number for spec PR generation."),
      "tsp-config-relative-path": stringOption("Repository-relative TypeSpec configuration path."),
      "readme-relative-path": stringOption("Repository-relative Swagger README path."),
      "api-version": stringOption("API version to generate."),
      "sdk-release-type": stringOption("SDK release type."),
      "typespec-emitter": stringOption("TypeSpec emitter forwarded to SDK generation."),
      commit: stringOption("Spec commit SHA (default: HEAD)."),
      "spec-repo-url": stringOption("Spec repository HTTPS URL."),
      "head-repo-url": stringOption("Head repository HTTPS URL."),
      "head-branch": stringOption("Head branch name."),
    },
    help: {
      command: "spec-gen-sdk-runner",
      description: "Generate SDKs for a single spec, a spec pull request, or a batch of specs.",
      examples: ["--pr-number 12345 --lang azure-sdk-for-js", "--batch-type all-typespecs"],
    },
  });
  if (!parsed) {
    exit(0);
  }
  return parsed.values;
}
