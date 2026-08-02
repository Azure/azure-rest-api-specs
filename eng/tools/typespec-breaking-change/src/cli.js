#!/usr/bin/env node
import { resolve } from "path";
import { writeFile, mkdir } from "fs/promises";
import { dirname } from "path";
import { compileService } from "./compile.js";
import { analyzeBaseAndHead, analyzeProgram } from "./orchestrator.js";
import { formatConsoleReport } from "./reporter-console.js";
import { formatGithubReport } from "./reporter-github.js";
import { formatJsonReport } from "./reporter-json.js";
import { renderMarkdownSummary } from "./reporter-markdown.js";
/**
 * Parse CLI arguments into CliOptions.
 */
export function parseArgs(args) {
    const options = {
        entry: "",
        format: "console",
    };
    for (let i = 0; i < args.length; i++) {
        const arg = args[i];
        switch (arg) {
            case "--entry":
            case "-e":
                options.entry = args[++i] ?? "";
                break;
            case "--base":
            case "-b":
                options.base = args[++i];
                break;
            case "--format":
            case "-f":
                options.format = args[++i] ?? "console";
                break;
            case "--json-output":
                options.jsonOutput = args[++i];
                break;
            case "--markdown-output":
                options.markdownOutput = args[++i];
                break;
            case "--github-annotations":
                options.githubAnnotations = true;
                break;
            case "--fail-on-breaking":
                options.failOnBreaking = true;
                break;
            case "--phase":
            case "-p":
                options.phase = args[++i];
                break;
            case "--service":
            case "-s":
                options.service = args[++i];
                break;
            case "--show-suppressed":
                options.showSuppressed = true;
                break;
            case "--show-ignored":
                options.showIgnored = true;
                break;
            case "--report-title":
                options.reportTitle = args[++i];
                break;
            case "--help":
            case "-h":
                printUsage();
                process.exit(0);
                break;
            default:
                // Treat positional argument as entry if not set
                if (!options.entry && !arg.startsWith("-")) {
                    options.entry = arg;
                }
        }
    }
    return options;
}
function printUsage() {
    console.log(`
Usage: typespec-breaking-change [options] <spec-folder>

Analyze a TypeSpec specification for breaking changes.

Arguments:
  spec-folder                Path to the TypeSpec project folder (containing main.tsp)

Options:
  -e, --entry <path>         Path to the head TypeSpec entry point (file-to-file mode)
  -b, --base <path>          Path to the base TypeSpec entry point (file-to-file comparison)
  -f, --format <format>      Console output format: console, json, github (default: console)
  --json-output <path>       Write JSON report to file
  --markdown-output <path>   Write Markdown summary to file
  --github-annotations       Emit GitHub Actions ::warning annotations
  --fail-on-breaking         Exit with code 1 if breaking changes detected
  -p, --phase <phase>        Restrict to phase: same-version, cross-version
  -s, --service <name>       Filter to a specific service name
  --show-suppressed          Include suppressed findings in output
  --show-ignored             Include ignored findings in output
  -h, --help                 Show this help message

Exit codes:
  0  No breaking changes found (or --fail-on-breaking not set)
  1  Breaking changes detected (with --fail-on-breaking)
  2  Analysis failure (compilation error, invalid arguments, etc.)

Examples:
  # Single spec folder (Phase B cross-version analysis)
  typespec-breaking-change ./specification/widget/Microsoft.Widget/Widget

  # File-to-file comparison (Phase A + B)
  typespec-breaking-change --entry ./head/main.tsp --base ./base/main.tsp

  # CI mode: JSON + Markdown output, fail on breaking
  typespec-breaking-change ./spec --json-output report.json --markdown-output report.md --fail-on-breaking
`);
}
/**
 * Format the analysis result using the specified reporter.
 */
