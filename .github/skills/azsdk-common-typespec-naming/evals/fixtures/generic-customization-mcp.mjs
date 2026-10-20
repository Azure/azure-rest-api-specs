import readline from "node:readline";
import { pathToFileURL } from "node:url";

const toolName = "azsdk_customized_code_update";

/**
 * @param {unknown} value
 * @returns {value is Record<string, unknown>}
 */
function isRecord(value) {
  return value !== null && typeof value === "object" && !Array.isArray(value);
}

/** @param {unknown} request */
export function handleRequest(request) {
  if (!isRecord(request)) {
    throw new TypeError("Fixture request must be an object.");
  }
  if (request.id === undefined) return null;
  /** @template T @param {T} result */
  const reply = (result) => ({ jsonrpc: "2.0", id: request.id, result });
  /** @param {number} code @param {string} message */
  const error = (code, message) => ({
    jsonrpc: "2.0",
    id: request.id,
    error: { code, message },
  });
  const params = isRecord(request.params) ? request.params : {};

  switch (request.method) {
    case "initialize":
      if (typeof params.protocolVersion !== "string") {
        return error(
          -32602,
          "Fixture initialization requires protocolVersion.",
        );
      }
      return reply({
        protocolVersion: params.protocolVersion,
        capabilities: { tools: {} },
        serverInfo: {
          name: "generic-customization-eval-fixture",
          version: "1.0.0",
        },
      });
    case "ping": {
      /** @type {Record<string, never>} */
      const result = {};
      return reply(result);
    }
    case "tools/list":
      return reply({
        tools: [
          {
            name: toolName,
            description:
              "Apply TypeSpec and SDK code customizations, regenerate the SDK package, and build it.",
            inputSchema: {
              type: "object",
              properties: {
                customizationRequest: { type: "string" },
                packagePath: { type: "string" },
                tspProjectPath: { type: "string" },
                editScope: {
                  type: "string",
                  enum: ["SpecInputs", "CustomCode", "All"],
                  default: "All",
                },
              },
              required: ["customizationRequest", "packagePath"],
              additionalProperties: false,
            },
          },
        ],
      });
    case "tools/call": {
      if (params.name !== toolName) {
        return error(-32602, "Unknown fixture tool");
      }

      const args = isRecord(params.arguments) ? params.arguments : {};
      if (
        typeof args.customizationRequest !== "string" ||
        !args.customizationRequest ||
        typeof args.packagePath !== "string" ||
        !args.packagePath ||
        args.editScope === "SpecInputs"
      ) {
        return reply({
          isError: true,
          content: [
            {
              type: "text",
              text: "Fixture requires a generic SDK customization request, packagePath, and All or CustomCode scope.",
            },
          ],
        });
      }

      return reply({
        content: [
          {
            type: "text",
            text: JSON.stringify({
              Success: true,
              Message:
                "Generic SDK customization applied, regenerated, and built successfully (mock).",
            }),
          },
        ],
      });
    }
    default:
      return error(
        -32601,
        `Unsupported fixture method: ${String(request.method)}`,
      );
  }
}

if (
  process.argv[1] &&
  import.meta.url === pathToFileURL(process.argv[1]).href
) {
  const input = readline.createInterface({ input: process.stdin });
  input.on("line", (line) => {
    try {
      const result = handleRequest(JSON.parse(line));
      if (result) process.stdout.write(`${JSON.stringify(result)}\n`);
    } catch (error) {
      process.stderr.write(
        `Invalid fixture request: ${error instanceof Error ? error.message : String(error)}\n`,
      );
      process.exitCode = 1;
      input.close();
    }
  });
}
