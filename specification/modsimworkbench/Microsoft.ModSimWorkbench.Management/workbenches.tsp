import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./common-types.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.ModSimWorkbench")
@service({
  title: "ModSimWorkbench Control Plane API",
})
@armProviderNamespace
@versioned(Microsoft.ModSimWorkbench.Versions)
namespace Microsoft.ModSimWorkbench;

@doc("AppOidc Properties")
model AppOidc {
  @visibility("read", "create", "update")
  @doc("Key vault URI for client ID")
  clientId: string;

  @visibility("read", "create", "update")
  @doc("Key vault URI for client secret")
  secretUri: string;
}

@doc("Workbench properties.")
model WorkbenchProperties {
  ...ProvisioningStateProperty;

  @visibility("read", "create", "update")
  @doc("APP OIDC settings.")
  appOidc: AppOidc;

  @added(Versions.`2024-05-01-preview`)
  @visibility("read", "create")
  @doc("Key vault URI of customer managed key used for Storage and SharedStorage encryption.")
  customerEncryptionKeyUri?: string;

  // #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Sku is a valid envelope property"
  // TODO: Deprecate properties.sku in favor of top-level Sku (sku.name)
  // #deprecated "Use top-level sku.name"
  @visibility("read", "create")
  @doc("SKU name.")
  sku?: string;

  // For white-label demo, un-comment below.
  // @visibility("read", "create", "update")
  // @doc("White label workbench id.")
  // whiteLabelWorkbenchId?: Azure.Core.armResourceIdentifier<[
  //   {
  //     type: "Private.ContosoWorkbench/contosoWorkbenches";
  //   }
  // ]>;
}

@doc("Workbench tracked resource.")
model Workbench is TrackedResource<WorkbenchProperties> {
  @doc("The name of the Workbench")
  @visibility("read", "create")
  @segment("workbenches")
  @key("workbenchName")
  @TypeSpec.Http.path
  @pattern("^(?!-)(?!.*--)[a-zA-Z][A-Za-z0-9-]{0,63}(?<!-)$")
  name: string;

  // TODO: Add ARM-compliant top-level Sku by un-commenting below.
  // #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Sku is a valid envelope property"
  // @added(Versions.`2024-05-01-preview`)
  // @visibility("read", "create")
  // @doc("The SKU (Stock Keeping Unit) assigned to this resource.")
  // sku: Sku;
}

@armResourceOperations
interface Workbenches
  extends BaseResourceOperations<Workbench, WorkbenchProperties> {
  listByResourceGroup is ArmResourceListByParent<Workbench>;
  listBySubscription is ArmListBySubscription<Workbench>;
}
