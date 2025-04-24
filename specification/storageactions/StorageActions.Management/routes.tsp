// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageActions;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface StorageTasksOperationGroup {
  /**
   * Runs the input conditions against input object metadata properties and designates matched objects in response.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("StorageTasks_PreviewActions")
  @autoRoute
  previewActions is ArmProviderActionSync<
    Request = StorageTaskPreviewAction,
    Response = StorageTaskPreviewAction,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}
