import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.MachineLearningServices.RegistryDiscovery;

/** Registry discovery information. */
model RegistryDiscoveryDto {
  /** The registry name. */
  registryName?: string;

  /** The tenant ID. */
  tenantId?: string;

  /** The primary region. */
  primaryRegion?: string;

  /** The list of regions. */
  regions?: string[];

  /** The subscription ID. */
  subscriptionId?: string;

  /** The resource group. */
  resourceGroup?: string;

  /** The workspace name. */
  workspaceName?: string;

  /** The primary region resource provider URI. */
  primaryRegionResourceProviderUri?: url;
}
