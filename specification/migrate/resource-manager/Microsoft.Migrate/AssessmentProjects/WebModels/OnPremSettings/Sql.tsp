import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "Singleton resource"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Operations on the resource are sync"
@doc("SQL OnPrem Settings for Calculating On Prem Cost")
@parentResource(AssessmentProject)
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model SqlOnPremSettings is ProxyResource<SqlOnPremSettingsProperties> {
  @doc("The name of the SQL On Prem Settings resource.")
  @key("sqlOnPremSettingsName")
  @segment("sqlOnPremSettings")
  @path
  name: "default";
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Operations on the resource are sync"
@doc("Properties for SQL OnPrem Settings, including compute, storage, network, facility, labor, security, and management settings.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model SqlOnPremSettingsProperties is AzureResourceProperties {
  @doc("Configuration and cost details related to compute resources in the on-premises environment.")
  computeSettings: SqlComputeSettings;

  @doc("Security-related settings including physical and digital security costs.")
  securitySettings: SqlSecuritySettings;

  @doc("Metadata describing the reconciliation status of the settings.")
  reconciliationInfo?: SqlReconciliationInfo;
}

@doc("Settings related to SQL compute resources, including licensing information.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model SqlComputeSettings {
  @doc("List of SQL Server licensing information.")
  @identifiers(#[])
  sqlServerLicensing: SqlServerLicensingSettings[];
}

@doc("Information about SQL Server licensing, including version and costs.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model SqlServerLicensingSettings {
  @doc("The version of the SQL Server.")
  version: string;

  @doc("The cost of the SQL Server license.")
  licenseCost: float32;

  @doc("The cost of software assurance for the SQL Server.")
  softwareAssuranceCost: float32;
}

@doc("Settings related to SQL security resources, including security costs.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model SqlSecuritySettings {
  @doc("The cost of SQL Server security per server per year.")
  sqlServerSecurityCostPerServerPerYear: float32;
}

@doc("Reconciliation metadata for On-Premises Settings.")
@added(AssessmentProjectApiVersions.v2025_09_09_preview)
model SqlReconciliationInfo {
  @doc("Timestamp of the last reconciliation.")
  lastReconciliationTime?: utcDateTime;

  @doc("Current reconciliation status.")
  reconciliationStatus?: string;

  @doc("Source that triggered reconciliation.")
  reconciliationTriggerSource?: string;
}
