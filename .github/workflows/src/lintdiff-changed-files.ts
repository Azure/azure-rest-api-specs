import { writeFile } from "node:fs/promises";
import { join } from "node:path";
import { getChangedFiles } from "../../shared/src/changed-files.ts";

export async function writeLintdiffChangedFiles() {
  const changedFiles = await getChangedFiles({ cwd: "after", paths: ["specification"] });
  console.log("Changed files:", changedFiles);
  const filePath = join(process.cwd(), "changed-files.txt");
  await writeFile(filePath, changedFiles.join("\n"), "utf8");
  console.log(`Changed files written to ${filePath}`);
}
