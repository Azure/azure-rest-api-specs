import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace SecurityConnectorsAPI;
/**
 * The security connector resource.
 */
model SecurityConnector
  is Azure.ResourceManager.ProxyResource<SecurityConnectorProperties> {
  ...ResourceNameParameter<
    Resource = SecurityConnector,
    KeyName = "securityConnectorName",
    SegmentName = "securityConnectors",
    NamePattern = ""
  >;

  /** Resource tags. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /** The geo-location where the resource lives */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Kind of the resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;

  /**
   * Entity tag is used for comparing two or more entities from the same requested resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;
}

@armResourceOperations
interface SecurityConnectors {
  /**
   * Retrieves details of a specific security connector
   */
  get is ArmResourceRead<SecurityConnector, Error = CloudError>;

  /**
   * Creates or updates a security connector. If a security connector is already created and a subsequent request is issued for the same security connector id, then it will be updated.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    SecurityConnector,
    Error = CloudError
  >;

  /**
   * Updates a security connector
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    SecurityConnector,
    PatchModel = SecurityConnector,
    Error = CloudError
  >;

  /**
   * Deletes a security connector.
   */
  delete is ArmResourceDeleteSync<SecurityConnector, Error = CloudError>;

  /**
   * Lists all the security connectors in the specified resource group. Use the 'nextLink' property in the response to get the next page of security connectors for the specified resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    SecurityConnector,
    Response = ArmResponse<SecurityConnectorsList>,
    Error = CloudError
  >;

  /**
   * Lists all the security connectors in the specified subscription. Use the 'nextLink' property in the response to get the next page of security connectors for the specified subscription.
   */
  list is ArmListBySubscription<
    SecurityConnector,
    Response = ArmResponse<SecurityConnectorsList>,
    Error = CloudError
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



