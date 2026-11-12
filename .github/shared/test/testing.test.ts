import { d } from "@azure-tools/specs-shared/testing";
import { describe, expect, it } from "vitest";

describe("d", () => {
  it("removes surrounding newlines and the template's indentation", () => {
    expect(d`
      first
      second
    `).toBe("first\nsecond");
  });

  it("preserves nested indentation and interior blank lines", () => {
    expect(d`
      first
        nested

      last
    `).toBe("first\n  nested\n\nlast");
  });

  it("handles empty and single-line templates", () => {
    expect(d``).toBe("");
    expect(d`
    `).toBe("");
    expect(d`single line`).toBe("single line");
    expect(d`  indented`).toBe("indented");
  });

  it("leaves unindented text unchanged", () => {
    expect(d`first
  nested
last`).toBe("first\n  nested\nlast");
  });

  it("supports tab indentation", () => {
    expect(d`\n\tfirst\n\t\tnested\n\tlast\n`).toBe("first\n\tnested\nlast");
  });

  it("only removes the first line's exact indentation prefix", () => {
    expect(d`\n    first\n  less indented\n\tother prefix\n    last\n`).toBe(
      "first\n  less indented\n\tother prefix\nlast",
    );
  });

  it("preserves trailing content whitespace and additional blank lines", () => {
    expect(d`\n  first  \n\n  last\t\n\n  `).toBe("first  \n\nlast\t\n");
  });

  it("includes interpolated values without dropping zero or false", () => {
    expect(d`
      ${"value"}: ${42}
      ${0} ${false} ${null}${undefined}${""}end
    `).toBe("value: 42\n0 false end");
  });

  it("dedents multiline values along with the rest of the template", () => {
    const value = "first\n        nested\n      last";
    expect(d`
      ${value}
      end
    `).toBe("first\n  nested\nlast\nend");
  });

  it("uses string coercion for interpolated objects", () => {
    const value = { toString: () => "formatted" };
    expect(d`value: ${value}`).toBe("value: formatted");
  });
});
