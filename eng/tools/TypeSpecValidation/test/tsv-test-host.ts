import { TsvHost } from "../src/tsv-host.js";

export function TsvTestHostGenerator(fnReturnSub: { [key: string]: Object }) {
  let tsvTestHost = Object.assign({}, DefaultTsvTestHost); // Needs deep copy
  for (let key in fnReturnSub) {
    let typedKey = key as keyof TsvHost;
    if (fnReturnSub[typedKey]) {
      tsvTestHost = {
        ...tsvTestHost,
        [typedKey]: () => {
          return fnReturnSub[typedKey];
        },
      };
    } else {
      tsvTestHost = {
        ...tsvTestHost,
        [typedKey]: () => {},
      };
    }
  }
  return tsvTestHost;
}

export const DefaultTsvTestHost: TsvHost = {
  gitOperation: (folder: string) => {
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
  },

  runCmd: async (cmd: string, cwd: string) => {
    let err = null;
    let stdout = `default ${cmd} at ${cwd}`;
    let stderr = "";

    return [err, stdout, stderr];
  },

  checkFileExists: async (file: string) => {
    console.log(`file ${file} exists`);
    return true;
  },
  // TODO: Other functions that need mocks
};
