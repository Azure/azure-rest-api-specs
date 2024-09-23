namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@doc("The location envelope.")
model LocationHeader {
  @doc("The Location header contains the URL where the status of the long running operation can be checked.")
  @header("Location")
  location?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
@doc("The SKU (Stock Keeping Unit) assigned to this resource.")
model ResourceSkuRequired {
  @doc("The SKU (Stock Keeping Unit) assigned to this resource.")
  sku: Foundations.Sku;
}

@doc("The response of a {name} list operation.", Resource)
@friendlyName(FriendlyNameFormat, Resource)
model ResourceList<
  Resource extends Foundations.Resource,
  FriendlyNameFormat extends valueof string = "{name}List"
> is Azure.Core.Page<Resource>;

// use { @bodyRoot _: void } with the next version of typespec-azure
// https://github.com/Azure/typespec-azure/issues/3759

// Just like ArmResourceActionSync, but with no request body.
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@autoRoute
@armResourceAction(TResource)
@post
op ArmResourceActionSyncNoRequestBody<
  TResource extends Azure.ResourceManager.Foundations.Resource,
  TResponse extends TypeSpec.Reflection.Model,
  TBaseParameters = Foundations.BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,
): ArmResponse<TResponse> | ErrorResponse;

// Just like ArmResourceActionAsync, but with no request body.
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
op ArmResourceActionNoContentAsyncNoRequestBody<
  TResource extends Azure.ResourceManager.Foundations.Resource,
  TBaseParameters extends TypeSpec.Reflection.Model = Foundations.BaseParameters<TResource>
> is ArmResourceActionAsyncBaseNoRequestBody<
  TResource,
  ArmAcceptedLroResponse | ArmNoContentResponse<"Action completed successfully.">,
  TBaseParameters
>;

// Just like ArmResourceActionAsyncBase, but with no request body.
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "DO NOT COPY - TODO migrate to LRO apis"
@autoRoute
@extension("x-ms-long-running-operation", true)
@extension(
  "x-ms-long-running-operation-options",
  {
    `final-state-via`: "location",
  }
)
@armResourceAction(TResource)
@post
op ArmResourceActionAsyncBaseNoRequestBody<
  TResource extends Azure.ResourceManager.Foundations.Resource,
  TResponse,
  TBaseParameters extends TypeSpec.Reflection.Model
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,
): TResponse | ErrorResponse;
