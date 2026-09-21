import fs from "node:fs";
import http from "node:http";
import path from "node:path";
import { isMain, parseArgs, runMain } from "./cli.mjs";

const HOST = "127.0.0.1";

export function createAssessmentServer(reportFile) {
  const resolvedReport = path.resolve(reportFile);

  if (!fs.existsSync(resolvedReport)) {
    throw new Error(`Assessment report does not exist: ${resolvedReport}`);
  }

  return http.createServer((request, response) => {
    const requestUrl = new URL(request.url ?? "/", `http://${HOST}`);
    if (request.method !== "GET" || !["/", "/assessment.html"].includes(requestUrl.pathname)) {
      response.writeHead(404, { "Content-Type": "text/plain; charset=utf-8" });
      response.end("Not found\n");
      return;
    }

    response.writeHead(200, {
      "Cache-Control": "no-store",
      "Content-Type": "text/html; charset=utf-8",
    });
    fs.createReadStream(resolvedReport).pipe(response);
  });
}

export async function serveAssessment(reportFile, port = 0) {
  const server = createAssessmentServer(reportFile);
  await new Promise((resolve, reject) => {
    server.once("error", reject);
    server.listen(port, HOST, resolve);
  });

  const address = server.address();
  if (!address || typeof address === "string") {
    server.close();
    throw new Error("Unable to determine the assessment server address.");
  }

  return {
    server,
    url: `http://${HOST}:${address.port}/assessment.html`,
  };
}

if (isMain(import.meta.url)) {
  runMain(async () => {
    const args = parseArgs(process.argv.slice(2), {
      required: ["file"],
      defaults: { port: "0" },
    });
    const port = Number(args.port);
    if (!Number.isInteger(port) || port < 0 || port > 65535) {
      throw new Error("--port must be an integer from 0 through 65535.");
    }

    const { url } = await serveAssessment(args.file, port);
    console.log(`Assessment report: ${url}`);
    console.log("Keep this process running while viewing the report. Press Ctrl+C to stop.");
  });
}
