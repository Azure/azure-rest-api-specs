import "./index.js";

import { DecoratorContext, Type } from "@cadl-lang/compiler";

const tagKey = Symbol();
// TODO: How to NOT export but still use them internally?
export function $tag(context: DecoratorContext, target: Type, tag: string) {
  let existingTags: Array<string> = context.program.stateMap(tagKey).get(target) || [];
  context.program.stateMap(tagKey).set(target, existingTags.concat([tag]));
}

// TODO: How to NOT export but still use them internally?
export function $isTaggedWith(
  context: DecoratorContext,
  _: Type,
  target: Type,
  tag: string,
  message: string
) {
  let tags: Array<string> = context.program.stateMap(tagKey).get(target) || [];
  if (tags.indexOf(tag) === -1) {
    context.program.reportDiagnostic({
      code: "azure-missing-tag",
      severity: "error",
      message: message,
      target: target,
    });
    return;
  }
}

export const namespace = "Azure.Language.Private";
