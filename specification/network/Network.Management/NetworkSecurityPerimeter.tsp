import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * The Network Security Perimeter resource
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkSecurityPerimeter)
@Http.Private.includeInapplicableMetadataInPayload(false)
model NetworkSecurityPerimeter extends CommonTrackedResource {
  /**
   * Properties of the network security perimeter.
   */
  properties?: NetworkSecurityPerimeterProperties;

  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("networkSecurityPerimeterName")
  @segment("networkSecurityPerimeters")
  @pattern("(^[a-zA-Z0-9]+[a-zA-Z0-9_.-]*[a-zA-Z0-9_]+$)|(^[a-zA-Z0-9]$)")
  name: string;
}

@@doc(NetworkSecurityPerimeter.name, "The name of the resource");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkSecurityPerimeter)
@armResourceOperations
interface NetworkSecurityPerimeters {
  /**
   * Gets the specified network security perimeter by the name.
   */
  get is ArmResourceRead<NetworkSecurityPerimeter, Error = CloudError>;

  /**
   * Creates or updates a Network Security Perimeter.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    NetworkSecurityPerimeter,
    Error = CloudError
  >;

  /**
   * Patch Tags for a Network Security Perimeter.
   */
  @patch(#{ implicitOptionality: false })
  patch is ArmCustomPatchSync<
    NetworkSecurityPerimeter,
    PatchModel = UpdateTagsRequest,
    Error = CloudError
  >;

  /**
   * Deletes a network security perimeter.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkSecurityPerimeter,
    Parameters = {
      /**
       * Deletes the resource even if it contains any child associations.
       */
      @query("force")
      force?: boolean;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * List network security perimeters in a resource group.
   */
  list is ArmResourceListByParent<
    NetworkSecurityPerimeter,
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

  /**
   * List all network security perimeters in a subscription.
   */
  listBySubscription is ArmListBySubscription<
    NetworkSecurityPerimeter,
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

@@maxLength(NetworkSecurityPerimeter.name, 80);
@@doc(NetworkSecurityPerimeter.name,
  "The name of the network security perimeter."
);
@@doc(NetworkSecurityPerimeter.properties,
  "The network security perimeter properties"
);
@@doc(NetworkSecurityPerimeters.createOrUpdate::parameters.resource,
  "Parameter supplied to create or update the network security perimeter."
);
@@doc(NetworkSecurityPerimeters.patch::parameters.properties,
  "Parameter supplied to the network security perimeter."
);
