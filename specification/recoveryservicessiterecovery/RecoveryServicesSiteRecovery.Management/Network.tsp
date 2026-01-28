import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Fabric.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Network model.
 */
@parentResource(Fabric)
model Network is Azure.ResourceManager.ProxyResource<NetworkProperties> {
  ...ResourceNameParameter<
    Resource = Network,
    KeyName = "networkName",
    SegmentName = "replicationNetworks",
    NamePattern = ""
  >;

  /**
   * Resource Location
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;
}

@armResourceOperations
interface Networks {
  /**
   * Gets the details of a network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets a network with specified server id and network name.")
  get is ArmResourceRead<Network, Error = never>;

  /**
   * Lists the networks available for a fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the list of networks under a fabric.")
  listByReplicationFabrics is ArmResourceListByParent<
    Network,
    Response = ArmResponse<NetworkCollection>,
    Error = never
  >;
}

@@doc(Network.name, "Primary network name.");
@@doc(Network.properties, "The Network Properties.");
