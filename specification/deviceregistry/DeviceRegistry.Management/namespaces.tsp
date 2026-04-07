import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/provisioningState.tsp";
import "./common/error.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DeviceRegistry;

@added(Versions.v2024_10_01_preview)
@doc("Namespace definition.")
model Namespace is TrackedResource<NamespaceProperties> {
  @doc("The name of the namespace.")
  @key("namespaceName")
  @segment("namespaces")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @path
  @minLength(3)
  @maxLength(64)
  name: string;

  ...ManagedSystemAssignedIdentityProperty;
}

@added(Versions.v2024_10_01_preview)
@doc("The namespace messaging endpoints model.")
model Messaging {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" ""
  @doc("Dictionary of messaging endpoints.")
  endpoints?: Record<MessagingEndpoint>;
}

@added(Versions.v2026_02_01_preview)
@doc("The namespace management endpoints model.")
model Management {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" ""
  @doc("Dictionary of management endpoints.")
  endpoints?: Record<ManagementEndpoint>;
}

@added(Versions.v2024_10_01_preview)
@doc("The namespace properties model.")
model NamespaceProperties {
  @doc("Globally unique, immutable, non-reusable ID.")
  @visibility(Lifecycle.Read)
  uuid?: string;

  @added(Versions.v2026_11_01_preview)
  @doc("The data-plane endpoint used to perform operations in this namespace.")
  @visibility(Lifecycle.Read)
  dataEndpoint?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" ""
  @doc("Assigned and unassigned messaging endpoints.")
  messaging?: Messaging;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" ""
  @doc("Assigned and unassigned management endpoints.")
  @added(Versions.v2026_02_01_preview)
  management?: Management;

  @added(Versions.v2026_11_01_preview)
  @doc("The DPS instance that provisions devices in this namespace.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  provisioning?: NamespaceProvisioning;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2024_10_01_preview)
@doc("Namespace messaging endpoint model used by a device to connect to a service.")
model MessagingEndpoint {
  @doc("Type of connection used for messaging endpoint.")
  @removed(Versions.v2025_07_01_preview)
  type?: string;

  @doc("Type of connection used for messaging endpoint.")
  @added(Versions.v2025_07_01_preview)
  endpointType?: string;

  @added(Versions.v2025_07_01_preview)
  @doc("The endpoint address to connect to.")
  address: string;

  @doc("The messaging endpoint Azure resource Id.")
  resourceId?: string;

  @added(Versions.v2026_11_01_preview)
  @doc("The provisioning configuration for this messaging endpoint.")
  provisioning?: MessagingEndpointProvisioning;
}

@added(Versions.v2026_02_01_preview)
@doc("Namespace management endpoint model used by service to connect to device.")
model ManagementEndpoint {
  @doc("Type of connection used for management endpoint.")
  endpointType: string;

  @doc("The endpoint address to connect to.")
  address: string;

  @doc("The scope ID for the management endpoint.")
  scopeId: string;

  @doc("The messaging endpoint Azure resource Id.")
  resourceId: string;
}

@added(Versions.v2026_11_01_preview)
@doc("The provisioning configuration for a messaging endpoint.")
model MessagingEndpointProvisioning {
  @doc("The availability status of the messaging endpoint.")
  availability?: MessagingEndpointAvailability;

  @doc("The allocation weight for this messaging endpoint.")
  allocationWeight?: int32;
}

@added(Versions.v2026_11_01_preview)
@doc("The availability status of a messaging endpoint.")
union MessagingEndpointAvailability {
  string,

  @doc("The messaging endpoint is available.")
  Available: "Available",

  @doc("The messaging endpoint is disabled.")
  Disabled: "Disabled",
}

@added(Versions.v2026_11_01_preview)
@doc("The DPS provisioning configuration for the namespace.")
model NamespaceProvisioning {
  @doc("The Azure resource ID of the DPS instance that provisions devices in this namespace.")
  dpsResourceId?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Placeholder model for future expansion."
@added(Versions.v2026_11_01_preview)
@doc("Request body for the bulk import operation on a Namespace resource.")
model NamespaceBulkImportRequest {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Placeholder model for future expansion."
@added(Versions.v2026_11_01_preview)
@doc("Response for the bulk import operation on a Namespace resource.")
model NamespaceBulkImportResponse {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Placeholder model for future expansion."
@added(Versions.v2026_11_01_preview)
@doc("Request body for the bulk export operation on a Namespace resource.")
model NamespaceBulkExportRequest {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Placeholder model for future expansion."
@added(Versions.v2026_11_01_preview)
@doc("Response for the bulk export operation on a Namespace resource.")
model NamespaceBulkExportResponse {}

@added(Versions.v2025_07_01_preview)
@doc("Request body for the migrate resources operation in to Namespace resource.")
model NamespaceMigrateRequest {
  @doc("Scope of the migrate resources operation.")
  scope?: Scope;

  @doc("List of asset resources to be migrated.")
  resourceIds?: string[];
}

@added(Versions.v2025_07_01_preview)
@doc("Response for the migrate asset resources operation into Namespace resource.")
model NamespaceMigrateResponse {
  @doc("List of migrate results containing result of each asset migrate operation.")
  @identifiers(#["resourceId"])
  migrateResults?: MigrateResult[];
}

@added(Versions.v2025_07_01_preview)
@doc("Result of Migrate operation of asset resource into Namespace resource.")
model MigrateResult {
  @doc("The resource Id of the asset resource.")
  resourceId?: string;

  @doc("The result of the migrate operation.")
  result?: MigrateResultType;

  @doc("The error if the migrate operation is not successful.")
  error?: Error;
}

@added(Versions.v2025_07_01_preview)
@doc("Result Type of Migrate Operation.")
union MigrateResultType {
  @doc("Resource Migrate operation is successful.")
  Succeeded: "Succeeded",

  @doc("Resource Migrate operation is not successful.")
  Failed: "Failed",

  string,
}

@added(Versions.v2025_07_01_preview)
@doc("Scope of the migrate resources operation.")
union Scope {
  @doc("Scoping the migration to resourceIds provided")
  Resources: "Resources",

  string,
}

@added(Versions.v2024_10_01_preview)
@armResourceOperations
interface Namespaces {
  get is ArmResourceRead<Namespace>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<Namespace>;
  update is ArmResourcePatchAsync<Namespace, NamespaceProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Namespace>;
  listByResourceGroup is ArmResourceListByParent<Namespace>;
  listBySubscription is ArmListBySubscription<Namespace>;

  @doc("Migrate the resources into Namespace")
  @added(Versions.v2025_07_01_preview)
  migrate is ArmResourceActionAsync<
    Namespace,
    NamespaceMigrateRequest,
    NamespaceMigrateResponse,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Bulk import devices into the namespace from a provided storage account.")
  @added(Versions.v2026_11_01_preview)
  bulkImport is ArmResourceActionAsync<
    Namespace,
    NamespaceBulkImportRequest,
    NamespaceBulkImportResponse,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Bulk export device metadata from the namespace into a storage account.")
  @added(Versions.v2026_11_01_preview)
  bulkExport is ArmResourceActionAsync<
    Namespace,
    NamespaceBulkExportRequest,
    NamespaceBulkExportResponse,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}
