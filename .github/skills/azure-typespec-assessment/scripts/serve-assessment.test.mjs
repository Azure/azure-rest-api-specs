import assert from "node:assert/strict";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import test from "node:test";
import { serveAssessment } from "./serve-assessment.mjs";

void test("serves only the selected assessment report on localhost", async (context) => {
  const work = fs.mkdtempSync(path.join(os.tmpdir(), "typespec-assessment-server-"));
  context.after(() => fs.rmSync(work, { recursive: true, force: true }));
  const report = path.join(work, "assessment.html");
  fs.writeFileSync(report, "<!doctype html><title>Assessment</title>");

  const { server, url } = await serveAssessment(report);
  context.after(() => server.close());

  assert.match(url, /^http:\/\/127\.0\.0\.1:\d+\/assessment\.html$/);
  const response = await fetch(url);
  assert.equal(response.status, 200);
  assert.equal(await response.text(), "<!doctype html><title>Assessment</title>");

  const missingResponse = await fetch(new URL("/other.html", url));
  assert.equal(missingResponse.status, 404);
});

void test("rejects a missing assessment report", async () => {
  await assert.rejects(
    serveAssessment(path.join(os.tmpdir(), "missing-assessment-report.html")),
    /Assessment report does not exist/,
  );
});
