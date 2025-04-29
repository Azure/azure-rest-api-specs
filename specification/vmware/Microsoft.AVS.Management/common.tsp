namespace Microsoft.AVS;

using Azure.ResourceManager;
using TypeSpec.Http;
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

// https://github.com/Azure/typespec-azure/issues/438
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
@doc("Availability zones envelope.")
model AvailabilityZones {
  @doc("The availability zones.")
  @added(Versions.v2024_09_01)
  zones?: string[];
}

@doc("The response of a {name} list operation.", Resource)
@friendlyName(FriendlyNameFormat, Resource)
model ResourceList<
  Resource extends Foundations.Resource,
  FriendlyNameFormat extends valueof string = "{name}List"
> is Azure.Core.Page<Resource>;

/**
 * Just like ArmResourceActionSync, but with no request body.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
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

/**
 * Like ArmResourceActionAsync, but with no request body and ArmNoContentResponse.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
op ArmResourceActionNoContentAsyncNoRequestBody<
  TResource extends Azure.ResourceManager.Foundations.Resource,
  TBaseParameters extends TypeSpec.Reflection.Model = Foundations.BaseParameters<TResource>
> is ArmResourceActionAsyncBase<
  TResource,
  void,
  ArmAcceptedLroResponse | ArmNoContentResponse<"Action completed successfully.">,
  TBaseParameters
>;

/**
 * Just like ArmAcceptedLroResponse, but with a ResponseBody.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
@doc(Description)
model ArmAcceptedLroResponseWithResponseBody<
  ResponseBody,
  Description extends valueof string = "Resource operation accepted.",
  LroHeaders extends TypeSpec.Reflection.Model = ArmLroLocationHeader &
    Azure.Core.Foundations.RetryAfterHeader
> {
  ...AcceptedResponse;
  ...LroHeaders;
  ...Body<ResponseBody>;
}
