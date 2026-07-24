import "./Common/ArmModels/AssessmentProjectV2.tsp";

import "./Common/StandardizedContracts/CostComponent.tsp";

import "./Common/DataModels/CostOverride.tsp";

import "./WebModels/OnPremSettings/Machine.tsp";
import "./WebModels/OnPremSettings/Sql.tsp";

import "./WebModels/OnPremExtension/OnPremTco.tsp";

import "./Common/ArmModels/AzureResourceProperties.tsp";

import "@azure-tools/typespec-azure-resource-manager";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Tco OnPrem Extension.")
@armResourceOperations
interface OnPremTcoOperations {
  @doc("Gets the on-premises tco calculation")
  @added(AssessmentProjectApiVersions.v2025_09_09_preview)
  get is ArmResourceRead<OnPremTco>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "On-premises machine settings are a configuration resource managed via PUT (create/replace); delete is intentionally not supported."
@doc("Operations for managing on-premises machine settings.")
@armResourceOperations
interface MachineOnPremSettingsOperations {
  @doc("Gets the on-premises machine settings.")
  @added(AssessmentProjectApiVersions.v2025_09_09_preview)
  get is ArmResourceRead<MachineOnPremSettings>;

  @doc("Lists the on-premises machine settings.")
  @added(AssessmentProjectApiVersions.v2025_09_09_preview)
  listByParent is ArmResourceListByParent<MachineOnPremSettings>;

  @doc("Updates the on-premises machine settings.")
  @added(AssessmentProjectApiVersions.v2025_09_09_preview)
  create is ArmResourceCreateOrReplaceSync<MachineOnPremSettings>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "On-premises SQL settings are a configuration resource managed via PUT (create/replace); delete is intentionally not supported."
@doc("Operations for managing on-premises SQL settings.")
@armResourceOperations
interface SqlOnPremSettingsOperations {
  @doc("Gets the on-premises SQL settings.")
  @added(AssessmentProjectApiVersions.v2025_09_09_preview)
  get is ArmResourceRead<SqlOnPremSettings>;

  @doc("Lists the on-premises SQL settings.")
  @added(AssessmentProjectApiVersions.v2025_09_09_preview)
  listByParent is ArmResourceListByParent<SqlOnPremSettings>;

  @doc("Updates the on-premises SQL settings.")
  @added(AssessmentProjectApiVersions.v2025_09_09_preview)
  create is ArmResourceCreateOrReplaceSync<SqlOnPremSettings>;
}
