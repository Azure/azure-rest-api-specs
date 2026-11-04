import { escapeMarkdown, link } from "../../../shared/src/markdown.ts";

/** Renders a linked badge for a label in the public specs repository. */
export function labelBadge(name: string): string {
  const encodedName = encodeURIComponent(name);
  return link(
    `![${escapeMarkdown(name)}](https://img.shields.io/github/labels/Azure/azure-rest-api-specs/${encodedName})`,
    `https://github.com/Azure/azure-rest-api-specs/labels/${encodedName}`,
  );
}
