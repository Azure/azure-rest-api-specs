const apiVersionAlias: string[] = [
  "api-version",
  "apiVersion",
  "apiVersionParameter",
];

export function isApiVersionParameter(obj: Record<string, any>) {
  if (obj["$ref"] !== undefined) {
    const commonTypePattern = /^\.\.\/\.\.\/\.\.\/\.\.\/\.\.\/common-types\/resource-management\/v[2-5]\/types.json#\/parameters\/ApiVersionParameter$/;
    if (commonTypePattern.test(obj["$ref"])) return true;

    if (apiVersionAlias.map(a => `#/parameters/${a}`.toLowerCase()).includes((obj["$ref"] as string).toLowerCase())) return true;
  }
  else if (obj["name"] !== undefined) {
    if (apiVersionAlias.map(a => a.toLowerCase()).includes(obj["name"].toLowerCase())) return true;
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
    const commonTypePattern = /^\.\.\/\.\.\/\.\.\/\.\.\/\.\.\/common-types\/resource-management\/v[2-5]\/types\.json#\/parameters\/SubscriptionIdParameter$/;
    if (commonTypePattern.test(obj["$ref"])) return true;

    if (subscriptionIdAlias.map(a => `#/parameters/${a}`.toLowerCase()).includes((obj["$ref"] as string).toLowerCase())) return true;
  }
  else if (obj["name"] !== undefined) {
    if (subscriptionIdAlias.map(a => a.toLowerCase()).includes(obj["name"].toLowerCase())) return true;
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
    const commonTypePattern = /^\.\.\/\.\.\/\.\.\/\.\.\/\.\.\/common-types\/resource-management\/v[2-5]\/types\.json#\/parameters\/ResourceGroupNameParameter$/;
    if (commonTypePattern.test(obj["$ref"])) return true;

    if (resourceGroupNameAlias.map(a => `#/parameters/${a}`.toLowerCase()).includes((obj["$ref"] as string).toLowerCase())) return true;
  }
  else if (obj["name"] !== undefined) {
    if (resourceGroupNameAlias.map(a => a.toLowerCase()).includes(obj["name"].toLowerCase())) return true;
  }

  return false;
}

