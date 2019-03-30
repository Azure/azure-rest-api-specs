import * as fs from "@ts-common/fs"
import * as process from "process"
import * as path from "path"
import * as cm from "@ts-common/commonmark-to-markdown"
import * as it from "@ts-common/iterator"
import * as yaml from "js-yaml"

type Code = {
  readonly "input-file"?: ReadonlyArray<string>|string
}

const main = async (dir: string) => {
  try {
    const list = fs.recursiveReaddir(dir);
    const specs = [];
    for await (const file of list) {
      const f = path.parse(file);
      if (f.base === "readme.md") {
        // console.log(`processing ${file}`)
        const content = (await fs.readFile(file)).toString();
        const readMe = cm.parse(content);
        const set = new Set<string>();
        for (const c of cm.iterate(readMe.markDown)) {
          if (
            c.type === "code_block" &&
            c.info !== null &&
            c.info.startsWith("yaml") &&
            c.literal !== null
          ) {
            const y = (yaml.load(c.literal) as Code)["input-file"];
            if (typeof y === "string") {
              set.add(y);
            } else if (it.isArray(y)) {
              for (const i of y) {
                set.add(i);
                specs.push(path.join(f.dir, i));
              }
            }
          }
        }
        const readMeMulti = cm.createNode(
          "document",
          cm.createNode(
            "heading",
            cm.createText("Multi-API support for AutoRest v3 generators")
          ),
          cm.createNode(
            "block_quote",
            cm.createNode(
              "paragraph",
              cm.createText("see https://aka.ms/autorest")
            )
          ),
          cm.createCodeBlock(
            "yaml $(enable-multi-api)",
            yaml.dump({ "input-file": it.toArray(set) }, { lineWidth: 1000 })
          )
        )
        const x = cm.markDownExToString({ markDown: readMeMulti });
        fs.writeFile(path.join(f.dir, "readme.enable-multi-api.md"), x);
      }     
    }

    const allPaths = await getPaths(specs);
    // const profileData = getProfileData(allPaths);

    fs.writeFile('c:/work/paths.json', JSON.stringify(allPaths, null, 2));
  } catch (e) {
    console.error(e);
  }
}

async function getPaths(specHandles: Array<string>): Promise<Array<PathData>> {
  const result = new Array<PathData>();
  for (const specHandle of specHandles) {
    try {
      const spec = JSON.parse((await fs.readFile(specHandle)).toString());
      if (spec.swagger && spec.info.version) {
        for (const path of Object.entries(spec.paths)) {
          result.push({path: path[0], apiVersion: spec.info.version});
        }   
      }
    }  catch (e) {
      console.error(`Couldn't parse file ${specHandle}`);
    }          
  }

  return result;   
}

interface PathData {
  path: string;
  apiVersion: string;
}

// function getProfileData(paths: Array<string>): ProfileData {
//   const result = { profile: new Array<string>(), validPaths: new Array<string>(), invalidPaths: new Array<string>()};
//   const regex = new RegExp(`(?:\/providers\/microsoft\.[a-z]+(?:\.[a-z]+)?)((?:\/[a-z0-9]+)|(?:\/\{[a-z0-9]+\}))+\/?$`, 'gi');
//   let i = 0;
//   for (const path of  paths) {    
//     const providerScope = path.match(regex);
//     if (providerScope === null){
//       result.invalidPaths.push(path);
//     } else {
//       result.validPaths.push(path);
//     }    

//     console.log(i++);
//   }

//   for ()

//   return result;
// }

// interface ProfileData {
//   invalidPaths: Array<string>;
//   validPaths: Array<string>;
//   profile: Array<string>;
// }

main(path.join(process.cwd(), "specification"));
