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

  @visibility("read", "create")
  @doc("SKU name.")
  sku: string; // TODO: Change to enum with default

  @visibility("read", "create", "update")
  @doc("White label workbench id.")
  whiteLabelWorkbenchId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Private.ContosoWorkbench/contosoWorkbenches";
    }
  ]>;
}

@doc("Workbench tracked resource.")
model Workbench is TrackedResource<WorkbenchProperties> {
  @doc("The name of the Workbench")
  @segment("workbenches")
  @key("workbenchName")
  @TypeSpec.Http.path
  @pattern("^(?!-)(?!.*--)[a-zA-Z][A-Za-z0-9-]{0,63}(?<!-)$")
  name: string;
}

@armResourceOperations
interface Workbenches
  extends BaseResourceOperations<Workbench, WorkbenchProperties> {
  listByResourceGroup is ArmResourceListByParent<Workbench>;
  listBySubscription is ArmListBySubscription<Workbench>;
}
