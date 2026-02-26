import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";

import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.Authorization;
/**
 * The data policy manifest.
 */
model DataPolicyManifest
  is Azure.ResourceManager.ProxyResource<DataPolicyManifestProperties> {
  ...ResourceNameParameter<
    Resource = DataPolicyManifest,
    KeyName = "policyMode",
    SegmentName = "dataPolicyManifests"
  >;
}

alias DataPolicyManifestTenantOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Authorization";
  },
  {},
  {
    /** The policy mode of the data policy manifest to get. */
    @path
    @segment("dataPolicyManifests")
    @key
    policyMode: string;
  }
>;

/**
 * Operations for DataPolicyManifest at tenant scope.
 */
@added(Versions.v2025_11_01)
@armResourceOperations
interface DataPolicyManifests {
  /**
   * This operation retrieves the data policy manifest with the given policy mode.
   */
  @summary("Retrieves a data policy manifest.")
  getByPolicyMode is DataPolicyManifestTenantOps.Read<DataPolicyManifest>;

  /**
   * This operation retrieves a list of all the data policy manifests that match the optional given $filter. Valid values for $filter are: \"$filter=namespace eq '{0}'\". If $filter is not provided, the unfiltered list includes all data policy manifests for data resource types. If $filter=namespace is provided, the returned list only includes all data policy manifests that have a namespace matching the provided value.
   */
  @summary("Retrieves data policy manifests.")
  list is DataPolicyManifestTenantOps.List<
    DataPolicyManifest,
    Parameters = {
      /**
       * The filter to apply on the operation. Valid values for $filter are: \"namespace eq '{value}'\". If $filter is not provided, no filtering is performed. If $filter=namespace eq '{value}' is provided, the returned list only includes all data policy manifests that have a namespace matching the provided value.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}
