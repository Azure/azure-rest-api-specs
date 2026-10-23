import assert from "node:assert/strict";
import { spawn } from "node:child_process";
import { once } from "node:events";
import { mkdir, mkdtemp, readFile, readdir, rm, writeFile } from "node:fs/promises";
import { createServer } from "node:http";
import { tmpdir } from "node:os";
import { join } from "node:path";
import test from "node:test";

const workflow = await readFile(new URL("../references/workflow.md", import.meta.url), "utf8");
const block = workflow.match(/^([ \t]*)```powershell\r?\n([\s\S]*?)^\1```/m);
assert.ok(block, "The workflow must document a PowerShell command.");
const command = block[2]
  .split(/\r?\n/)
  .map((line) => (line.startsWith(block[1]) ? line.slice(block[1].length) : line))
  .join("\n");
const expectedQuery =
  'query { repository(owner: "Azure", name: "azure-rest-api-specs") { suggestedActors(capabilities: [CAN_BE_ASSIGNED], first: 10, query: "copilot") { nodes { login } } } }';

for (const shell of ["powershell.exe", "pwsh.exe"]) {
  for (const status of [200, 500]) {
    void test(
      `${shell}: documented query with HTTP ${status}`,
      { skip: process.platform !== "win32", timeout: 30_000 },
      async (t) => {
        const directory = await mkdtemp(join(tmpdir(), "arm issue command "));
        t.after(() => rm(directory, { recursive: true, force: true }));
        const queryDirectory = join(directory, "query files with spaces");
        await mkdir(queryDirectory);
        const requests: { method: string | undefined; url: string | undefined; body: string }[] =
          [];
        const server = createServer((request, response) => {
          let body = "";
          request.setEncoding("utf8");
          request.on("data", (chunk: string) => {
            body += chunk;
          });
          request.on("end", () => {
            requests.push({ method: request.method, url: request.url, body });
            response.writeHead(status, { "Content-Type": "application/json" });
            response.end(
              JSON.stringify(
                status === 200
                  ? {
                      data: {
                        repository: {
                          suggestedActors: { nodes: [{ login: "copilot-swe-agent" }] },
                        },
                      },
                    }
                  : { message: "Fixture API failure" },
              ),
            );
          });
        });
        t.after(
          () =>
            new Promise<void>((resolve, reject) => {
              server.closeAllConnections();
              server.close((error) => (error ? reject(error) : resolve()));
            }),
        );
        server.listen(0, "127.0.0.1");
        await once(server, "listening");
        const address = server.address();
        assert.ok(address && typeof address !== "string");
        assert.equal(command.match(/\bgh api graphql\b/g)?.length, 1);
        const script = command.replace(
          "gh api graphql",
          `gh api "http://127.0.0.1:${address.port}/graphql"`,
        );
        const scriptPath = join(directory, "query smoke test.ps1");
        await writeFile(scriptPath, script);
        const child = spawn(
          shell,
          ["-NoProfile", "-NonInteractive", "-ExecutionPolicy", "Bypass", "-File", scriptPath],
          {
            timeout: 15_000,
            env: {
              ...process.env,
              TEMP: queryDirectory,
              TMP: queryDirectory,
              GH_CONFIG_DIR: join(directory, "gh config"),
              GH_HOST: "github.com",
              GH_TOKEN: "offline-fixture",
              GITHUB_TOKEN: "offline-fixture",
              GH_ENTERPRISE_TOKEN: "offline-fixture",
              GITHUB_ENTERPRISE_TOKEN: "offline-fixture",
              GH_DEBUG: "",
              GH_PROMPT_DISABLED: "1",
            },
          },
        );
        let stdout = "";
        let stderr = "";
        child.stdout.setEncoding("utf8").on("data", (chunk: string) => {
          stdout += chunk;
        });
        child.stderr.setEncoding("utf8").on("data", (chunk: string) => {
          stderr += chunk;
        });
        const { code, signal } = await new Promise<{
          code: number | null;
          signal: NodeJS.Signals | null;
        }>((resolve, reject) => {
          child.once("error", reject);
          child.once("close", (code, signal) => resolve({ code, signal }));
        });
        assert.equal(signal, null, stderr);
        assert.equal(requests.length, 1, stderr);
        assert.equal(requests[0].method, "POST");
        assert.equal(requests[0].url, "/graphql");
        const body: unknown = JSON.parse(requests[0].body);
        assert.ok(body && typeof body === "object" && "query" in body);
        assert.equal(typeof body.query, "string");
        assert.deepEqual(Object.keys(body), ["query"]);
        assert.ok(typeof body.query === "string");
        assert.equal(body.query.replace(/\s+/g, " ").trim(), expectedQuery);
        assert.deepEqual(
          await readdir(queryDirectory),
          [],
          "Temporary query files must be removed.",
        );
        if (status === 200) {
          assert.equal(code, 0, stderr);
          const payload: unknown = JSON.parse(stdout);
          assert.deepEqual(payload, {
            data: { repository: { suggestedActors: { nodes: [{ login: "copilot-swe-agent" }] } } },
          });
        } else {
          assert.notEqual(code, 0, stderr);
          assert.match(stderr, /Copilot availability query failed/);
        }
      },
    );
  }
}
