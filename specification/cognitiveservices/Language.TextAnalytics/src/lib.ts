import { createCadlLibrary } from "@cadl-lang/compiler";

export const libDef = {
  name: "@cadl-api-spec/azure-language-textanalytics",
  diagnostics: {
    "incomplete-task": {
      severity: "error",
      messages: {
        default:
          "Task not paired with model that extends TaskResult and has a discriminator ending in 'Results'.",
      },
    },
    "incomplete-task-result": {
      severity: "error",
      messages: {
        default:
          "TaskResult not paired with a model that extends Task with discriminator omitting the 'Results' suffix.",
      },
    },
    "incomplete-lro": {
      severity: "error",
      messages: {
        default:
          "LROTask not paired with model that extends LROTaskResult and has a discriminator ending in 'LROResults'.",
      },
    },
    "incomplete-lro-result": {
      severity: "error",
      messages: {
        default:
          "LROTaskResult not paired with a model that extends LROTask with discriminator omitting the 'LROResults' suffix.",
      },
    },
  },
} as const;
export const { reportDiagnostic } = createCadlLibrary(libDef);
