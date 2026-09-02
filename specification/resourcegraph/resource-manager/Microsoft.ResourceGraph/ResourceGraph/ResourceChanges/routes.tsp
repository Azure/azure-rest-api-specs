// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using ResourceGraphCommon;

namespace ResourceChanges;

/**
 * List changes to a resource for a given time interval.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@autoRoute
@tag("Changes")
op resourceChanges is ArmProviderActionSync<
  Request = ResourceChangesRequestParameters,
  Response = ResourceChangeList,
  Error = ResourceGraphCommon.ErrorResponse
>;
/**
 * Get resource change details.
 */
@autoRoute
@tag("Changes")
op resourceChangeDetails is ArmProviderActionSync<
  Request = ResourceChangeDetailsRequestParameters,
  Response = Body<ResourceChangeData[]>,
  Error = ResourceGraphCommon.ErrorResponse
>;
