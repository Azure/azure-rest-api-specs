import { marked } from "marked";
import { describe, expect, it } from "vitest";
import {
  details,
  escapeMarkdown,
  inlineCode,
  link,
  renderMarkdownDoc,
  section,
  table,
  unorderedList,
} from "../src/markdown.ts";

describe("Markdown composition", () => {
  it("composes optional blocks and nested sections without leaking heading depth", () => {
    expect(
      renderMarkdownDoc([
        "Introduction",
        "",
        undefined,
        [],
        section("First", ["Body", section("Nested", "Details")]),
        section("Second", "Last"),
      ]),
    ).toBe(
      ["Introduction", "# First", "Body", "## Nested", "Details", "# Second", "Last"].join("\n\n"),
    );
  });

  it("supports an explicit starting heading and empty documents", () => {
    expect(renderMarkdownDoc(section("Title", undefined), 2)).toBe("## Title");
    expect(renderMarkdownDoc([])).toBe("");
    expect(renderMarkdownDoc(undefined)).toBe("");
    expect(renderMarkdownDoc(section("Title", "Body"), 6)).toBe("###### Title\n\nBody");
  });

  it.each([0, -1, 1.5, 7])("rejects invalid heading level %s", (level) => {
    expect(() => renderMarkdownDoc(section("Title", ""), level)).toThrow("level from 1 to 6");
  });

  it("rejects nested headings beyond level six", () => {
    expect(() => renderMarkdownDoc(section("Parent", section("Child", "")), 6)).toThrow(
      "level from 1 to 6",
    );
  });

  it("escapes external text rather than turning it into markup or mentions", () => {
    const text = escapeMarkdown(
      "@team | <b>& `code` [link](url) *bold* _italic_ ~strike~\\\r\nnext",
    );
    expect(text).toBe(
      "&#64;team &#124; &lt;b&gt;&amp; &#96;code&#96; \\[link\\]\\(url\\) \\*bold\\* \\_italic\\_ \\~strike\\~\\\\  next",
    );
    expect(marked.parseInline(text)).not.toContain("<b>");
    expect(marked.parseInline(text)).not.toContain("<a ");
  });
});

describe("inline Markdown", () => {
  it("creates an ordinary code span and trusted link", () => {
    expect(inlineCode("command")).toBe("`command`");
    expect(link("Documentation", "https://example.com/docs")).toBe(
      "[Documentation](https://example.com/docs)",
    );
  });

  it.each([
    ["a`b", "a`b"],
    ["`leading", "`leading"],
    ["trailing`", "trailing`"],
    ["``", "``"],
    ["`both`", "`both`"],
    [" padded ", " padded "],
    [" leading", " leading"],
    ["trailing ", "trailing "],
    [" ", " "],
    ["first\r\nsecond\rthird\nfourth", "first second third fourth"],
    ["<value>&", "&lt;value&gt;&amp;"],
  ])("preserves code text %j", (code, expected) => {
    expect(marked.parseInline(inlineCode(code))).toBe(`<code>${expected}</code>`);
  });

  it("rejects an empty code span instead of emitting ambiguous backticks", () => {
    expect(() => inlineCode("")).toThrow("nonempty text");
  });
});

describe("tables, lists and details", () => {
  it("renders a header-only or populated table with stable columns", () => {
    expect(table([["Header"]])).toBe("| Header |\n| --- |");
    expect(
      table([
        ["First", "Second"],
        ["one", "two"],
      ]),
    ).toBe("| First | Second |\n| --- | --- |\n| one | two |");
  });

  it("escapes pipes and line breaks without breaking inline code or existing escapes", () => {
    const value = table([
      ["First|column", "Second\ncolumn"],
      [inlineCode("a|b"), "first\r\nsecond\rthird\nfourth"],
      ["\\|", "\\\\|"],
    ]);
    expect(value).toContain("| First\\|column | Second<br />column |");
    expect(value).toContain("| \\| | \\\\\\| |");
    const html = marked.parse(value);
    expect(html).toContain("<td><code>a|b</code></td>");
    expect(html).toContain("first<br />second<br />third<br />fourth");
  });

  it.each([{ rows: [] }, { rows: [[]] }, { rows: [["One"], ["Two", "Three"]] }])(
    "rejects invalid table rows %j",
    ({ rows }) => {
      expect(() => table(rows)).toThrow("nonempty header and equal column counts");
    },
  );

  it("renders lists and indents continuation lines", () => {
    expect(unorderedList(["one", "two\ncontinued\r\nagain"])).toBe(
      "- one\n- two\n  continued\n  again",
    );
    expect(unorderedList([])).toBe("");
  });

  it("renders collapsible content with an HTML-escaped plain-text summary", () => {
    expect(details("<Members> & reviewers", unorderedList(["one"]))).toBe(
      "<details><summary>&lt;Members&gt; &amp; reviewers</summary>\n\n- one\n\n</details>",
    );
    expect(details("Empty", "")).toBe("<details><summary>Empty</summary>\n\n\n</details>");
  });
});
