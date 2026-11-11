import { escapeHtml } from "../../../shared/src/markdown.ts";

/** Uses picture to prevent GitHub from adding an automatic image-preview link. */
export function labelBadge(name: string): string {
  const url = `https://img.shields.io/github/labels/Azure/azure-rest-api-specs/${encodeURIComponent(name)}`;
  const alt = escapeHtml(name).replaceAll('"', "&quot;").replaceAll("|", "&#124;");
  return `<picture><img src="${url}" alt="${alt}"></picture>`;
}
