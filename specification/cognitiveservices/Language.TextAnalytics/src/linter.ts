import "./index.js";

import { EventEmitter, navigateProgram, Program, SemanticNodeListener } from "@cadl-lang/compiler";
import { createLROTaskResultRule, createTaskResultRule } from "./rules/index.js";

export async function $onValidate(p: Program) {
  runLinter(p);
}

class Linter {
  private eventEmitter = new EventEmitter<SemanticNodeListener>();

  run(p: Program) {
    navigateProgram(p, this.eventEmitter);
  }

  register(listeners: SemanticNodeListener[] | SemanticNodeListener) {
    const listenerList = Array.isArray(listeners) ? listeners : [listeners];
    for (const listeners of listenerList) {
      for (const [name, listener] of Object.entries(listeners)) {
        this.eventEmitter.on(name as any, listener as any);
      }
    }
  }
}

const runLinter = (p: Program) => {
  const linter = new Linter();
  linter.register([createTaskResultRule(p)]);
  linter.register([createLROTaskResultRule(p)]);
  return linter.run(p);
};

export const namespace = "Azure.Language";
