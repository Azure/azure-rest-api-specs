import * as commonmark from "commonmark";
import { readFile } from "fs/promises";

// TODO: Can this be eliminated?
import { parseMarkdown } from "@azure-tools/openapi-tools-common";
// TODO: Can this be eliminated?
import * as amd from "@azure/openapi-markdown";

export type MarkdownType = "arm" | "data-plane" | "default";

/**
 *
 * @param markdownFile Path to the markdown file to parse
 * @returns {Promise<MarkdownType>} The type of OpenAPI spec in the markdown file, or "default" if not found
 */
export const getOpenapiType = async function (markdownFile: string): Promise<MarkdownType> {
  let markdownContent = await readFile(markdownFile, { encoding: "utf-8" });
  for (const codeBlock of parseCodeblocks(markdownContent)) {
    if (
      !codeBlock.info ||
      codeBlock.info.trim().toLocaleLowerCase() !== "yaml" ||
      !codeBlock.literal
    ) {
      continue;
    }

    let lines = codeBlock.literal.trim().split("\n");
    if (!lines) {
      continue;
    }

    for (const line of lines) {
      if (line.trim().startsWith("openapi-type:")) {
        let openapiType = line.trim().split(":")[1].trim().toLowerCase();

        // Try to convert to MarkdownType enum and return result. If conversion
        // fails, keep looking for another openapi-type
        try {
          return openapiType as MarkdownType;
        } catch (e) {
          continue;
        }
      }
    }
  }

  // Fallback, no openapi-type found in the file. Look at path to determine type
  // resource-manager: "arm"
  // data-plane: "data-plane"
  if (markdownFile.match(/.*specification\/.*\/resource-manager\/.*readme.md$/g)) {
    return "arm";
  } else if (markdownFile.match(/.*specification\/.*\/data-plane\/.*readme.md$/g)) {
    return "data-plane";
  }

  // No type was found, return "default"
  return "default";
};

// TODO: Direct copy/paste from utils, factor appropriately
function* parseCodeblocks(markdown: string): Iterable<commonmark.Node> {
  const parsed = parseCommonmark(markdown);
  const walker = parsed.walker();
  let event;
  while ((event = walker.next())) {
    const node = event.node;
    if (event.entering && node.type === "code_block") {
      yield node;
    }
  }
}

// TODO: Direct copy/paste from utils, factor appropriately
function parseCommonmark(markdown: string): commonmark.Node {
  return new commonmark.Parser().parse(markdown);
}

/**
 * Returns all tags from the given readme document
 * @param readMeContent
 * @returns
 */
export function getAllTags(readMeContent: string): string[] {
  const cmd = parseMarkdown(readMeContent);
  const allTags = new amd.ReadMeManipulator(
    { error: (_msg: string) => {} },
    new amd.ReadMeBuilder(),
  ).getAllTags(cmd);
  return [...allTags];
}

export async function getInputFiles(readMeContent: string, tag: string) {
  const cmd = parseMarkdown(readMeContent);
  return amd.getInputFilesForTag(cmd.markDown, tag);
}
