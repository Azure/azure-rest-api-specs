import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./goal.tsp";
import "./recoveryPlans.tsp";
import "./drill.tsp";
import "./drillResource.tsp";
import "./drillRun.tsp";
import "./partnersolution.tsp";
import "./usagePlan.tsp";
import "./client.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
@versioned(Microsoft.AzureResilienceManagement.Versions)
namespace Microsoft.AzureResilienceManagement;

@doc("Microsoft.AzureResilienceManagement Resource Provider supported API versions.")
enum Versions {
  @doc("Microsoft.AzureResilienceManagement Resource Provider management API version 2025-02-01-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_02_01_preview: "2025-02-01-preview",

  @doc("Microsoft.AzureResilienceManagement Resource Provider management API version 2026-03-01-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_03_01_preview: "2026-03-01-preview",

  @doc("Microsoft.AzureResilienceManagement Resource Provider management API version 2026-04-01-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_04_01_preview: "2026-04-01-preview",

  @doc("Microsoft.AzureResilienceManagement Resource Provider management API version 2026-06-01-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_06_01_preview: "2026-06-01-preview",

  @doc("Microsoft.AzureResilienceManagement Resource Provider management API version 2026-08-31-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_08_31_preview: "2026-08-31-preview",

  @doc("Microsoft.AzureResilienceManagement Resource Provider management API version 2026-09-30-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  @Azure.Core.previewVersion
  v2026_09_30_preview: "2026-09-30-preview",
}

@armResourceOperations
@removed(Versions.v2026_09_30_preview)
@renamedFrom(Versions.v2026_09_30_preview, "Operations")
interface OperationsOld {
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @doc("List the operations for the provider Deprecated: API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version.")
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  list is Azure.ResourceManager.Operations.list;
}

@armResourceOperations
@removed(Versions.v2026_09_30_preview)
@renamedFrom(Versions.v2026_09_30_preview, "OperationStatus")
interface OperationStatusOld {
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  @doc("Returns the current status of an async operation. Deprecated: API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version.")
  @autoRoute
  get(
    ...ApiVersionParameter,

    @path
    @segment("providers")
    @doc("The provider namespace.")
    provider: "Microsoft.AzureResilienceManagement",

    ...LocationParameter,
    ...Azure.ResourceManager.Foundations.OperationIdParameter,
  ): ArmResponse<OperationStatusResult> | ErrorResponse;
}

#suppress "deprecated" "The legacy operation must retain the operationStatuses route segment in the retired API versions."
@@segment(OperationStatusOld.get::parameters.operationId, "operationStatuses");

@added(Versions.v2026_09_30_preview)
interface Operations extends Azure.ResourceManager.Operations {}

@@sharedRoute(Operations.list);

@armResourceOperations
@added(Versions.v2026_09_30_preview)
interface OperationStatus {
  @sharedRoute
  @doc("Returns the current status of an async operation.")
  @autoRoute
  get(
    ...ApiVersionParameter,

    @path
    @segment("providers")
    @doc("The provider namespace.")
    provider: "Microsoft.AzureResilienceManagement",

    ...LocationParameter,
    ...Azure.ResourceManager.Foundations.OperationIdParameter,
  ): ArmResponse<OperationStatusResult> | ErrorResponse;
}

@@segment(OperationStatus.get::parameters.operationId, "operationStatuses");
