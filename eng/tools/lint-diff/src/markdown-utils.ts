import { Readme } from "@azure-tools/specs-shared/readme";
import axios from "axios";
import { kebabCase } from "change-case";
import { marked } from "marked";

export enum MarkdownType {
  Arm = "arm",
  DataPlane = "data-plane",
  Default = "default",
}

/**
 *
 * @param readme Readme object to extract
 * @returns {Promise<MarkdownType>} The type of OpenAPI spec in the markdown file, or "default" if not found
 */
// TODO: Should this be placed in the Readme class?
export async function getOpenapiType(readme: Readme): Promise<MarkdownType> {
  const openapiType = ((await readme.getGlobalConfig()) as { "openapi-type"?: string })[
    "openapi-type"
  ];
  if (openapiType && Object.values(MarkdownType).includes(openapiType as MarkdownType)) {
    return openapiType as MarkdownType;
  }

  // Fallback, no openapi-type found in the file. Look at path to determine type
  // resource-manager: Arm
  // data-plane: DataPlane
  if (readme.path.match(/.*specification\/.*\/resource-manager\/.*readme.md$/g)) {
    return MarkdownType.Arm;
  } else if (readme.path.match(/.*specification\/.*\/data-plane\/.*readme.md$/g)) {
    return MarkdownType.DataPlane;
  }

  // No type was found, return Default
  return MarkdownType.Default;
}

type TagInputFile = { tagName: string; inputFiles: readonly string[] };

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

export function getDocRawUrl(code: string) {
  if (code == "FATAL") {
    return `N/A`;
  }

  return `https://raw.githubusercontent.com/Azure/azure-openapi-validator/main/docs/${kebabCase(
    code,
  )}.md`;
}

const rpcInfoCache = new Map<string, string[]>();

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

  // Use marked to parse the markdown and extract the related ARM guideline codes
  const tokens = marked.lexer(response.data);
  for (let i = 0; i < tokens.length; i++) {
    const token = tokens[i];
    if (
      token.type === "heading" &&
      token.depth >= 1 &&
      token.text.trim().toLowerCase() === "related arm guideline code"
    ) {
      // The next token should be a list
      const next = tokens[i + 1];
      if (next && next.type === "list" && Array.isArray(next.items)) {
        for (const item of next.items) {
          // item.text may contain comma-separated codes
          if (typeof item.text === "string") {
            rpcRules.push(...item.text.split(",").map((c: string) => c.trim()));
          }
        }
      }
      break;
    }
  }

  rpcInfoCache.set(ruleName, rpcRules);
  return rpcRules;
}

export async function getDefaultTag(readme: Readme): Promise<string> {
  const tag = ((await readme.getGlobalConfig()) as { tag?: string }).tag;
  return tag ? tag : "";
}
