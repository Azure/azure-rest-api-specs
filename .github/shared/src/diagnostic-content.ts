import { isAbsolute, normalize, relative } from "pathe";
import { stripVTControlCharacters } from "node:util";
import pc from "picocolors";

export type DiagnosticContent =
  | string
  | { readonly kind: "text" | "lines" | "blocks"; readonly parts: readonly DiagnosticContent[] }
  | { readonly kind: "indent"; readonly content: DiagnosticContent }
  | { readonly kind: "path"; readonly path: string }
  | { readonly kind: "verbatim"; readonly value: string };

export function text(
  strings: TemplateStringsArray,
  ...values: (DiagnosticContent | number)[]
): DiagnosticContent {
  const parts: DiagnosticContent[] = [strings[0]];
  for (const [index, value] of values.entries()) {
    parts.push(typeof value === "number" ? String(value) : value, strings[index + 1]);
  }
  return { kind: "text", parts };
}

export function filePath(path: string): DiagnosticContent {
  return { kind: "path", path };
}

export function lines(parts: readonly DiagnosticContent[]): DiagnosticContent {
  return { kind: "lines", parts };
}

export function indent(content: DiagnosticContent): DiagnosticContent {
  return { kind: "indent", content };
}

export function blocks(...parts: DiagnosticContent[]): DiagnosticContent {
  return { kind: "blocks", parts };
}

/** Preserve native command output, including its existing colors and whitespace. */
export function verbatim(value: string): DiagnosticContent {
  return { kind: "verbatim", value };
}

export function renderDiagnosticContent(
  content: DiagnosticContent,
  { color = false, cwd = process.cwd() }: { color?: boolean; cwd?: string } = {},
): string {
  const c = pc.createColors(color);

  function render(content: DiagnosticContent): string {
    if (typeof content === "string") return content;
    switch (content.kind) {
      case "text":
        return content.parts.map(render).join("");
      case "lines":
        return content.parts.map(render).join("\n");
      case "blocks":
        return content.parts
          .map(render)
          .filter((part) => part !== "")
          .join("\n\n");
      case "indent":
        return render(content.content).replace(/^(?=[^\r\n])/gm, "  ");
      case "path":
        return c.cyan(formatPath(content.path, cwd));
      case "verbatim":
        return content.value;
    }
  }

  const output = render(content);
  return color ? output : stripVTControlCharacters(output);
}

function formatPath(file: string, cwd: string): string {
  return normalize(isAbsolute(file) ? relative(cwd, file) : file);
}
