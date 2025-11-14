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

namespace Microsoft.AzureStackHCI;

interface KubernetesVersionsOperationGroup {
  /**
   * List all kubernetes versions.
   */
  @operationId("KubernetesVersions_ListBySubscriptionLocationResource")
  @autoRoute
  @get
  @action("kubernetesVersions")
  listBySubscriptionLocationResource is ArmProviderActionSync<
    Response = ResourceListResult<KubernetesVersion>,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}
