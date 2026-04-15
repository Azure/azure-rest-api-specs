import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.ExtendedLocation;

@@clientName(Microsoft.ExtendedLocation,
  "CustomLocationsManagementClient",
  "javascript"
);
@@clientName(Microsoft.ExtendedLocation, "CustomLocationsMgmtClient", "python");
@@override(CustomLocations.update, CustomLocationsUpdate, "javascript");

op CustomLocationsUpdate(
  ...Azure.ResourceManager.ApiVersionParameter,
  ...Azure.ResourceManager.SubscriptionIdParameter,
  resourceGroupName: string,
  provider: "Microsoft.ExtendedLocation",
  resourceName: string,

  /**
   * Identity for the resource.
   */
  identity?: Identity,

  /**
   * This is optional input that contains the authentication that should be used to generate the namespace.
   */
  authentication?: customLocationPropertiesAuthentication,

  /**
   * Contains the reference to the add-on that contains charts to deploy CRDs and operators.
   */
  clusterExtensionIds?: string[],

  /**
   * Display name for the Custom Locations location.
   */
  displayName?: string,

  /**
   * Connected Cluster or AKS Cluster. The Custom Locations RP will perform a checkAccess API for listAdminCredentials permissions.
   */
  hostResourceId?: string,

  /**
   * Type of host the Custom Locations is referencing (Kubernetes, etc...).
   */
  hostType?: HostType,

  /**
   * Kubernetes namespace that will be created on the specified cluster.
   */
  `namespace`?: string,

  /**
   * Provisioning State for the Custom Location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: string,

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>,
): Azure.ResourceManager.ArmResponse<Microsoft.ExtendedLocation.customLocation> | Azure.ResourceManager.CommonTypes.ErrorResponse;
