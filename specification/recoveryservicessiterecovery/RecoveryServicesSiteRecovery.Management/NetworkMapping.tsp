import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Network.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Network Mapping model. Ideally it should have been possible to inherit this class from prev version in InheritedModels as long as there is no difference in structure or method signature. Since there were no base Models for certain fields and methods viz NetworkMappingProperties and Load with required return type, the class has been introduced in its entirety with references to base models to facilitate extensions in subsequent versions.
 */
@parentResource(Network)
model NetworkMapping
  is Azure.ResourceManager.ProxyResource<NetworkMappingProperties> {
  ...ResourceNameParameter<
    Resource = NetworkMapping,
    KeyName = "networkMappingName",
    SegmentName = "replicationNetworkMappings",
    NamePattern = ""
  >;

  /**
   * Resource Location
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;
}

@armResourceOperations
interface NetworkMappings {
  /**
   * Gets the details of an ASR network mapping.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets network mapping by name.")
  get is ArmResourceRead<NetworkMapping, Error = never>;

  /**
   * The operation to create an ASR network mapping.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates network mapping.")
  create is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    NetworkMapping,
    Request = CreateNetworkMappingInput,
    Response = ArmResourceUpdatedResponse<NetworkMapping> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = NetworkMapping> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = never
  >;

  /**
   * The operation to update an ASR network mapping.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  @summary("Updates network mapping.")
  update is ArmCustomPatchAsync<
    NetworkMapping,
    PatchModel = UpdateNetworkMappingInput,
    Error = never
  >;

  /**
   * The operation to delete a network mapping.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete network mapping.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkMapping, Error = never>;

  /**
   * Lists all ASR network mappings for the specified network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets all the network mappings under a network.")
  listByReplicationNetworks is ArmResourceListByParent<
    NetworkMapping,
    Response = ArmResponse<NetworkMappingCollection>,
    Error = never
  >;
}

@@doc(NetworkMapping.name, "Network mapping name.");
@@doc(NetworkMapping.properties, "The Network Mapping Properties.");
@@doc(NetworkMappings.create::parameters.resource,
  "Create network mapping input."
);
@@doc(NetworkMappings.update::parameters.properties,
  "Update network mapping input."
);
