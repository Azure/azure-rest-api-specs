namespace Microsoft.AzureImageTestingForLinux;

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using OpenAPI;

/*Temporary ArmResourceCreateOrUpdateSync until Typespec library updates*/

/** ARM API Review Compliant create or update (PUT) template */
/**
 * @template TResource the resource being patched
 * @template TBaseParameters Optional. Allows overriding the operation parameters
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-outside-interface" "This is a valid template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "For backward compatibility"
@autoRoute
@doc("Create a {name}", TResource)
@armResourceCreateOrUpdate(TResource)
@put
op ArmResourceCreateOrUpdateSyncCompliant<
  TResource extends Azure.ResourceManager.Foundations.Resource,
  TBaseParameters = Azure.ResourceManager.Foundations.BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

  @doc("Resource create parameters.")
  @bodyRoot
  resource: TResource,
): ArmUpdatedResponse<TResource> | ArmCreatedResponseSync<TResource> | Azure.ResourceManager.ErrorResponse;

@doc("ARM update operation completed successfully.")
model ArmUpdatedResponse<TResource extends Azure.ResourceManager.Foundations.Resource>
  is ArmResponse<TResource>;

@doc("ARM create operation completed successfully.")
model ArmCreatedResponseSync<TResource extends Azure.ResourceManager.Foundations.Resource>
  is Body<TResource> {
  ...CreatedResponse;
}

/*Temporary ArmResourceCreateOrUpdateAsync until Typespec library updates*/
/**
 * A long-running resource CreateOrUpdate (PUT)
 * @param TResource the resource being patched
 * @param TBaseParameters Optional. Allows overriding the operation parameters
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-outside-interface" "This is a valid template"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "For backward compatibility"
@autoRoute
@doc("Create a {name}", TResource)
@extension("x-ms-long-running-operation", true)
@extension(
  "x-ms-long-running-operation-options",
  #{ `final-state-via`: "azure-async-operation" }
)
@armResourceCreateOrUpdate(TResource)
@put
op ArmResourceCreateOrUpdateAsyncCompliant<
  TResource extends Azure.ResourceManager.Foundations.Resource,
  TBaseParameters = BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

  @doc("Resource create parameters.")
  @bodyRoot
  resource: TResource,
): ArmUpdatedResponse<TResource> | ArmCreatedResponse<TResource> | Azure.ResourceManager.ErrorResponse;
