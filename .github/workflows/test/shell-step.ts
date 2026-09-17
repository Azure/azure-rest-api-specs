import { execFile } from "node:child_process";
import { existsSync } from "node:fs";
import { chmod, mkdtemp, readFile, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { promisify } from "node:util";
import { isExecError } from "../../shared/src/exec.ts";

export async function runShellStep(
  script: string,
  {
    tool = "gh",
    response = "",
    fail = false,
    env = {},
    payload = {},
  }: {
    tool?: "gh" | "curl";
    response?: string;
    fail?: boolean;
    env?: Record<string, string>;
    payload?: object;
  } = {},
) {
  const directory = await mkdtemp(join(tmpdir(), "workflow-step-"));
  const path = (name: string) => join(directory, name).replaceAll("\\", "/");
  try {
    await writeFile(path("event.json"), JSON.stringify(payload));
    await writeFile(path("output"), "");
    await writeFile(
      path(tool),
      [
        "#!/usr/bin/env bash",
        'printf "%s\\0" "$@" > "$MOCK_TOOL_ARGS"',
        'if [[ "$MOCK_FAIL" == "true" ]]; then',
        '  echo "API unavailable" >&2',
        "  exit 1",
        "fi",
        'printf "%s" "$MOCK_RESPONSE"',
        "",
      ].join("\n"),
    );
    await chmod(path(tool), 0o755);
    const environment = {
      ...process.env,
      GITHUB_EVENT_NAME: "workflow_dispatch",
      GITHUB_EVENT_PATH: path("event.json"),
      GITHUB_REPOSITORY: "Azure/azure-rest-api-specs",
      GITHUB_OUTPUT: path("output"),
      GH_TOKEN: "fixture-token",
      MOCK_TOOL_ARGS: path("args"),
      MOCK_TOOL_PATH: path(tool),
      MOCK_TOKEN_FILE: path("oidc-token"),
      MOCK_RESPONSE: response,
      MOCK_FAIL: String(fail),
      ...env,
    };
    let stdout = "";
    let stderr = "";
    let code: number | string | null | undefined = 0;
    // Use Git Bash rather than Windows' optional WSL launcher.
    const bash =
      process.platform === "win32"
        ? join(process.env.ProgramFiles ?? "C:/Program Files", "Git", "bin", "bash.exe")
        : "bash";
    // Native jq.exe otherwise rewrites embedded LF characters to CRLF.
    const jq = process.platform === "win32" ? 'jq() { command jq --binary "$@"; }\n' : "";
    try {
      ({ stdout, stderr } = await promisify(execFile)(
        bash,
        [
          "--noprofile",
          "--norc",
          "-c",
          // Git Bash prepends its own curl directory to PATH, so bind the stub explicitly.
          `${tool}() { bash "$MOCK_TOOL_PATH" "$@"; }\n${jq}${script}`,
        ],
        { env: environment },
      ));
    } catch (error) {
      if (!isExecError(error)) throw error;
      stdout = error.stdout ?? "";
      stderr = error.stderr ?? "";
      code = error.code;
    }
    return {
      code,
      stdout,
      stderr,
      output: await readFile(path("output"), "utf8"),
      args: existsSync(path("args"))
        ? (await readFile(path("args"), "utf8")).split("\0").slice(0, -1)
        : [],
      token: existsSync(path("oidc-token"))
        ? await readFile(path("oidc-token"), "utf8")
        : undefined,
    };
  } finally {
    await rm(directory, { recursive: true, force: true });
  }
}
