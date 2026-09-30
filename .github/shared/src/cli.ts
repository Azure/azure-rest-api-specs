import { parseArgs, type ParseArgsConfig, type ParseArgsOptionDescriptor } from "node:util";

/** A Node.js argument definition with help text and optional display metadata. */
export interface CliOption extends ParseArgsOptionDescriptor {
  description: string;
  valueLabel?: string;
  group?: string;
}

/** Describes a positional argument in help; validation remains the caller's responsibility. */
export interface CliPositional {
  name: string;
  description: string;
  optional?: boolean;
}

export interface CliHelp {
  command: string;
  title?: string;
  description?: string;
  positionals?: readonly CliPositional[];
  /** Argument strings, without the command prefix. */
  examples?: readonly string[];
  notes?: readonly string[];
  documentation?: string;
}

export interface CliArgsConfig extends ParseArgsConfig {
  options?: Record<string, CliOption>;
  help: CliHelp;
}

const HELP_OPTION = {
  type: "boolean",
  short: "h",
  description: "Show help and exit.",
} satisfies CliOption;

/**
 * Parses arguments with automatic --help / -h support, preserving Node's parser behavior.
 * Prints help and returns undefined when requested; callers must return without running their command.
 * The option names "help" and "h", and short alias "h", are reserved.
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
