import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SuppressionListResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Communication;
/**
 * A object that represents a SuppressionList record.
 */
@parentResource(SuppressionListResource)
model SuppressionListAddressResource
  is Azure.ResourceManager.ProxyResource<SuppressionListAddressProperties> {
  ...ResourceNameParameter<
    Resource = SuppressionListAddressResource,
    KeyName = "addressId",
    SegmentName = "suppressionListAddresses",
    NamePattern = "^[a-zA-Z0-9-]+$"
  >;
}

@armResourceOperations
interface SuppressionListAddresses {
  /**
   * Get a SuppressionListAddress.
   */
  @summary("Get")
  get is ArmResourceRead<SuppressionListAddressResource>;

  /**
   * Create or update a SuppressionListAddress.
   */
  @summary("Create Or Update")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SuppressionListAddressResource>;

  /**
   * Operation to delete a single address from a suppression list.
   */
  @summary("Delete")
  delete is ArmResourceDeleteSync<SuppressionListAddressResource>;

  /**
   * Get all the addresses in a suppression list.
   */
  @summary("Get")
  list is ArmResourceListByParent<
    SuppressionListAddressResource,
    Response = ArmResponse<SuppressionListAddressResourceCollection>
  >;
}

@@maxLength(SuppressionListAddressResource.name, 253);
@@minLength(SuppressionListAddressResource.name, 1);
@@doc(SuppressionListAddressResource.name,
  "The id of the address in a suppression list."
);
@@doc(SuppressionListAddressResource.properties,
  "The properties of a SuppressionListAddress resource."
);
@@doc(SuppressionListAddresses.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
