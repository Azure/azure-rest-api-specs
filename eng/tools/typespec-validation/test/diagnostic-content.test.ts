import { d } from "@azure-tools/specs-shared/testing";
import { stripVTControlCharacters } from "node:util";
import { describe, expect, it } from "vitest";
import {
  blocks,
  filePath,
  indent,
  lines,
  renderDiagnosticContent,
  text,
  verbatim,
} from "../src/diagnostic-content.ts";

describe("diagnostic content", () => {
  it("composes nested inline text, numbers and styled paths without coloring surrounding text", () => {
    const file = text`${filePath("/repo/service/config.yaml")}:${2}`;
    const content = text`Found ${0} valid options in ${file}.`;
    const plain = renderDiagnosticContent(content, { cwd: "/repo" });
    const colored = renderDiagnosticContent(content, { cwd: "/repo", color: true });
    expect(plain).toBe("Found 0 valid options in service/config.yaml:2.");
    expect(colored).toBe("Found 0 valid options in \x1b[36mservice/config.yaml\x1b[39m:2.");
    expect(stripVTControlCharacters(colored)).toBe(plain);
  });

  it("lets the caller arrange paragraphs, lines and indentation in any order", () => {
    const content = blocks(
      verbatim("Native output first"),
      indent(
        lines([
          text`Version ${"2026-01-01"}: ${filePath("generated.json")}`,
          "",
          indent("Nested explanation"),
        ]),
      ),
      "Fix guidance last",
    );
    expect(renderDiagnosticContent(content)).toBe(d`
      Native output first

        Version 2026-01-01: generated.json

          Nested explanation

      Fix guidance last
    `);
  });

  it("omits empty blocks without creating phantom paragraphs", () => {
    const empty = blocks("", lines([]), indent(lines([])), verbatim(""));
    expect(renderDiagnosticContent(empty)).toBe("");
    expect(renderDiagnosticContent(blocks(empty, "first", empty, "second", empty))).toBe(
      "first\n\nsecond",
    );
  });

  it("preserves native ANSI colors, whitespace and line endings, stripping only controls for plain output", () => {
    const native = "\x1b[31m- old  \x1b[m\r\n\x1b[32m+ new\t\x1b[m\r\n\r\n";
    expect(renderDiagnosticContent(verbatim(native), { color: true })).toBe(native);
    expect(renderDiagnosticContent(verbatim(native))).toBe("- old  \r\n+ new\t\r\n\r\n");
  });

  it("indents multiline content without inserting spaces on blank lines", () => {
    const content = indent(verbatim("first\r\n\r\nlast\r\n"));
    expect(renderDiagnosticContent(content)).toBe("  first\r\n\r\n  last\r\n");
  });

  it.each([
    ["/repo/service/file.json", "/repo", "service/file.json"],
    ["C:\\repo\\service\\file.json", "C:\\repo", "service/file.json"],
    ["..\\shared\\file.json", "C:\\repo", "../shared/file.json"],
    ["/repo", "/repo", "."],
  ])("renders path %s relative to %s", (path, cwd, expected) => {
    expect(renderDiagnosticContent(filePath(path), { cwd })).toBe(expected);
  });
});
