import "@typespec/rest";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ContainerService;

// #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "built-in conditional request includes time based conditional headers"
alias IfMatchParameters<T extends Azure.ResourceManager.Foundations.Resource> = {
  @header("If-Match")
  @doc("The request should only proceed if an entity matches this string.")
  ifMatch?: string;
};

alias IfNoneMatchParameters<T extends Azure.ResourceManager.Foundations.Resource> = {
  @header("If-None-Match")
  @doc("The request should only proceed if no entity matches this string.")
  ifNoneMatch?: string;
};

alias IfMatchHeadersParameters<T extends Azure.ResourceManager.Foundations.Resource> = {
  ...IfMatchParameters<T>;
  ...IfNoneMatchParameters<T>;
};

#suppress "@azure-tools/cadl-azure-resource-manager/arm-resource-operation-outside-interface" "this is a template"
@autoRoute
@doc("Update a {name}", TResource)
@armResourceUpdate(TResource)
@patch
op FleetCustomPatchSync<
  TResource extends Foundations.Resource,
  TPatchModel extends TypeSpec.Reflection.Model = TagsUpdateModel<TResource>,
  TBaseParameters = BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

  @doc("The resource properties to be updated.")
  @bodyRoot
  parameters?: TPatchModel, //prevents api breaking change. properties -> parameters
): ArmResponse<TResource> | ErrorResponse;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-outside-interface" "this is a template"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "DO NOT COPY - TODO migrate to LRO apis"
@autoRoute
@doc("Create a {name}", TResource)
@extension("x-ms-long-running-operation", true)
@extension(
  "x-ms-long-running-operation-options",
  {
    `final-state-via`: "azure-async-operation",
  }
)
@armResourceCreateOrUpdate(TResource)
@put
op FleetArmResourceCreateOrUpdateAsync<
  TResource extends Azure.ResourceManager.Foundations.Resource,
  TBaseParameters = BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

  @doc("Resource create parameters.")
  @bodyRoot
  parameters: TResource, //prevent api breaking change. resource -> parameters
): ArmResponse<TResource> | ArmCreatedResponse<TResource> | ErrorResponse;

// this is a copy of ArmResourceDeleteAsync that adds the location header to comply with arm linter.
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "this is a template"
#suppress "@azure-tools/typespec-providerhub/no-inline-model" "inlining the response with a header does not present a risk"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "DO NOT COPY - TODO migrate to LRO apis"
@autoRoute
@doc("Delete a {name}", TResource)
@extension(
  "x-ms-long-running-operation-options",
  {
    `final-state-via`: "azure-async-operation",
  }
)
@armResourceDelete(TResource)
@delete
op FleetArmResourceDeleteAsync<
  TResource extends Azure.ResourceManager.Foundations.Resource,
  TBaseParameters = BaseParameters<TResource>
>(...ResourceInstanceParameters<TResource, TBaseParameters>):
  | ArmDeletedResponse
  | (ArmDeleteAcceptedResponse & ArmLroLocationHeader)
  | ArmDeletedNoContentResponse
  | ErrorResponse;
