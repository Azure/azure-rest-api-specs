// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace ResourceHistory;

/**
 * List all snapshots of a resource for a given time interval.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@autoRoute
@tag("History")
op resourcesHistory is ArmProviderActionSync<
  Request = ResourcesHistoryRequest,
  Response = ArmResponse<ResourcesHistoryResult>,
  Error = ResourceGraphCommon.ErrorResponse
>;
