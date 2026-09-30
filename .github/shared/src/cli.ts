import { parseArgs, type ParseArgsConfig, type ParseArgsOptionDescriptor } from "node:util";

/** A Node.js argument definition with help text and optional display metadata. */
export interface CliOption extends ParseArgsOptionDescriptor {
  description: string;
  valueLabel?: string;
  group?: string;
}

export interface CliArgsConfig extends ParseArgsConfig {
  options?: Record<string, CliOption>;
  help: {
    header: string;
    footer?: string;
  };
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
    console.log(
      [config.help.header, formatOptions(options), config.help.footer]
        .filter((section) => section !== undefined && section !== "")
        .join("\n\n"),
    );
    return undefined;
  }
  return result;
}

function formatOptions(options: Record<string, CliOption>): string {
  const groups = new Map<string, string[]>();
  const indent = " ".repeat(27);
  for (const [name, option] of Object.entries(options)) {
    const alias = option.short ? `-${option.short}, ` : "    ";
    const value = option.type === "string" ? ` ${option.valueLabel ?? "<value>"}` : "";
    const label = `  ${alias}--${name}${value}`;
    const description = option.description.replaceAll("\n", `\n${indent}`);
    const entry =
      label.length >= indent.length
        ? `${label}\n${indent}${description}`
        : `${label.padEnd(indent.length)}${description}`;
    const heading = option.group ?? "Options";
    const entries = groups.get(heading) ?? [];
    entries.push(entry);
    groups.set(heading, entries);
  }
  return [...groups].map(([heading, entries]) => `${heading}:\n${entries.join("\n")}`).join("\n\n");
}
