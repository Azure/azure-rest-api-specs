import { execFile } from "node:child_process";
import { mkdir, mkdtemp, readdir, realpath, rm, writeFile } from "node:fs/promises";
import { createServer, type Socket } from "node:net";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { fileURLToPath } from "node:url";
import { promisify } from "node:util";
import { expect, it } from "vitest";

const execFileAsync = promisify(execFile);
const cli = fileURLToPath(new URL("../cmd/tsv.js", import.meta.url));

it.each(["project", "all"])(
  "preserves %s output and exits when ingestion stalls, with no connections when opted out",
  async (mode) => {
    const root = await realpath(await mkdtemp(join(tmpdir(), "tsv-telemetry-lifecycle-")));
    const sockets = new Set<Socket>();
    let connections = 0;
    const server = createServer((socket) => {
      connections++;
      sockets.add(socket);
      socket.on("close", () => sockets.delete(socket));
    });
    try {
      await new Promise<void>((resolve, reject) => {
        server.once("error", reject);
        server.listen(0, "127.0.0.1", resolve);
      });
      const address = server.address();
      if (!address || typeof address === "string") throw new Error("Expected a TCP address");
      await mkdir(join(root, "specification", "a"), { recursive: true });
      await mkdir(join(root, "specification", "b"));
      await writeFile(join(root, "specification", "a", "tspconfig.yaml"), "");
      await writeFile(join(root, "specification", "b", "tspconfig.yaml"), "");
      await writeFile(
        join(root, "suppressions.yaml"),
        "- tool: TypeSpecValidation\n  paths: ['specification/*']\n  reason: fixture\n",
      );
      const files = await readdir(root, { recursive: true });
      const args = mode === "all" ? ["--all", "specification"] : ["specification/a"];
      const timeout = mode === "all" ? 12000 : 8000;
      const env = {
        ...process.env,
        TSV_APPLICATIONINSIGHTS_CONNECTION_STRING: `InstrumentationKey=00000000-0000-0000-0000-000000000001;IngestionEndpoint=https://127.0.0.1:${address.port}`,
        TSV_TELEMETRY_DEBUG: "true",
        HOME: root,
        USERPROFILE: root,
        TMPDIR: root,
        TMP: root,
        TEMP: root,
      };
      const disabled = await execFileAsync(process.execPath, [cli, ...args], {
        cwd: root,
        env: { ...env, AZSDKTOOLS_COLLECT_TELEMETRY: "false" },
        timeout,
      });
      expect(connections).toBe(0);
      const started = performance.now();
      const enabled = await execFileAsync(process.execPath, [cli, ...args], {
        cwd: root,
        env: { ...env, AZSDKTOOLS_COLLECT_TELEMETRY: "true" },
        timeout,
      });
      expect(performance.now() - started).toBeLessThan(timeout - 500);
      expect(connections).toBe(mode === "all" ? 3 : 1);
      expect(enabled.stdout).toBe(disabled.stdout);
      expect(enabled.stderr).toContain("[tsv:telemetry] SDK export failed");
      expect(enabled.stderr).not.toContain("InstrumentationKey");
      expect(enabled.stderr).not.toContain(root);
      expect(await readdir(root, { recursive: true })).toEqual(files);
    } finally {
      for (const socket of sockets) socket.destroy();
      await new Promise<void>((resolve) => server.close(() => resolve()));
      await rm(root, { recursive: true, force: true });
    }
  },
  15000,
);
