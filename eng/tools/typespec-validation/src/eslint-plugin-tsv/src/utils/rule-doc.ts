import { KeyType, RuleDocument } from "../interfaces/rule-interfaces.js";
import { stringify } from "yaml";

function createDescriptionDocumentBlock(
  displayName: string,
  expectedValue: string | boolean | RegExp,
  extraExplanation: string,
): string {
  switch (typeof expectedValue) {
    case "object":
      return `Validate whether '${displayName}' matches regex pattern '${expectedValue}' in tspconfig.yaml. ${extraExplanation}`;
    default:
    case "string":
    case "boolean":
      return `Validate whether '${displayName}' is set to '${expectedValue}' in tspconfig.yaml`;
  }
}

function createErrorDocumentBlock(
  displayName: string,
  expectedValue: string | boolean | RegExp,
): string {
  switch (typeof expectedValue) {
    case "object":
      return `'${displayName}' does NOT match regex pattern '${expectedValue}' in tspconfig.yaml`;
    default:
    case "string":
    case "boolean":
      return `'${displayName}' is NOT set to '${expectedValue}' in tspconfig.yaml`;
  }
}

function createActionDocumentBlock(
  displayName: string,
  expectedValue: string | boolean | RegExp,
): string {
  switch (typeof expectedValue) {
    case "object":
      return `Set '${displayName}' to a value that matches regex pattern '${expectedValue}' in tspconfig.yaml`;
    default:
    case "string":
    case "boolean":
      return `Set '${displayName}' to '${expectedValue}' in tspconfig.yaml`;
  }
}

export function createRuleDocument(
  emitterName: string,
  keyType: KeyType,
  key: string,
  expectedValue: string | boolean | RegExp,
  exampleValue: string | boolean,
  extraExplanation: string,
): RuleDocument {
  let displayName = key;
  let example = "";
  switch (keyType) {
    case KeyType.EmitterOption:
      displayName = `options.${emitterName}.${key}`;
      example = createEmitterOptionExample(emitterName, { key: key, value: exampleValue });
      break;
    case KeyType.Parameter:
      displayName = `parameters.${key}`;
      example = createParameterExample({ key: key, value: exampleValue });
      break;
    default:
      // TODO: log not supported
      displayName = key;
  }
  const description = createDescriptionDocumentBlock(displayName, expectedValue, extraExplanation);
  const error = createErrorDocumentBlock(displayName, expectedValue);
  const action = createActionDocumentBlock(displayName, expectedValue);

  const document: RuleDocument = {
    description,
    error,
    action,
    example,
  };
  return document;
}

export function createParameterExample(...pairs: { key: string; value: string | boolean | {} }[]) {
  const obj: Record<string, any> = { parameters: {} };
  for (const pair of pairs) {
    obj.parameters[pair.key] = { default: pair.value };
  }
  const content = stringify(obj);
  return content;
}

export function createEmitterOptionExample(
  emitter: string,
  ...pairs: { key: string; value: string | boolean | {} }[]
) {
  const obj = { options: { [emitter]: {} } };
  for (const pair of pairs) {
    const segments = pair.key.split(".");
    let cur: Record<string, any> = obj.options[emitter];
    for (const [i, segment] of segments.entries()) {
      if (i === segments.length - 1) {
        cur[segment] = pair.value;
        break;
      }
      if (!(segment in cur)) {
        cur[segment] = {};
      }
      cur = cur[segment];
    }
  }
  const content = stringify(obj);
  return content;
}
