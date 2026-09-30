import {
  createRule,
  getLocationContext,
  getNamespaceFullName,
  isTemplateDeclarationOrInstance,
  type Operation,
} from "@typespec/compiler";
import { $lib } from "../lib.ts";

type StandardOperationsOptions = {
  includeInterfaces?: string[];
};

const defaultOptions: StandardOperationsOptions = {};
const standardOperationNames = [
  "PostJob",
  "QueryJobStatus",
  "ListJobs",
  "CancelJob",
  "DeleteJob",
  "PostJobPreview",
  "QueryJobStatusPreview",
  "ListJobsPreview",
  "CancelJobPreview",
  "DeleteJobPreview",
];

export const useStandardOperationsRule = createRule({
  name: "use-standard-operations",
  severity: "warning",
  description: "Define operations using an approved Foundry standard job template.",
  url: "https://github.com/Azure/azure-rest-api-specs/tree/main/libs/foundry-core#demo-linter",
  messages: {
    default:
      "Define this operation using a Microsoft.Foundry.Core.StandardOperations template (PostJob, QueryJobStatus, ListJobs, CancelJob, or DeleteJob).",
  },
  defaultOptions,
  optionSchema: {
    type: "object",
    additionalProperties: false,
    properties: {
      includeInterfaces: {
        type: "array",
        minItems: 1,
        uniqueItems: true,
        items: {
          type: "string",
          pattern: "^[A-Za-z_][A-Za-z0-9_]*(\\.[A-Za-z_][A-Za-z0-9_]*)*$",
        },
      },
    },
  },
  create(context) {
    const namespace = context.program
      .getGlobalNamespaceType()
      .namespaces.get("Microsoft")
      ?.namespaces.get("Foundry")
      ?.namespaces.get("Core")
      ?.namespaces.get("StandardOperations");
    const approvedNodes = new Set<NonNullable<Operation["node"]>>();
    for (const name of standardOperationNames) {
      const operation = namespace?.operations.get(name);
      if (!operation?.node) continue;
      const location = getLocationContext(context.program, operation);
      if (location.type === "library" && location.metadata.name === $lib.name) {
        approvedNodes.add(operation.node);
      }
    }
    const includedInterfaces = context.options.includeInterfaces
      ? new Set(context.options.includeInterfaces)
      : undefined;

    return {
      operation(operation) {
        if (isTemplateDeclarationOrInstance(operation)) return;
        const iface = operation.interface;
        if (includedInterfaces) {
          if (!iface) return;
          const namespaceName = iface.namespace ? getNamespaceFullName(iface.namespace) : "";
          const name = namespaceName ? `${namespaceName}.${iface.name}` : iface.name;
          if (!includedInterfaces.has(name)) return;
        }
        for (let source = operation.sourceOperation; source; source = source.sourceOperation) {
          if (source.node && approvedNodes.has(source.node)) return;
        }

        // Inherited operations can retain a library node; target the consuming interface.
        const target =
          iface &&
          ((operation.node && iface.node && operation.node.parent !== iface.node) ||
            iface.namespace !== operation.namespace ||
            (getLocationContext(context.program, operation).type === "library" &&
              getLocationContext(context.program, iface).type === "project"))
            ? iface
            : operation;
        context.reportDiagnostic({ target });
      },
    };
  },
});
