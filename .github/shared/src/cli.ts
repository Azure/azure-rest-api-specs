import { parseArgs, type ParseArgsConfig, type ParseArgsOptionDescriptor } from "node:util";

/**
 * A Node.js argument definition with help text and optional display metadata.
 * Inherited settings, such as `type`, `short`, and `default`, retain their `parseArgs` semantics.
 */
export interface CliOption extends ParseArgsOptionDescriptor {
  /** Description displayed beside the option. Wraps automatically and preserves explicit newlines. */
  description: string;

  /** String-value placeholder, including delimiters, such as `<path>`. Defaults to `<value>`. */
  valueLabel?: string;

  /** Help section heading. Defaults to `Options`; groups appear in first-occurrence order. */
  group?: string;
}

/** Describes a positional argument in help; validation remains the caller's responsibility. */
export interface CliPositional {
  /** Argument name without delimiters, such as `folder`. */
  name: string;

  /** Description displayed beside the argument, with automatic wrapping. */
  description: string;

  /** Whether help displays `[name]` instead of `<name>`. Defaults to `false`; does not affect parsing. */
  optional?: boolean;
}

/** Structured content used to generate command-line help. */
export interface CliHelp {
  /** Command prefix used in usage and examples, such as `pnpm tsv`. */
  command: string;

  /** Heading at the top of help. Defaults to `command`. */
  title?: string;

  /** Tool description displayed below the heading. Omit to display only the heading. */
  description?: string;

  /**
   * Positional arguments in invocation order, used to generate usage and argument descriptions.
   * Omitted or empty arrays produce no argument section. Does not enable or validate positionals.
   */
  positionals?: readonly CliPositional[];

  /**
   * Example argument strings, without the command prefix; each is prefixed with `command`.
   * An empty string displays the command alone. Omitted or empty arrays produce no examples section.
   */
  examples?: readonly string[];

  /** Additional guidance, automatically wrapped. Omitted or empty arrays produce no notes section. */
  notes?: readonly string[];

  /** Documentation URL displayed at the end of help. Omit to hide the documentation section. */
  documentation?: string;
}

/** Native Node.js parser settings extended with option descriptions and structured help. */
export interface CliArgsConfig extends ParseArgsConfig {
  /**
   * Option definitions keyed by long name, without leading dashes. Omit if there are no custom options.
   * `--help` and `-h` are added automatically; names `help` and `h` and short alias `h` are reserved.
   */
  options?: Record<string, CliOption>;

  /** Content for generated help; display metadata does not change parsing or validation. */
  help: CliHelp;
}

const HELP_OPTION = {
  type: "boolean",
  short: "h",
  description: "Show help and exit.",
} satisfies CliOption;

/**
 * Parses arguments with automatic `--help` / `-h` support, preserving Node's parser behavior.
 *
 * @typeParam T - Exact configuration used to infer option values, positionals, and tokens.
 * @param config - Native parser settings, option descriptions, and structured help metadata.
 * @returns The inferred Node.js parsing result, or `undefined` after printing help to stdout.
 * Callers must return without running their command when the result is `undefined`.
 * @throws If an option uses the reserved names `help` or `h`, or the short alias `h`.
 * @throws If Node's `parseArgs` rejects the configuration or arguments, even when help is requested.
 *
 * @remarks
 * Does not call `process.exit`. Positional help metadata does not enforce required arguments;
 * callers remain responsible for application-specific validation.
 */
export function parseArgsWithHelp<const T extends CliArgsConfig>(config: T) {
  const definitions: T["options"] = config.options;
  if (
    definitions &&
    ("help" in definitions ||
      "h" in definitions ||
      Object.values(definitions).some((option) => option.short === "h"))
  ) {
    throw new Error("--help and -h are reserved by parseArgsWithHelp.");
  }

  const options = { help: HELP_OPTION, ...definitions };
  const result = parseArgs({ ...config, options });
  if ("help" in result.values && result.values.help) {
    console.log(formatHelp(config.help, options));
    return undefined;
  }
  return result;
}

function formatHelp(help: CliHelp, options: Record<string, CliOption>): string {
  const positionals = help.positionals ?? [];
  const sections = [
    [help.title ?? help.command, help.description].filter(Boolean).join("\n"),
    `Usage:\n${formatUsage(help.command, positionals)}`,
  ];
  if (positionals.length > 0) {
    sections.push(formatPositionals(positionals));
  }
  sections.push(formatOptions(options));
  if (help.notes?.length) {
    sections.push(`Notes:\n${help.notes.map((note) => formatEntry("", note, 2)).join("\n")}`);
  }
  if (help.examples?.length) {
    const examples = help.examples.map((example) =>
      [help.command, example].filter(Boolean).join(" "),
    );
    sections.push(`Examples:\n${examples.map((example) => `  ${example}`).join("\n")}`);
  }
  if (help.documentation) {
    sections.push(`Documentation: ${help.documentation}`);
  }
  return sections.join("\n\n");
}

function positionalLabel(positional: CliPositional): string {
  return positional.optional ? `[${positional.name}]` : `<${positional.name}>`;
}

function formatUsage(command: string, positionals: readonly CliPositional[]): string {
  return `  ${[command, ...positionals.map(positionalLabel), "[options]"].join(" ")}`;
}

function formatPositionals(positionals: readonly CliPositional[]): string {
  return `Arguments:\n${positionals
    .map((positional) => formatEntry(`  ${positionalLabel(positional)}`, positional.description))
    .join("\n")}`;
}

function formatOptions(options: Record<string, CliOption>): string {
  const groups = new Map<string, string[]>();
  for (const [name, option] of Object.entries(options)) {
    const alias = option.short ? `-${option.short}, ` : "    ";
    const value = option.type === "string" ? ` ${option.valueLabel ?? "<value>"}` : "";
    const label = `  ${alias}--${name}${value}`;
    const heading = option.group ?? "Options";
    const entries = groups.get(heading) ?? [];
    entries.push(formatEntry(label, option.description));
    groups.set(heading, entries);
  }
  return [...groups].map(([heading, entries]) => `${heading}:\n${entries.join("\n")}`).join("\n\n");
}

function formatEntry(label: string, description: string, column = 27): string {
  const indent = " ".repeat(column);
  const lines: string[] = [];
  for (const paragraph of description.split("\n")) {
    let line = "";
    for (const word of paragraph.trim().split(/\s+/)) {
      if (line && line.length + word.length + 1 > 80 - column) {
        lines.push(line);
        line = word;
      } else {
        line += line ? ` ${word}` : word;
      }
    }
    lines.push(line);
  }
  const text = lines.join(`\n${indent}`);
  return label.length >= column ? `${label}\n${indent}${text}` : `${label.padEnd(column)}${text}`;
}
