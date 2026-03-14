import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
/**
 * The security connector resource.
 */
model SecurityConnector
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<SecurityConnectorProperties> {
  ...ResourceNameParameter<
    Resource = SecurityConnector,
    KeyName = "securityConnectorName",
    SegmentName = "securityConnectors",
    NamePattern = ""
  >;

  /**
   * Kind of the resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind?: string;

  /**
   * Entity tag is used for comparing two or more entities from the same requested resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

@armResourceOperations
interface SecurityConnectors {
  /**
   * Retrieves details of a specific security connector
   */
  get is ArmResourceRead<SecurityConnector>;

  /**
   * Creates or updates a security connector. If a security connector is already created and a subsequent request is issued for the same security connector id, then it will be updated.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<SecurityConnector>;

  /**
   * Updates a security connector
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    SecurityConnector,
    PatchModel = SecurityConnector
  >;

  /**
   * Deletes a security connector.
   */
  delete is ArmResourceDeleteSync<SecurityConnector>;

  /**
   * Lists all the security connectors in the specified resource group. Use the 'nextLink' property in the response to get the next page of security connectors for the specified resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    SecurityConnector,
    Response = ArmResponse<SecurityConnectorsList>
  >;

  /**
   * Lists all the security connectors in the specified subscription. Use the 'nextLink' property in the response to get the next page of security connectors for the specified subscription.
   */
  list is ArmListBySubscription<
    SecurityConnector,
    Response = ArmResponse<SecurityConnectorsList>
  >;
}

@@doc(SecurityConnector.name, "The security connector name.");
@@doc(SecurityConnector.properties, "Security connector data");
@@doc(SecurityConnectors.createOrUpdate::parameters.resource,
  "The security connector resource"
);
@@doc(SecurityConnectors.update::parameters.properties,
  "The security connector resource"
);
