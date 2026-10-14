import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataControllerResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureArcData;
/**
 * Active directory connector resource
 */
@parentResource(DataControllerResource)
model ActiveDirectoryConnectorResource is Azure.ResourceManager.ProxyResource<
  ActiveDirectoryConnectorProperties,
  false
> {
  ...ResourceNameParameter<
    Resource = ActiveDirectoryConnectorResource,
    KeyName = "activeDirectoryConnectorName",
    SegmentName = "activeDirectoryConnectors",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ActiveDirectoryConnectorResources {
  /**
   * Retrieves an Active Directory connector resource
   */
  get is ArmResourceRead<ActiveDirectoryConnectorResource>;

  /**
   * Creates or replaces an Active Directory connector resource.
   */
  create is ArmResourceCreateOrReplaceAsync<ActiveDirectoryConnectorResource>;

  /**
   * Deletes an Active Directory connector resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    ActiveDirectoryConnectorResource,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * List the active directory connectors associated with the given data controller.
   */
  @summary("List the active directory connectors associated with the given data controller.")
  list is ArmResourceListByParent<
    ActiveDirectoryConnectorResource,
    Response = ArmResponse<ActiveDirectoryConnectorListResult>
  >;
}

@@doc(
  ActiveDirectoryConnectorResource.name,
  "The name of the Active Directory connector instance"
);
@@doc(ActiveDirectoryConnectorResource.properties, "null");
@@doc(ActiveDirectoryConnectorResources.create::parameters.resource, "desc");
