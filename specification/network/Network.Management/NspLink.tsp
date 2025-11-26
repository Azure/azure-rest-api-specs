import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkSecurityPerimeter.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * The network security perimeter link resource
 */
@parentResource(NetworkSecurityPerimeter)
model NspLink is Azure.ResourceManager.ProxyResource<NspLinkProperties> {
  ...ResourceNameParameter<
    Resource = NspLink,
    KeyName = "linkName",
    SegmentName = "links",
    NamePattern = "(^[a-zA-Z0-9]+[a-zA-Z0-9_.-]*[a-zA-Z0-9_]+$)|(^[a-zA-Z0-9]$)"
  >;
}

@armResourceOperations
interface NspLinks {
  /**
   * Gets the specified NSP link resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkSecurityPerimeterLinks_Get")
  get is ArmResourceRead<NspLink, Error = CloudError>;

  /**
   * Creates or updates NSP link resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkSecurityPerimeterLinks_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<NspLink, Error = CloudError>;

  /**
   * Deletes an NSP Link resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("NetworkSecurityPerimeterLinks_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    NspLink,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists the NSP Link resources in the specified network security perimeter.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkSecurityPerimeterLinks_List")
  list is ArmResourceListByParent<
    NspLink,
    Parameters = {
      /**
       * An optional query parameter which specifies the maximum number of records to be returned by the server.
       */
      @maxValue(20)
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Error = CloudError
  >;
}

@@maxLength(NspLink.name, 80);
@@doc(NspLink.name, "The name of the NSP link.");
@@doc(NspLink.properties,
  "Properties of the network security perimeter link resource."
);
@@doc(NspLinks.createOrUpdate::parameters.resource,
  "Parameters that hold the NspLink resource to be created/updated."
);
