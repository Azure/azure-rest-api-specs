import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

@armProviderNamespace("Microsoft.OrionDB")
namespace Microsoft.OrionDB;

@armResourceOperations(OrionDbResource)
interface Clusters {
  @doc("Get a OrionDbResource by name.")
  get is ArmResourceRead<OrionDbResource>;

  @doc("Create or update a OrionDbResource.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    OrionDbResource,
    Response = ArmResourceUpdatedResponse<OrionDbResource> | ArmResourceCreatedResponse<OrionDbResource> | ArmAcceptedLroResponse
  >;

  @doc("Updates an existing OrionDbResource. The request body can contain one to many of the properties present in the normal server definition.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    OrionDbResource,
    PatchModel = OrionDbResource,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    Response = ArmResourceUpdatedResponse<OrionDbResource> | ArmAcceptedLroResponse
  >;

  @doc("Deletes an OrionDbResource.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    OrionDbResource,
    Response = ArmDeletedResponse| ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  @doc("List all the clusters in a given resource group.")
  listByResourceGroup is ArmResourceListByParent<OrionDbResource>;

  @doc("List all the clusters in a given subscription.")
  listBySubscription is ArmListBySubscription<OrionDbResource>;
}

@@maxLength(OrionDbResource.name, 63);
@@minLength(OrionDbResource.name, 3);
@@doc(OrionDbResource.name, "The name of the server.");
@@doc(OrionDbResource.properties, "Properties of the server.");
