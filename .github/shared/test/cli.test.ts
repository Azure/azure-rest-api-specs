import { afterEach, describe, expect, expectTypeOf, it, vi } from "vitest";
import { parseArgsWithHelp, type CliOption } from "../src/cli.ts";

afterEach(() => {
  vi.restoreAllMocks();
});

describe("parseArgsWithHelp", () => {
  it.each(["--help", "-h"])("automatically handles %s without command options", (flag) => {
    const log = vi.spyOn(console, "log").mockImplementation(() => {});
    const exit = vi.spyOn(process, "exit").mockImplementation(() => {
      throw new Error("Help must not terminate the process");
    });

    expect(parseArgsWithHelp({ args: [flag], help: { command: "example" } })).toBeUndefined();
    expect(log).toHaveBeenCalledExactlyOnceWith(
      expect.stringMatching(
        /^example\n\nUsage:\n\s+example \[options\]\n\nOptions:\n\s+-h, --help\s+Show help and exit\.$/,
      ),
    );
    expect(exit).not.toHaveBeenCalled();
  });

  it("renders option definitions, aliases, value labels, groups and multiline descriptions", () => {
    const log = vi.spyOn(console, "log").mockImplementation(() => {});
    const options = {
      verbose: { type: "boolean", short: "v", description: "Show details." },
      base: {
        type: "string",
        valueLabel: "<commit>",
        group: "Revisions",
        description: "Base revision.",
      },
      output: { type: "string", description: "Output path." },
      "long-option-with-a-value": {
        type: "string",
        valueLabel: "<path>",
        group: "Revisions",
        description: "First line.\nSecond line.",
      },
    } satisfies Record<string, CliOption>;

    expect(
      parseArgsWithHelp({
        args: ["--help"],
        options,
        help: { command: "example" },
      }),
    ).toBeUndefined();

    const output = String(log.mock.calls[0][0]);
    expect(output).toMatch(/-v, --verbose\s+Show details\./);
    expect(output).toMatch(/--output <value>\s+Output path\./);
    expect(output).toMatch(/Revisions:\n\s+--base <commit>\s+Base revision\./);
    expect(output).toMatch(/--long-option-with-a-value <path>\n\s+First line\.\n\s+Second line\./);
    expect(output.match(/Revisions:/g)).toHaveLength(1);
    expect(options).not.toHaveProperty("help");
  });

  it("generates usage, argument descriptions and supporting sections from metadata", () => {
    const log = vi.spyOn(console, "log").mockImplementation(() => {});
    parseArgsWithHelp({
      args: ["--help"],
      options: {
        all: {
          type: "boolean",
          description: "Process all files.",
        },
      },
      help: {
        command: "pnpm example",
        title: "Example tool",
        description: "Process files.",
        positionals: [
          { name: "file", description: "Input file." },
          { name: "context", optional: true, description: "JSON context." },
        ],
        examples: ["input.json", "--all", ""],
        notes: ["Run from the repository root."],
        documentation: "https://example.com/docs",
      },
    });
    const output = String(log.mock.calls[0][0]);
    expect(output).toContain("Example tool\nProcess files.");
    expect(output).toContain("Usage:\n  pnpm example <file> [context] [options]");
    expect(output).toMatch(/Arguments:\n\s+<file>\s+Input file\.\n\s+\[context\]\s+JSON context\./);
    expect(output).toContain("Notes:\n  Run from the repository root.");
    expect(output).toContain(
      "Examples:\n  pnpm example input.json\n  pnpm example --all\n  pnpm example\n",
    );
    expect(output).toContain("Documentation: https://example.com/docs");
  });

  it("omits empty optional sections", () => {
    const log = vi.spyOn(console, "log").mockImplementation(() => {});
    parseArgsWithHelp({
      args: ["--help"],
      options: {},
      help: {
        command: "example",
        description: "",
        positionals: [],
        examples: [],
        notes: [],
        documentation: "",
      },
    });
    const output = String(log.mock.calls[0][0]);
    expect(output).toContain("Usage:\n  example [options]");
    expect(output).not.toMatch(/Arguments:|Examples:|Notes:|Documentation:/);
  });

  it("wraps descriptions and notes without requiring manually formatted text", () => {
    const log = vi.spyOn(console, "log").mockImplementation(() => {});
    const description = "Use this option to select the output location for the generated files. "
      .repeat(3)
      .trim();
    const note = "Always retain a copy of the original files before modifying them. "
      .repeat(3)
      .trim();
    parseArgsWithHelp({
      args: ["--help"],
      options: { output: { type: "string", description: `${description}\n\nNext paragraph.` } },
      help: { command: "example", notes: [note] },
    });
    const output = String(log.mock.calls[0][0]);
    expect(output.split("\n").every((line) => line.length <= 80)).toBe(true);
    expect(output.replace(/\s+/g, " ")).toContain(description);
    expect(output.replace(/\s+/g, " ")).toContain(note);
    expect(output).toMatch(/\n\s*\n\s+Next paragraph\./);
  });

  it("preserves parsed values, defaults, repeated options, positionals and tokens with their types", () => {
    const log = vi.spyOn(console, "log").mockImplementation(() => {});
    const result = parseArgsWithHelp({
      args: ["-v", "--tag", "one", "--tag", "two", "folder"],
      options: {
        verbose: { type: "boolean", short: "v", description: "Show details." },
        output: { type: "string", default: "out.json", description: "Output path." },
        tag: { type: "string", multiple: true, description: "Select a tag." },
      },
      allowPositionals: true,
      tokens: true,
      help: { command: "example" },
    });
    expect(result).toBeDefined();
    if (!result) throw new Error("Expected parsed arguments");

    expect(result.values).toEqual({ verbose: true, output: "out.json", tag: ["one", "two"] });
    expect(result.positionals).toEqual(["folder"]);
    expect(result.tokens).toContainEqual({
      kind: "positional",
      index: 5,
      value: "folder",
    });
    expectTypeOf(result.values.verbose).toEqualTypeOf<boolean | undefined>();
    expectTypeOf(result.values.output).toEqualTypeOf<string>();
    expectTypeOf(result.values.tag).toEqualTypeOf<string[] | undefined>();
    expectTypeOf(result.positionals).toEqualTypeOf<string[]>();
    expectTypeOf(result.tokens).toBeArray();
    expect(log).not.toHaveBeenCalled();
  });

  it("uses process arguments when args is omitted", () => {
    const log = vi.spyOn(console, "log").mockImplementation(() => {});
    const argv = process.argv;
    try {
      process.argv = ["node", "example.ts", "-h"];
      expect(parseArgsWithHelp({ help: { command: "example" } })).toBeUndefined();
      expect(log).toHaveBeenCalledOnce();
    } finally {
      process.argv = argv;
    }
  });

  it.each(["help", "h", "host"])("rejects reserved help names and aliases: %s", (name) => {
    expect(() =>
      parseArgsWithHelp({
        args: [],
        options: {
          [name]: {
            type: "boolean",
            short: name === "host" ? "h" : undefined,
            description: "Conflicting option.",
          },
        },
        help: { command: "example" },
      }),
    ).toThrow("--help and -h are reserved");
  });

  it("honors an explicitly negated help option when allowNegative is enabled", () => {
    const log = vi.spyOn(console, "log").mockImplementation(() => {});
    const result = parseArgsWithHelp({
      args: ["--no-help"],
      allowNegative: true,
      help: { command: "example" },
    });
    expect(result?.values).toEqual({ help: false });
    expect(log).not.toHaveBeenCalled();
  });

  it.each([
    { args: ["--help", "--unknown"], error: "ERR_PARSE_ARGS_UNKNOWN_OPTION" },
    { args: ["--help", "--output"], error: "ERR_PARSE_ARGS_INVALID_OPTION_VALUE" },
  ])("does not swallow parser errors for $args", ({ args, error }) => {
    const log = vi.spyOn(console, "log").mockImplementation(() => {});
    expect(() =>
      parseArgsWithHelp({
        args,
        options: { output: { type: "string", description: "Output path." } },
        help: { command: "example" },
      }),
    ).toThrow(expect.objectContaining({ code: error }));
    expect(log).not.toHaveBeenCalled();
  });

  it("preserves the option terminator and does not treat positional --help as a help request", () => {
    const log = vi.spyOn(console, "log").mockImplementation(() => {});
    const result = parseArgsWithHelp({
      args: ["--", "--help"],
      allowPositionals: true,
      help: { command: "example" },
    });
    expect(result?.positionals).toEqual(["--help"]);
    expect(log).not.toHaveBeenCalled();
  });

  it("does not change parsing or enforce positional help metadata", () => {
    const result = parseArgsWithHelp({
      args: [],
      allowPositionals: true,
      help: {
        command: "example",
        positionals: [{ name: "file", description: "Input file." }],
      },
    });
    expect(result?.positionals).toEqual([]);
  });
});
