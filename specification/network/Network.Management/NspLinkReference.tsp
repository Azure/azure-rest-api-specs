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
 * The network security perimeter linkReference resource
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkSecurityPerimeter)
@Http.Private.includeInapplicableMetadataInPayload(false)
@parentResource(NetworkSecurityPerimeter)
model NspLinkReference extends CommonProxyResource {
  /**
   * Properties of the NSP link reference.
   */
  properties?: NspLinkReferenceProperties;

  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("linkReferenceName")
  @segment("linkReferences")
  @pattern("(^[a-zA-Z0-9]+[a-zA-Z0-9_.-]*[a-zA-Z0-9_]+$)|(^[a-zA-Z0-9]$)")
  name: string;
}

@@doc(NspLinkReference.name, "The name of the resource");

@armResourceOperations
interface NspLinkReferences {
  /**
   * Gets the specified NSP linkReference resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkSecurityPerimeterLinkReferences_Get")
  get is ArmResourceRead<NspLinkReference, Error = CloudError>;

  /**
   * Deletes an NSP LinkReference resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkSecurityPerimeterLinkReferences_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    NspLinkReference,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists the NSP LinkReference resources in the specified network security perimeter.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkSecurityPerimeterLinkReferences_List")
  list is ArmResourceListByParent<
    NspLinkReference,
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

@@maxLength(NspLinkReference.name, 80);
@@doc(NspLinkReference.name, "The name of the NSP linkReference.");
@@doc(NspLinkReference.properties,
  "Properties of the network security perimeter linkReference resource."
);