export function formatResult(result, options) {
    switch (options.format) {
        case "json":
            return formatJsonReport(result, buildReportOptions(options));
        case "github":
            return formatGithubReport(result);
        case "console":
        default:
            return formatConsoleReport(result, {
                showSuppressed: options.showSuppressed,
                showIgnored: options.showIgnored,
                showTiming: true,
            });
    }
}
function buildReportOptions(options) {
    return {
        specPaths: [options.entry],
        baseRevision: options.base,
        headRevision: options.entry,
    };
}
async function ensureParentDir(filePath) {
    await mkdir(dirname(filePath), { recursive: true });
}
/**
 * Main CLI entry point.
 */
export async function main(args) {
    const options = parseArgs(args);
    if (!options.entry) {
        console.error("Error: No entry point specified. Use --entry <path> or provide a positional argument.");
        console.error("Run with --help for usage information.");
        return 2;
    }
    const analysisOptions = {
        serviceName: options.service,
        phase: options.phase,
    };
    try {
        let result;
        if (options.base) {
            // Two-program comparison (Phase A + Phase B)
            const basePath = resolve(options.base);
            const headPath = resolve(options.entry);
            const baseProgram = await compileService(basePath);
            const headProgram = await compileService(headPath);
            result = analyzeBaseAndHead(baseProgram, headProgram, analysisOptions);
        }
        else {
            // Single-program analysis (Phase B only)
            const entryPath = resolve(options.entry);
            const program = await compileService(entryPath);
            result = analyzeProgram(program, analysisOptions);
        }
        // Console output
        const output = formatResult(result, options);
        console.log(output);
        // JSON file output
        if (options.jsonOutput) {
            const jsonPath = resolve(options.jsonOutput);
            await ensureParentDir(jsonPath);
            const jsonContent = formatJsonReport(result, buildReportOptions(options));
            await writeFile(jsonPath, jsonContent);
        }
        // Markdown file output
        if (options.markdownOutput) {
            const mdPath = resolve(options.markdownOutput);
            await ensureParentDir(mdPath);
            const mdOptions = {
                specPaths: [options.entry],
                showTiming: true,
                githubServerUrl: process.env.GITHUB_SERVER_URL,
                githubRepository: process.env.GITHUB_REPOSITORY,
                githubSha: process.env.GITHUB_SHA,
                workspacePath: process.env.GITHUB_WORKSPACE,
                violationsReferenceUrl: process.env.VIOLATIONS_REFERENCE_URL,
                reportTitle: options.reportTitle,
            };
            const mdContent = renderMarkdownSummary(result, mdOptions);
            await writeFile(mdPath, mdContent);
        }
        // GitHub annotations
        if (options.githubAnnotations) {
            emitGithubAnnotations(result);
        }
        // Exit code: fail if there are unsuppressed breaking changes OR new suppressions
        const hasErrors = result.findings.some((f) => f.severity === "error" && !f.suppressed);
        const hasNewSuppressions = result.findings.some((f) => f.suppressed);
        if (options.failOnBreaking && (hasErrors || hasNewSuppressions)) {
            return 1;
        }
        return hasErrors ? 1 : 0;
    }
    catch (error) {
        const message = error instanceof Error ? error.message : String(error);
        console.error(`Analysis failed: ${message}`);
        return 2;
    }
}
/**
 * Emit GitHub Actions annotations for each unsuppressed error finding.
 */
function emitGithubAnnotations(result) {
    const errors = result.findings.filter((f) => f.severity === "error" && !f.suppressed);
    for (const finding of errors) {
        const location = finding.diff.headSourceLocation ?? finding.diff.baseSourceLocation;
        const filePart = location ? `file=${location.file.path}` : "";
        const linePart = location
            ? `,line=${location.file.text.substring(0, location.pos).split("\n").length}`
            : "";
        const locStr = filePart ? ` ${filePart}${linePart}` : "";
        const title = `Breaking change: ${finding.diff.kind}`;
        console.log(`::error${locStr ? " " + locStr.trim() : ""}::${title} - ${finding.diff.message}`);
    }
}
// Run if invoked directly
const isDirectInvocation = typeof process !== "undefined" && process.argv[1] && resolve(process.argv[1]).includes("cli");
if (isDirectInvocation) {
    main(process.argv.slice(2)).then((code) => {
        process.exit(code);
    });
}
//# sourceMappingURL=cli.js.map