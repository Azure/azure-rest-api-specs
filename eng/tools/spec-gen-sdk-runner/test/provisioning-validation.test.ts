import { SdkName } from "@azure-tools/specs-shared/sdk-types";
import fs from "node:fs";
import { afterEach, expect, test, vi } from "vitest";
import * as commandHelpers from "../src/command-helpers.ts";
import { generateSdkForSpecPr } from "../src/commands.ts";
import * as log from "../src/log.ts";
import * as specHelpers from "../src/spec-helpers.ts";
import * as utils from "../src/utils.ts";

afterEach(() => {
  vi.restoreAllMocks();
});

test.each([
  {
    language: SdkName.Js,
    emitter: "@azure-tools/typespec-ts-provisioning",
    required: false,
  },
  {
    language: SdkName.Net,
    emitter: "@azure-typespec/http-client-csharp-provisioning",
    required: false,
  },
  ...[SdkName.Js, SdkName.Net].flatMap((language) =>
    [undefined, "", "@custom/emitter", "@custom/provisioning"].map((emitter) => ({
      language,
      emitter,
      required: true,
    })),
  ),
  {
    language: SdkName.Js,
    emitter: "@azure-typespec/http-client-csharp-provisioning",
    required: true,
  },
  {
    language: SdkName.Net,
    emitter: "@azure-tools/typespec-ts-provisioning",
    required: true,
  },
])(
  "keeps $language failure visible with emitter $emitter (required=$required)",
  async ({ language, emitter, required }) => {
    vi.spyOn(process, "argv", "get").mockReturnValue([
      "node",
      "runner",
      "--lang",
      language,
      "--pr-number",
      "123",
      ...(emitter === undefined ? [] : ["--typespec-emitter", emitter]),
    ]);
    vi.spyOn(commandHelpers, "installLanguageToolchain").mockResolvedValue(undefined);
    vi.spyOn(specHelpers, "detectChangedSpecConfigFiles").mockResolvedValue([
      {
        specs: [],
        typespecProject: "specification/service/Service.Management/tspconfig.yaml",
      },
    ]);
    vi.spyOn(utils, "resetGitRepo").mockResolvedValue(undefined);
    const runCommand = vi
      .spyOn(utils, "runSpecGenSdkCommand")
      .mockRejectedValue(new Error("SDK validation failed"));
    vi.spyOn(commandHelpers, "getExecutionReport").mockReturnValue({
      packages: [],
      executionResult: "failed",
      generateFromTypeSpec: true,
      vsoLogPath: "validation-log.json",
    });
    const logIssues = vi.spyOn(commandHelpers, "logIssuesToPipeline").mockImplementation(() => {});
    vi.spyOn(fs, "existsSync").mockReturnValue(true);
    const writeArtifact = vi.spyOn(fs, "writeFileSync").mockImplementation(() => {});
    vi.spyOn(log, "logMessage").mockImplementation(() => {});
    vi.spyOn(log, "setVsoVariable").mockImplementation(() => {});

    expect(await generateSdkForSpecPr()).toEqual({
      statusCode: 1,
      executionResult: "failed",
    });
    expect(runCommand).toHaveBeenCalledOnce();
    const args = runCommand.mock.calls[0][0];
    if (emitter) {
      expect(args).toContain("--typespec-emitter");
      expect(args[args.indexOf("--typespec-emitter") + 1]).toBe(emitter);
    } else {
      expect(args).not.toContain("--typespec-emitter");
    }
    expect(logIssues).toHaveBeenCalledWith(
      "validation-log.json",
      "specification/service/Service.Management/tspconfig.yaml",
    );
    expect(writeArtifact).toHaveBeenCalledOnce();
    const artifactContent = writeArtifact.mock.calls[0][1];
    if (typeof artifactContent !== "string") {
      throw new Error("Expected a JSON string artifact");
    }
    expect(JSON.parse(artifactContent)).toMatchObject({
      language,
      result: "failed",
      isSpecGenSdkCheckRequired: required,
    });
  },
);
