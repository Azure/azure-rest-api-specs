import { load } from "js-yaml";
import { readFile } from "node:fs/promises";
import { join } from "node:path";
import { describe, expect, it } from "vitest";
import { runShellStep } from "./shell-step.ts";

async function readStep(file: string, id: string) {
  const source = await readFile(join(import.meta.dirname, "..", file), "utf8");
  const match = /^---\r?\n([\s\S]*?)\r?\n---/.exec(source);
  if (!match) throw new Error(`Missing frontmatter: ${file}`);
  const workflow = load(match[1]) as {
    on?: { steps?: { id?: string; run?: string }[] };
    steps?: { id?: string; run?: string }[];
  };
  const script = (workflow.steps ?? workflow.on?.steps)?.find((step) => step.id === id)?.run;
  if (!script) throw new Error(`Missing step: ${file}:${id}`);
  return script;
}

describe("agentic trigger labels", () => {
  it.each(["data-plane-api-review", "hero-scenarios"])(
    "removes the %s label without checkout",
    async (workflow) => {
      const script = await readStep(`${workflow}.md`, "remove_label");
      const result = await runShellStep(script, { env: { PR_NUMBER: "42" } });
      expect(result.code).toBe(0);
      expect(result.args).toEqual([
        "api",
        "--method",
        "DELETE",
        `repos/Azure/azure-rest-api-specs/issues/42/labels/${workflow}-needed`,
      ]);
    },
  );

  it.each(["data-plane-api-review", "hero-scenarios"])(
    "warns without failing when the %s label cannot be removed",
    async (workflow) => {
      const result = await runShellStep(await readStep(`${workflow}.md`, "remove_label"), {
        env: { PR_NUMBER: "42" },
        fail: true,
      });
      expect(result.code).toBe(0);
      expect(result.stdout).toContain("::warning::Could not remove trigger label");
      expect(result.stderr).toContain("API unavailable");
    },
  );
});

describe("agentic Azure OIDC", () => {
  const file = "shared-github-aw-imports/global_networks_auth_import.md";
  const env = {
    ACTIONS_ID_TOKEN_REQUEST_TOKEN: "fixture-request-token",
    ACTIONS_ID_TOKEN_REQUEST_URL: "https://oidc.invalid/token?api-version=2.0",
  };
  async function script() {
    const value = await readStep(file, "oidc");
    expect(value).toContain('> "/tmp/azure-oidc-token"');
    return value.replaceAll("/tmp/azure-oidc-token", "$MOCK_TOKEN_FILE");
  }

  it("requests the encoded audience, masks the token, and writes it without a newline", async () => {
    const result = await runShellStep(await script(), {
      tool: "curl",
      env,
      response: '{"value":"fixture.jwt.token"}',
    });
    expect(result.code).toBe(0);
    expect(result.args).toEqual([
      "--fail",
      "--silent",
      "--show-error",
      "--get",
      "--data-urlencode",
      "audience=api://AzureADTokenExchange",
      "--header",
      "Authorization: bearer fixture-request-token",
      "https://oidc.invalid/token?api-version=2.0",
    ]);
    expect(result.stdout).toBe("::add-mask::fixture.jwt.token\n");
    expect(result.stderr).toBe("");
    expect(result.token).toBe("fixture.jwt.token");
  });

  it("escapes masking commands without changing the file contents", async () => {
    const result = await runShellStep(await script(), {
      tool: "curl",
      env,
      response: JSON.stringify({ value: "token%\r\n-value" }),
    });
    expect(result.stdout).toBe("::add-mask::token%25%0D%0A-value\n");
    expect(result.token).toBe("token%\r\n-value");
  });

  it.each(["{}", '{"value":""}', '{"value":null}', '{"value":12}', "invalid"])(
    "rejects an invalid OIDC response %s",
    async (response) => {
      const result = await runShellStep(await script(), { tool: "curl", env, response });
      expect(result.code).not.toBe(0);
      expect(result.token).toBeUndefined();
      expect(result.stdout).not.toContain("::add-mask::");
      expect(result.stdout).toContain("::error::OIDC response did not contain a token");
    },
  );

  it("propagates HTTP failures without writing a token", async () => {
    const result = await runShellStep(await script(), { tool: "curl", env, fail: true });
    expect(result.code).not.toBe(0);
    expect(result.token).toBeUndefined();
    expect(result.stderr).toContain("API unavailable");
    expect(result.stdout).toContain("::error::Failed to request Azure OIDC token");
  });

  it.each(Object.keys(env))("rejects a missing %s", async (name) => {
    const result = await runShellStep(await script(), {
      tool: "curl",
      env: { ...env, [name]: "" },
    });
    expect(result.code).not.toBe(0);
    expect(result.args).toEqual([]);
    expect(result.token).toBeUndefined();
  });
});
