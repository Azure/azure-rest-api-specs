import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager.Private;

namespace Azure.ResourceManager.CustomExtension;
/**
 * A long-running resource CreateOrUpdate (PUT)
 * @template TargetResource the target resource, e.g. Extension.Subscription or Extension.ManagementGroup or Extension.ResourceGroup
 * @template ExtensionResource the resource being created or updated
 * @template LroHeaders Optional.  Allows overriding the lro headers returned on resource create
 * @template Parameters Optional. Additional parameters after the path parameters
 * @template Response Optional. The success response for the createOrUpdate operation
 * @template Error Optional. The error response, if non-standard.
 */
#suppress "@azure-tools/typespec-azure-core/response-schema-problem" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
@doc("Create a {name}", ExtensionResource)
@armResourceCreateOrUpdate(ExtensionResource)
@enforceConstraint(TargetResource, Foundations.Resource)
@enforceConstraint(ExtensionResource, Foundations.Resource)
@Azure.Core.Foundations.Private.defaultFinalStateVia(#[
  "location",
  "azure-async-operation"
])
@put
op CreateOrUpdateWithoutBodyAsync<
  TargetResource extends Foundations.SimpleResource,
  ExtensionResource extends Foundations.SimpleResource,
  LroHeaders extends TypeSpec.Reflection.Model = ArmAsyncOperationHeader<FinalResult = ExtensionResource> &
    Azure.Core.Foundations.RetryAfterHeader,
  Parameters extends {} = {},
  Response extends {} = ArmResourceUpdatedResponse<ExtensionResource> | ArmResourceCreatedResponse<
    ExtensionResource,
    LroHeaders
  >,
  Error extends {} = ErrorResponse
> is ArmCreateOperation<
  Azure.ResourceManager.Extension.ExtensionInstanceParameters<
    TargetResource,
    ExtensionResource
  > &
    Parameters,
  ExtensionResource,
  Response,
  Error
>;

/**
 * A long-running resource update using a custom PATCH payload (Asynchronous)
 * @template TargetResource the target resource, e.g. Extension.Subscription or Extension.ManagementGroup or Extension.ResourceGroup
 * @template ExtensionResource the resource being patched
 * @template PatchModel The input model for the PATCH request
 * @template LroHeaders Optional.  Allows overriding the lro headers returned in the Accepted response
 * @template Parameters Optional. Additional parameters after the path parameters
 * @template Response Optional. The success response for the patch operation
 * @template Error Optional. The error response, if non-standard.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
@doc("Update a {name}", ExtensionResource)
@enforceConstraint(TargetResource, Foundations.Resource)
@enforceConstraint(ExtensionResource, Foundations.Resource)
@patch(#{ implicitOptionality: true })
op CustomPatchWithoutBodyAsync<
  TargetResource extends Foundations.SimpleResource,
  ExtensionResource extends Foundations.SimpleResource,
  PatchModel extends TypeSpec.Reflection.Model = TagsUpdateModel<ExtensionResource>,
  LroHeaders extends TypeSpec.Reflection.Model = ArmLroLocationHeader<
    Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>,
    ExtensionResource,
    string
  > &
    Azure.Core.Foundations.RetryAfterHeader,
  Parameters extends {} = {},
  Response extends {} = ArmResponse<ExtensionResource> | ArmAcceptedLroResponse<
    "Resource update request accepted.",
    LroHeaders
  >,
  Error extends {} = ErrorResponse
> is ArmUpdateOperation<
  Azure.ResourceManager.Extension.ExtensionInstanceParameters<
    TargetResource,
    ExtensionResource
  > &
    Parameters,
  PatchModel,
  Response,
  Error
>;

/**
 * @dev The base template for Azure Resource Manager PUT Operations.
 * @template HttpParameters The parameter object for the operation.
 * @template BodyParameter The body parameter
 * @template Response The response or union of responses for success.
 * @template ErrorResponse The error response.
 */
#suppress "@azure-tools/typespec-azure-core/response-schema-problem" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@typespec/compiler/unused-template-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op ArmCreateOperation<
  HttpParameters extends {},
  BodyParameter extends {},
  Response extends {},
  ErrorResponse extends {}
>(...HttpParameters): Response | ErrorResponse;

/**
 * @dev The base template for Azure Resource Manager PATCH Operations.
 * @template HttpParameters The parameter object for the operation.
 * @template BodyParameter The body parameter
 * @template Response The response or union of responses for success.
 * @template ErrorResponse The error response.
 * @template RequestBody Optional. ENables changing the name, documentation, or optionality of the request body parameter
 */
#suppress "@typespec/compiler/unused-template-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op ArmUpdateOperation<
  HttpParameters extends {},
  BodyParameter extends {},
  Response extends {},
  ErrorResponse extends {}
>(...HttpParameters): Response | ErrorResponse;
