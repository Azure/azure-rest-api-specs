import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./EHNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventHub;
/**
 * Network Security Perimeter related configurations of a given namespace
 */
@parentResource(EHNamespace)
model NetworkSecurityPerimeterConfiguration
  is Azure.ResourceManager.ProxyResource<NetworkSecurityPerimeterConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = NetworkSecurityPerimeterConfiguration,
    KeyName = "resourceAssociationName",
    SegmentName = "networkSecurityPerimeterConfigurations",
    NamePattern = ""
  >;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface NetworkSecurityPerimeterConfigurations {
  /**
   * Return a NetworkSecurityPerimeterConfigurations resourceAssociationName
   */
  getResourceAssociationName is ArmResourceRead<
    NetworkSecurityPerimeterConfiguration,
    Error = ErrorResponse
  >;

  /**
   * Gets list of current NetworkSecurityPerimeterConfiguration for Namespace
   */
  list is Azure.ResourceManager.Legacy.ArmListSinglePageByParent<
    NetworkSecurityPerimeterConfiguration,
    Response = ArmResponse<NetworkSecurityPerimeterConfigurationList>,
    Error = ErrorResponse
  >;

  /**
   * Refreshes any information about the association.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @post
  @action("reconcile")
  createOrUpdate is Legacy.CreateOrReplaceAsync<
    NetworkSecurityPerimeterConfiguration,
    void,
    Response = OkResponse | ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = ErrorResponse
  >;
}

@@doc(NetworkSecurityPerimeterConfiguration.name,
  "The ResourceAssociation Name"
);
@@doc(NetworkSecurityPerimeterConfiguration.properties,
  "Properties of the Network Security Perimeter Configuration"
);
