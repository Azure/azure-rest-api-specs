import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EdgeOrder;
/**
 * Address Resource.
 */
model AddressResource
  is Azure.ResourceManager.TrackedResource<AddressProperties, false> {
  ...ResourceNameParameter<
    Resource = AddressResource,
    KeyName = "addressName",
    SegmentName = "addresses",
    NamePattern = "^[-\\w\\.]+$"
  >;
}

@armResourceOperations
interface AddressResources {
  /**
   * Get information about the specified address.
   */
  get is ArmResourceRead<AddressResource>;

  /**
   * Create a new address with the specified parameters. Existing address cannot be updated with this API and should
   * instead be updated with the Update address API.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is ArmResourceCreateOrReplaceAsync<
    AddressResource,
    Response = ArmResourceUpdatedResponse<AddressResource> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update the properties of an existing address.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AddressResource,
    PatchModel = AddressUpdateParameter,
    Parameters = {
      /**
       * Defines the If-Match condition. The patch will be performed only if the ETag of the job on the server matches this value.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    }
  >;

  /**
   * Delete an address.
   */
  delete is ArmResourceDeleteWithoutOkAsync<AddressResource>;

  /**
   * List all the addresses available under the given resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    AddressResource,
    Parameters = {
      /**
       * $filter is supported to filter based on shipping address properties. Filter supports only equals operation.
       */
      @query("$filter")
      $filter?: string;

      /**
       * $skipToken is supported on Get list of addresses, which provides the next page in the list of addresses.
       */
      @query("$skipToken")
      $skipToken?: string;

      /**
       * $top is supported on fetching list of resources. $top=10 means that the first 10 items in the list will be returned to the API caller.
       */
      @query("$top")
      $top?: int32;
    },
    Response = ArmResponse<AddressResourceList>
  >;

  /**
   * List all the addresses available under the subscription.
   */
  listBySubscription is ArmListBySubscription<
    AddressResource,
    Parameters = {
      /**
       * $filter is supported to filter based on shipping address properties. Filter supports only equals operation.
       */
      @query("$filter")
      $filter?: string;

      /**
       * $skipToken is supported on Get list of addresses, which provides the next page in the list of addresses.
       */
      @query("$skipToken")
      $skipToken?: string;

      /**
       * $top is supported on fetching list of resources. $top=10 means that the first 10 items in the list will be returned to the API caller.
       */
      @query("$top")
      $top?: int32;
    },
    Response = ArmResponse<AddressResourceList>
  >;
}

@@maxLength(AddressResource.name, 24);
@@minLength(AddressResource.name, 3);
@@doc(AddressResource.name,
  "The name of the address Resource within the specified resource group. address names must be between 3 and 24 characters in length and use any alphanumeric and underscore only."
);
@@doc(AddressResource.properties, "Properties of an address.");
@@doc(AddressResources.create::parameters.resource,
  "Address details from request body."
);
@@doc(AddressResources.update::parameters.properties,
  "Address update parameters from request body."
);
