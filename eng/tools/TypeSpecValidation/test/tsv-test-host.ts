import { IGitOperation, TsvHost } from "../src/tsv-host.js";

export class TsvTestHost implements TsvHost {
  static get folder() {
    return "specification/foo/Foo";
  }

  gitOperation(folder: string): IGitOperation {
    return {
      status: () => {
        return Promise.resolve({
          modified: [`${folder}\n`],
          isClean: () => {
            return false;
          },
        });
      },
      diff: () => {
        return Promise.resolve("diff");
      },
      revparse: () => {
        return Promise.resolve("");
      },
    };
  }

  async runCmd(cmd: string, cwd: string): Promise<[Error | null, string, string]> {
    let err = null;
    let stdout = `default ${cmd} at ${cwd}`;
    let stderr = "";

    return [err, stdout, stderr];
  }

  async checkFileExists(file: string): Promise<boolean> {
    console.log(`file ${file} exists`);
    return true;
  }
}
