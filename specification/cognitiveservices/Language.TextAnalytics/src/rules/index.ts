import {
  Model,
  Namespace,
  Program,
  SemanticNodeListener,
  StringLiteral,
} from "@cadl-lang/compiler";
import { reportDiagnostic } from "../lib.js";

interface CheckTaskResult {
  task?: Model;
  taskResult?: Model;
}

function hasBaseModel(model: Model, baseModelName: string): boolean {
  if (model.baseModel) {
    if (model.baseModel.name === baseModelName && model.baseModel.namespace?.name === "Language") {
      return true;
    }
    return hasBaseModel(model.baseModel, baseModelName);
  }
  return false;
}

function getDiscriminatorValue(model: Model): string | undefined {
  let baseModel = model.baseModel;
  if (baseModel) {
    let templateArguments = baseModel.templateArguments;
    if (templateArguments) {
      let discriminator = (templateArguments[0] as StringLiteral)?.value;
      return discriminator;
    }
  }
  return undefined;
}

/**
 * Ensure Task is paired with TaskResult.
 */
export function createTaskResultRule(program: Program): SemanticNodeListener {
  return {
    namespace: checkNamespace,
  };

  function checkNamespace(namespace: Namespace) {
    var taskMap = new Map<string, CheckTaskResult>();
    namespace.models.forEach((model: Model, key: string) => {
      if (hasBaseModel(model, "AnalyzeTextTask")) {
        let discriminator = getDiscriminatorValue(model);
        if (discriminator) {
          if (taskMap.has(discriminator)) {
            taskMap.get(discriminator)!.task = model;
          } else {
            taskMap.set(discriminator, { task: model, taskResult: undefined });
          }
        }
      } else if (hasBaseModel(model, "AnalyzeTextTaskResult")) {
        let discriminator = getDiscriminatorValue(model);
        if (discriminator) {
          let taskDiscriminator = discriminator.slice(0, -"Results".length);
          if (taskMap.has(taskDiscriminator)) {
            taskMap.get(taskDiscriminator)!.taskResult = model;
          } else {
            taskMap.set(discriminator, { task: undefined, taskResult: model });
          }
        }
      }
    });
    taskMap?.forEach((pair: CheckTaskResult, key: string) => {
      if (pair.task && !pair.taskResult) {
        reportTaskMismatch(pair.task);
      } else if (pair.taskResult && !pair.task) {
        reportTaskResultMismatch(pair.taskResult);
      }
    });
  }

  function reportTaskMismatch(target: Model) {
    reportDiagnostic(program, {
      code: "incomplete-task",
      target,
    });
  }

  function reportTaskResultMismatch(target: Model) {
    reportDiagnostic(program, {
      code: "incomplete-task-result",
      target,
    });
  }
}

/**
 * Ensure LROTask is paired with LROTaskResult.
 */
export function createLROTaskResultRule(program: Program): SemanticNodeListener {
  return {
    namespace: checkNamespace,
  };

  function checkNamespace(namespace: Namespace) {
    var taskMap = new Map<string, CheckTaskResult>();
    namespace.models.forEach((model: Model, key: string) => {
      if (hasBaseModel(model, "AnalyzeTextLROTask")) {
        let discriminator = getDiscriminatorValue(model);
        if (discriminator) {
          if (taskMap.has(discriminator)) {
            taskMap.get(discriminator)!.task = model;
          } else {
            taskMap.set(discriminator, { task: model, taskResult: undefined });
          }
        }
      } else if (hasBaseModel(model, "LROTaskResult")) {
        let discriminator = getDiscriminatorValue(model);
        if (discriminator) {
          let taskDiscriminator = discriminator.slice(0, -"LROResults".length);
          if (taskMap.has(taskDiscriminator)) {
            taskMap.get(taskDiscriminator)!.taskResult = model;
          } else {
            taskMap.set(discriminator, { task: undefined, taskResult: model });
          }
        }
      }
    });
    taskMap?.forEach((pair: CheckTaskResult, key: string) => {
      if (pair.task && !pair.taskResult) {
        reportLROTaskMismatch(pair.task);
      } else if (pair.taskResult && !pair.task) {
        reportLROTaskResultMismatch(pair.taskResult);
      }
    });

    function reportLROTaskMismatch(target: Model) {
      reportDiagnostic(program, {
        code: "incomplete-lro",
        target,
      });
    }

    function reportLROTaskResultMismatch(target: Model) {
      reportDiagnostic(program, {
        code: "incomplete-lro-result",
        target,
      });
    }
  }
}
