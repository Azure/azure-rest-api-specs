import { resolve } from "path";
import { simpleGit } from "simple-git";

export async function getRootFolder(inputPath: string): Promise<string> {
  // expecting users to handle the case where inputPath is not a git repo
  const gitRoot = await simpleGit(inputPath).revparse("--show-toplevel");
  return resolve(gitRoot.trim());
}
