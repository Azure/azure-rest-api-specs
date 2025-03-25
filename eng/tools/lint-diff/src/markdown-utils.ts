import * as commonmark from "commonmark";
import { readFile } from "fs/promises";

// TODO: Can this be eliminated?
import { parseMarkdown } from "@azure-tools/openapi-tools-common";
// TODO: Can this be eliminated?
import * as amd from "@azure/openapi-markdown";
import { kebabCase } from "change-case";
import axios from "axios";
import * as YAML from "js-yaml";

export enum MarkdownType {
  Arm = "arm",
  DataPlane = "data-plane",
  Default = "default",
}

/**
 *
 * @param markdownFile Path to the markdown file to parse
 * @returns {Promise<MarkdownType>} The type of OpenAPI spec in the markdown file, or "default" if not found
 */
export async function getOpenapiType(markdownFile: string): Promise<MarkdownType> {
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

    for (const line of lines) {
      if (line.trim().startsWith("openapi-type:")) {
        let openapiType = line.trim().split(":")[1].trim().toLowerCase();

        if (Object.values(MarkdownType).includes(openapiType as MarkdownType)) {
          return openapiType as MarkdownType;
        }
      }
    }
  }

  // Fallback, no openapi-type found in the file. Look at path to determine type
  // resource-manager: Arm
  // data-plane: DataPlane
  if (markdownFile.match(/.*specification\/.*\/resource-manager\/.*readme.md$/g)) {
    return MarkdownType.Arm;
  } else if (markdownFile.match(/.*specification\/.*\/data-plane\/.*readme.md$/g)) {
    return MarkdownType.DataPlane;
  }

  // No type was found, return Default
  return MarkdownType.Default;
}

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

type TagInputFile = { tagName: string; inputFiles: readonly string[] };

export function getTagsAndInputFiles(tags: string[], readmeContent: string): TagInputFile[] {
  const tagResults: TagInputFile[] = [];
  for (const tag of tags) {
    const inputFiles = getInputFiles(readmeContent, tag);
    if (inputFiles.length > 0) {
      tagResults.push({ tagName: tag, inputFiles });
    }
  }
  return tagResults;
}

/**
 * Given a list of tags and the content of a readme file, remove tags that are
 * subsets of other tags (reduces number of times autorest is called).
 *
 * @param tags
 * @param readmeContent
 * @returns
 */
export function deduplicateTags(tagInfo: TagInputFile[]) {
  // TODO: This was ported straight across and can probably be done more cleanly
  const sortedTags = tagInfo.sort((a, b) => a.inputFiles.length - b.inputFiles.length);
  return sortedTags
    .filter((tag, index) => {
      for (const restTag of sortedTags.slice(index + 1)) {
        if (tag.inputFiles.every((file) => restTag.inputFiles.includes(file))) {
          return false;
        }
      }
      return true;
    })
    .map((tag) => tag.tagName);
}

export function getInputFiles(readMeContent: string, tag: string): readonly string[] {
  const cmd = parseMarkdown(readMeContent);
  const inputFiles = amd.getInputFilesForTag(cmd.markDown, tag);
  return inputFiles || [];
}

export function getDocRawUrl(code: string) {
  if (code == "FATAL") {
    return `N/A`;
  }

  return `https://raw.githubusercontent.com/Azure/azure-openapi-validator/main/docs/${kebabCase(
    code,
  )}.md`;
}

const rpcInfoCache = new Map<string, string[]>();

// TODO: Tests
export async function getRelatedArmRpcFromDoc(ruleName: string): Promise<string[]> {
  if (ruleName == "FATAL") {
    return [];
  }

  if (rpcInfoCache.has(ruleName)) {
    return rpcInfoCache.get(ruleName)!;
  }
  const docUrl = getDocRawUrl(ruleName);
  const rpcRules: string[] = [];
  let response;
  try {
    response = await axios.get(docUrl);
  } catch (e: any) {
    // TODO: Retry? Fail ungracefully?
    console.log(`GET ${docUrl} failed with ${e.message} .`);
    rpcInfoCache.set(ruleName, rpcRules);
    return rpcRules;
  }

  let walker = new commonmark.Parser().parse(response.data).walker();
  let event;
  while ((event = walker.next())) {
    const node = event.node;
    if (
      event.entering &&
      node.type === "heading" &&
      node.firstChild?.literal?.toLowerCase() === "related arm guideline code"
    ) {
      const next = node.next;
      if (next?.type == "list") {
        let currentItem = next.firstChild;
        while (currentItem) {
          const code = currentItem?.firstChild?.firstChild?.literal;
          if (code) {
            rpcRules.push(...code.split(",").map((c) => c.trim()));
          }
          currentItem = currentItem.next;
        }
      }
      break;
    }
  }
  rpcInfoCache.set(ruleName, rpcRules);
  return rpcRules;
}

export function getDefaultTag(markdownContent: string): string {
  const parsed = parseMarkdown(markdownContent);
  const startNode = parsed.markDown;
  const codeBlockMap = amd.getCodeBlocksAndHeadings(startNode);

  const latestHeader = "Basic Information";

  const lh = codeBlockMap[latestHeader];
  if (lh) {
    const latestDefinition = YAML.load(lh.literal!) as undefined | { tag: string };
    if (latestDefinition) {
      return latestDefinition.tag;
    }
  } else {
    for (let idx of Object.keys(codeBlockMap)) {
      const lh = codeBlockMap[idx];
      if (!lh || !lh.info || lh.info.trim().toLocaleLowerCase() !== "yaml") {
        continue;
      }
      const latestDefinition = YAML.load(lh.literal!) as undefined | { tag: string };

      if (latestDefinition) {
        return latestDefinition.tag;
      }
    }
  }
  return "";
}
