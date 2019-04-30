import * as fs from "@ts-common/fs"
import * as process from "process"
import * as path from "path"
import * as cm from "@ts-common/commonmark-to-markdown"
import * as it from "@ts-common/iterator"
import * as yaml from "js-yaml"

type Code = {
  readonly "input-file"?: ReadonlyArray<string>|string
}

const main = async (specificationDir: string, profilesDir: string) => {
  try {
    const list = fs.recursiveReaddir(specificationDir)
    for await (const file of list) {
      const f = path.parse(file)
      if (f.base === "readme.md") {
        console.log(`processing ${file}`)
        const content = (await fs.readFile(file)).toString()
        const readMe = cm.parse(content)
        const set = new Set<string>()
        for (const c of cm.iterate(readMe.markDown)) {
          if (
            c.type === "code_block" &&
            c.info !== null &&
            c.info.startsWith("yaml") &&
            c.literal !== null
          ) {
            const y = (yaml.load(c.literal) as Code)["input-file"]
            if (typeof y === "string") {
              set.add(`$(this-folder)/${y}`)
            } else if (it.isArray(y)) {
              for (const i of y) {
                set.add(`$(this-folder)/${i}`)
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
            "yaml",
            yaml.dump({ "input-file": it.toArray(set), "require": `$(this-folder)/${path.relative(f.dir, profilesDir).replace(/\\/g, '/')}/readme.md` }, { lineWidth: 1000 })
          )
        )
        const x = cm.markDownExToString({ markDown: readMeMulti })
        fs.writeFile(path.join(f.dir, "readme.enable-multi-api.md"), x)
      }
    }
  } catch (e) {
    console.error(e)
  }
}

main(path.join(process.cwd(), "specification"), path.join(process.cwd(), "profiles"))
