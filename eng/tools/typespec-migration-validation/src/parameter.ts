export function isApiVersionParameter(obj: Record<string, any>) {
  if (obj["$ref"] !== undefined) {
    const commonTypePattern = /^\.\.\/\.\.\/\.\.\/\.\.\/\.\.\/common-types\/resource-management\/v[2-5]\/types.json#\/parameters\/ApiVersionParameter$/;
    if (commonTypePattern.test(obj["$ref"])) return true;

    if ((obj["$ref"] as string).toLowerCase().includes("#/parameters/apiVersionParameter".toLowerCase())) return true;
  }

  return false;
}

export function isSubscriptionIdParameter(obj: Record<string, any>) {
  if (obj["$ref"] !== undefined) {
    const commonTypePattern = /^\.\.\/\.\.\/\.\.\/\.\.\/\.\.\/common-types\/resource-management\/v[2-5]\/types\.json#\/parameters\/SubscriptionIdParameter$/;
    if (commonTypePattern.test(obj["$ref"])) return true;

    if ((obj["$ref"] as string).toLowerCase().includes("#/parameters/subscriptionIdParameter".toLowerCase())) return true;
  }

  return false;
}

export function isResourceGroupNameParameter(obj: Record<string, any>) {
  if (obj["$ref"] !== undefined) {
    const commonTypePattern = /^\.\.\/\.\.\/\.\.\/\.\.\/\.\.\/common-types\/resource-management\/v[2-5]\/types\.json#\/parameters\/ResourceGroupNameParameter$/;
    if (commonTypePattern.test(obj["$ref"])) return true;

    if (["#/parameters/resourceGroupNameParameter".toLowerCase(), "#/parameters/ResourceGroupParameter".toLowerCase()]. includes((obj["$ref"] as string).toLowerCase())) return true;
  }

  return false;
}

