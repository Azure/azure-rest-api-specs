import { OpenAPI2Parameter } from "@azure-tools/typespec-autorest";
import { getOriginalDocument } from "./document.js";

const apiVersionAlias: string[] = ["api-version", "apiVersion", "apiVersionParameter"];

export function isApiVersionParameter(obj: Record<string, any>) {
  if (obj["$ref"] !== undefined) {
    const commonTypePattern =
      /^\.\.\/\.\.\/\.\.\/\.\.\/\.\.\/common-types\/resource-management\/v[1-6]\/types.json#\/parameters\/ApiVersionParameter$/;
    if (commonTypePattern.test(obj["$ref"])) return true;

    if (
      apiVersionAlias
        .map((a) => `#/parameters/${a}`.toLowerCase())
        .filter((a) => (obj["$ref"] as string).toLowerCase().includes(a)).length > 0
    )
      return true;

    const originalParameter = getOriginalParameter(obj["$ref"]);
    if (
      originalParameter?.name === "api-version" &&
      originalParameter?.in === "query" &&
      originalParameter?.required === true
    )
      return true;
  } else if (obj["name"] !== undefined) {
    if (apiVersionAlias.map((a) => a.toLowerCase()).includes(obj["name"].toLowerCase()))
      return true;
  }

  return false;
}

const subscriptionIdAlias: string[] = [
  "subscription-id",
  "subscriptionId",
  "subscriptionIdParameter",
];

export function isSubscriptionIdParameter(obj: Record<string, any>) {
  if (obj["$ref"] !== undefined) {
    const commonTypePattern =
      /^\.\.\/\.\.\/\.\.\/\.\.\/\.\.\/common-types\/resource-management\/v[1-6]\/types\.json#\/parameters\/SubscriptionIdParameter$/;
    if (commonTypePattern.test(obj["$ref"])) return true;

    if (
      subscriptionIdAlias
        .map((a) => `#/parameters/${a}`.toLowerCase())
        .filter((a) => (obj["$ref"] as string).toLowerCase().includes(a)).length > 0
    )
      return true;

    const originalParameter = getOriginalParameter(obj["$ref"]);
    if (
      originalParameter?.name === "subscriptionId" &&
      originalParameter?.in === "path" &&
      originalParameter?.required === true
    )
      return true;
  } else if (obj["name"] !== undefined) {
    if (subscriptionIdAlias.map((a) => a.toLowerCase()).includes(obj["name"].toLowerCase()))
      return true;
  }

  return false;
}

const resourceGroupNameAlias: string[] = [
  "resource-group-name",
  "resourceGroupName",
  "resourceGroupNameParameter",
  "resource-group",
  "resourceGroup",
  "resourceGroupParameter",
];

export function isResourceGroupNameParameter(obj: Record<string, any>) {
  if (obj["$ref"] !== undefined) {
    const commonTypePattern =
      /^\.\.\/\.\.\/\.\.\/\.\.\/\.\.\/common-types\/resource-management\/v[1-6]\/types\.json#\/parameters\/ResourceGroupNameParameter$/;
    if (commonTypePattern.test(obj["$ref"])) return true;

    if (
      resourceGroupNameAlias
        .map((a) => `#/parameters/${a}`.toLowerCase())
        .filter((a) => (obj["$ref"] as string).toLowerCase().includes(a)).length > 0
    )
      return true;

    const originalParameter = getOriginalParameter(obj["$ref"]);
    if (
      originalParameter?.name === "resourceGroupName" &&
      originalParameter?.in === "path" &&
      originalParameter?.required === true
    )
      return true;
  } else if (obj["name"] !== undefined) {
    if (resourceGroupNameAlias.map((a) => a.toLowerCase()).includes(obj["name"].toLowerCase()))
      return true;
  }

  return false;
}

export function getOriginalParameter(refPath: string): OpenAPI2Parameter | undefined {
  const originalDocument = getOriginalDocument();
  if (refPath.startsWith("#/parameters/")) {
    const parameterName = refPath.substring("#/parameters/".length);
    return originalDocument?.parameters?.[parameterName];
  } else return undefined;
}
