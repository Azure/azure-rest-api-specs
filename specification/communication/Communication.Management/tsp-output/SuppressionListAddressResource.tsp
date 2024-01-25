import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SuppressionListResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Communication;
/**
 * A object that represents a SuppressionList record.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(SuppressionListResource)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  SuppressionListAddressProperties
)
model SuppressionListAddressResource extends ProxyResourceBase {
  /**
   * The id of the address in a suppression list.
   */
  @maxLength(253)
  @minLength(1)
  @pattern("^[a-zA-Z0-9-]+$")
  @path
  @key("addressId")
  @segment("suppressionListAddresses")
  @visibility("read")
  name: string;

  /**
   * The properties of a SuppressionListAddress resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SuppressionListAddressProperties;
}

@armResourceOperations
interface SuppressionListAddressResources {
  /**
   * Get a SuppressionListAddress.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SuppressionListAddresses_Get")
  get is ArmResourceRead<SuppressionListAddressResource>;

  /**
   * Create or update a SuppressionListAddress.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SuppressionListAddresses_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SuppressionListAddressResource>;

  /**
   * Operation to delete a single address from a suppression list.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SuppressionListAddresses_Delete")
  delete is ArmResourceDeleteSync<SuppressionListAddressResource>;

  /**
   * Get all the addresses in a suppression list.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SuppressionListAddresses_List")
  list is ArmResourceListByParent<SuppressionListAddressResource>;
}

@@projectedName(SuppressionListAddressResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(SuppressionListAddressResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(SuppressionListAddressResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
