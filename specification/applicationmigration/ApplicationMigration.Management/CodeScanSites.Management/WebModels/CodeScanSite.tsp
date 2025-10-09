import "../models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.ApplicationMigration;

@doc("CodeScanSite properties.")
model CodeScanSiteProperties {
  @doc("The provisioning state of the CodeScanSite.")
  @visibility(Lifecycle.Read)
  provisioningState?: Azure.ResourceManager.ResourceProvisioningState;

  @doc("Migrate project ID.")
  migrateProjectId: string;

  @doc("Assessment project ID.")
  assessmentProjectId: string;
}

@doc("CodeScanSite resource.")
model CodeScanSite
  is Azure.ResourceManager.TrackedResource<CodeScanSiteProperties> {
  @doc("CodeScanSite name")
  @key("codeScanSiteName")
  @segment("codeScanSites")
  @path
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,62}[a-zA-Z0-9]$")
  name: string;
}
