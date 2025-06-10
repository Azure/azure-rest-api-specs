import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Azure.ResourceManager.Legacy {
  interface CustomLegacyOperations<
    ParentParameters extends {},
    ResourceTypeParameter extends {},
    ErrorType extends {} = ErrorResponse
  > {
    /**
     * @dev A long-running resource CreateOrUpdate (PUT)
     * @template Resource the resource being created or updated
     * @template LroHeaders Optional.  Allows overriding the lro headers returned on resource create
     * @template Parameters Optional. Additional parameters after the path parameters
     * @template Response Optional. The success response(s) for the PUT operation
     */
    #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @doc("Create a {name}", Resource)
    @armResourceCreateOrUpdate(Resource)
    @Azure.Core.Foundations.Private.defaultFinalStateVia(#[
      "location",
      "azure-async-operation"
    ])
    @put
    CreateOrUpdateSync<
      Resource extends Azure.ResourceManager.CommonTypes.Resource,
      Parameters extends {} = {},
      Response extends {} = ArmResourceUpdatedResponse<Resource> | ArmResourceCreatedResponse<Resource>
    >(
      ...ParentParameters,
      ...ResourceTypeParameter,
      ...Parameters,
      @doc("Resource create parameters.") @bodyRoot resource: Resource,
    ): Response | ErrorType;

    /**
     * @dev Get a resource
     * @template Resource The resource being read
     * @template Parameters Optional. Additional parameters after the path parameters
     * @template Response Optional. The success response for a get operation.
     */
    #suppress "shadow" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @doc("Get a {name}", Resource)
    @get
    @readsResource(Resource)
    @armResourceRead(Resource)
    Read<
      Resource extends Azure.ResourceManager.CommonTypes.Resource,
      Parameters extends {} = {},
      Response extends {} = ArmResponse<Resource>
    >(
      ...ParentParameters,
      ...ResourceTypeParameter,
      ...Parameters,
    ): Response | ErrorType;

    /**
     * @dev A long-running resource Update (PATCH)
     * @template Resource the resource being created or updated
     * @template PatchModel the PATCH request model
     * @template LroHeaders Optional.  Allows overriding the lro headers returned on resource create
     * @template Parameters Optional. Additional parameters after the path parameters
     * @template Response Optional. The success response(s) for the PATCH operation
     */
    @doc("Update a {name}", Resource)
    @armResourceUpdate(Resource)
    @patch
    CustomPatchAsync<
      Resource extends Azure.ResourceManager.CommonTypes.Resource,
      PatchModel extends {} = Azure.ResourceManager.Foundations.TagsUpdateModel<Resource>,
      LroHeaders extends TypeSpec.Reflection.Model = ArmLroLocationHeader<
        Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>,
        Resource,
        string
      > &
        Azure.Core.Foundations.RetryAfterHeader,
      Parameters extends {} = {},
      Response extends {} = ArmResponse<Resource> | ArmAcceptedLroResponse<
        "Resource update request accepted.",
        LroHeaders
      >
    >(
      ...ParentParameters,
      ...ResourceTypeParameter,
      ...Parameters,
      @doc("Resource create parameters.") @bodyRoot properties: PatchModel,
    ): Response | ErrorType;

    /**
     * @dev Delete a resource synchronously
     * @template Resource The resource being deleted
     * @template Parameters Optional. Additional parameters after the path parameters
     * @template Response Optional. The success response(s) for the delete operation
     */
    #suppress "@azure-tools/typespec-azure-core/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    #suppress "shadow" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @doc("Delete a {name}", Resource)
    @delete
    @deletesResource(Resource)
    @armResourceDelete(Resource)
    DeleteSync<
      Resource extends Azure.ResourceManager.CommonTypes.Resource,
      Parameters extends {} = {},
      Response extends {} = ArmDeletedResponse | ArmDeletedNoContentResponse
    >(
      ...ParentParameters,
      ...ResourceTypeParameter,
      ...Parameters,
    ): Response | ErrorType;

    /**
     * A synchronous resource action.
     * @template Resource The resource being acted upon
     * @template Request The request model for the action
     * @template Response The response model for the action
     * @template Parameters Optional. Additional parameters after the path parameters
     */
    #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @armResourceAction(Resource)
    @Private.enforceConstraint(Resource, Foundations.Resource)
    @post
    @returnsDoc("Azure operation completed successfully.")
    ActionSync<
      Resource extends Foundations.Resource,
      Request extends TypeSpec.Reflection.Model | void,
      Response extends TypeSpec.Reflection.Model | void,
      Parameters extends {} = {}
    >(
      ...ParentParameters,
      ...ResourceTypeParameter,
      ...Parameters,

      @doc("The content of the action request")
      @bodyRoot
      body: Request,
    ): Response | ErrorType;

    /**
     * A long-running resource action.
     * @template Resource The resource being acted upon
     * @template Request The request model for the action
     * @template LroHeaders Optional. Allows overriding the headers returned in the Accepted response
     * @template Response The response model for the action
     * @template Parameters Optional. Additional parameters after the path parameters
     */
    #suppress "@azure-tools/typespec-azure-core/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @armResourceAction(Resource)
    @Private.enforceConstraint(Resource, Foundations.Resource)
    @post
    @returnsDoc("Azure operation completed successfully.")
    ActionAsync<
      Resource extends Foundations.Resource,
      Request extends TypeSpec.Reflection.Model | void,
      Result extends TypeSpec.Reflection.Model | void,
      LroHeaders extends TypeSpec.Reflection.Model = ArmLroLocationHeader<
        Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>,
        Result,
        string
      > &
        Azure.Core.Foundations.RetryAfterHeader,
      Parameters extends {} = {},
      Response extends {} | void = ArmAcceptedLroResponse<
        "Resource operation accepted.",
        LroHeaders
      > | Result
    >(
      ...ParentParameters,
      ...ResourceTypeParameter,
      ...Parameters,

      @doc("The content of the action request")
      @bodyRoot
      body: Request,
    ): Response | ErrorType;
  }
}
