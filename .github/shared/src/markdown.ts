/** A document made of trusted Markdown blocks, nested sections, and optional content. */
export type MarkdownDoc = string | MarkdownSection | MarkdownDoc[] | undefined;

/** A heading whose level is determined by its position in the document. */
export interface MarkdownSection {
  kind: "section";
  title: string;
  body: MarkdownDoc;
}

/** Groups trusted inline Markdown and body blocks under a heading. */
export function section(title: string, body: MarkdownDoc): MarkdownSection {
  return { kind: "section", title, body };
}

/** Renders document blocks with blank lines between them, omitting empty or absent blocks. */
export function renderMarkdownDoc(doc: MarkdownDoc, heading = 1): string {
  const blocks: string[] = [];

  /** Flattens content while keeping nested heading levels local to each section. */
  function render(content: MarkdownDoc, level: number): void {
    if (content === undefined || content === "") return;
    if (typeof content === "string") {
      blocks.push(content);
    } else if (Array.isArray(content)) {
      for (const child of content) render(child, level);
    } else {
      if (!Number.isInteger(level) || level < 1 || level > 6) {
        throw new Error("Markdown headings must have a level from 1 to 6");
      }
      blocks.push(`${"#".repeat(level)} ${content.title}`);
      render(content.body, level + 1);
    }
  }

  render(doc, heading);
  return blocks.join("\n\n");
}

/** Escapes plain text for an HTML element's text content, not an attribute. */
function escapeHtml(value: string): string {
  return value.replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;");
}

/** Escapes untrusted single-line text, including HTML, Markdown, table pipes and mentions. */
export function escapeMarkdown(value: string): string {
  return escapeHtml(value)
    .replaceAll("|", "&#124;")
    .replaceAll("@", "&#64;")
    .replaceAll("`", "&#96;")
    .replace(/[\\[\]()*_~]/g, "\\$&")
    .replace(/[\r\n]/g, " ");
}

/** Wraps nonempty text in an inline code span, preserving embedded backticks and edge spaces. */
export function inlineCode(code: string): string {
  if (!code) throw new Error("Inline code requires nonempty text");
  const content = code.replace(/\r\n?|\n/g, " ");
  let length = 1;
  for (const match of content.matchAll(/`+/g)) length = Math.max(length, match[0].length + 1);
  const delimiter = "`".repeat(length);
  const padding =
    content.startsWith("`") ||
    content.endsWith("`") ||
    (content.startsWith(" ") && content.endsWith(" ") && content.trim() !== "")
      ? " "
      : "";
  return `${delimiter}${padding}${content}${padding}${delimiter}`;
}

/** Links trusted inline Markdown to a trusted URL; escape untrusted labels with escapeMarkdown. */
export function link(label: string, url: string): string {
  return `[${label}](${url})`;
}

/** Escapes table delimiters without changing existing pipe escapes or other trusted Markdown. */
function escapeTableCell(value: string): string {
  return value
    .replace(/(\\*)\|/g, (match: string, slashes: string) =>
      slashes.length % 2 === 0 ? `${slashes}\\|` : match,
    )
    .replace(/\r\n?|\n/g, "<br />");
}

/** Renders a GFM table with a header row; cells accept trusted Markdown and must have equal widths. */
export function table([header, ...rows]: readonly (readonly string[])[]): string {
  if (!header || header.length === 0 || rows.some((row) => row.length !== header.length)) {
    throw new Error("Markdown tables require a nonempty header and equal column counts");
  }

  /** Renders one row without letting its contents introduce additional cells. */
  function renderRow(row: readonly string[]): string {
    return `| ${row.map(escapeTableCell).join(" | ")} |`;
  }

  return [renderRow(header), renderRow(header.map(() => "---")), ...rows.map(renderRow)].join("\n");
}

/** Renders trusted Markdown list items, indenting continuation lines inside each item. */
export function unorderedList(items: readonly string[]): string {
  return items.map((item) => `- ${item.replace(/\r\n?|\n/g, "\n  ")}`).join("\n");
}

/** Wraps a Markdown block in a GitHub details element with a plain-text summary. */
export function details(summary: string, body: string): string {
  return [
    `<details><summary>${escapeHtml(summary)}</summary>`,
    "",
    ...(body ? [body] : []),
    "",
    "</details>",
  ].join("\n");
}
