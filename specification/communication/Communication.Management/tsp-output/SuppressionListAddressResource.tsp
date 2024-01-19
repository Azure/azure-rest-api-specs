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
@doc("A object that represents a SuppressionList record.")
@parentResource(SuppressionListResource)
model SuppressionListAddressResource
  is ProxyResource<SuppressionListAddressProperties> {
  @doc("The id of the address in a suppression list.")
  @maxLength(253)
  @minLength(1)
  @pattern("^[a-zA-Z0-9-]+$")
  @path
  @key("addressId")
  @segment("suppressionListAddresses")
  name: string;
}

@armResourceOperations
interface SuppressionListAddressResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a SuppressionListAddress.")
  @operationId("SuppressionListAddresses_Get")
  get is ArmResourceRead<SuppressionListAddressResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a SuppressionListAddress.")
  @operationId("SuppressionListAddresses_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SuppressionListAddressResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Operation to delete a single address from a suppression list.")
  @operationId("SuppressionListAddresses_Delete")
  delete is ArmResourceDeleteSync<SuppressionListAddressResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get all the addresses in a suppression list.")
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
