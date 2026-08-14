import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "../../main.tsp";
import "../common/common.tsp";
import "./enum.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

@added(Versions.v2026_03_01_preview)
@doc("Definition of usage plan properties.")
model UsagePlanProperties {
  @added(Versions.v2026_03_01_preview)
  @doc("The type of the usage plan.")
  planType?: UsagePlanType;

  @added(Versions.v2026_03_01_preview)
  @doc("Provisioning state of the usage plan.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @added(Versions.v2026_03_01_preview)
  @visibility(Lifecycle.Read)
  @doc("Details of any errors encountered during Usage Plan create or update.")
  errorDetails?: CommonTypes.ErrorDetail;
}

@added(Versions.v2026_03_01_preview)
@doc("A usage plan resource for Resiliency feature billing.")
model UsagePlan is TrackedResource<UsagePlanProperties> {
  @doc("The name of the usage plan.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("usagePlanName")
  @segment("usagePlans")
  @path
  name: string;
}
