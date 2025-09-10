import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using OpenAPI;

namespace Microsoft.AppComplianceAutomation;

@armResourceOperations
interface AcatOperations {
  /**
   * @dev The base template for Azure Resource Manager PUT Operations.
   * @param HttpParameters The parameter object for the operation.
   * @param BodyParameter The body parameter
   * @param Response The response or union of responses for success.
   * @param ErrorResponse The error response.
   */
  @doc("Base template for Acat report PUT Operations.")
  AcatCreateOperation<
    HttpParameters extends {},
    BodyParameter extends {},
    Response extends {},
    ErrorResponse extends {}
  >(
    ...HttpParameters,
    @doc("Resource create parameters.") @bodyRoot parameters: BodyParameter,
  ): Response | ErrorResponse;

  /**
   * A long-running resource CreateOrUpdate (PUT)
   * @template Resource the resource being patched
   * @template BaseParameters Optional. Allows overriding the operation parameters
   * @template LroHeaders Optional.  Allows overriding the lro headers returned on resource create
   * @template Parameters Optional. Additional parameters after the path parameters
   * @template Response Optional. The success response for the createOrUpdate operation
   * @template Error Optional. The error response, if non-standard.
   */
  #suppress "deprecated" "legacy"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "legacy"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "legacy"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Azure specs should not be using decorator"
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "Referencing elements inside Private namespace"
  @autoRoute
  @doc("Create a {name}", Resource)
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    #{ `final-state-via`: "azure-async-operation" }
  )
  @armResourceCreateOrUpdate(Resource)
  @put
  AcatResourceCreateOrUpdateAsync<
    Resource extends Foundations.Resource,
    BaseParameters = DefaultBaseParameters<Resource>,
    LroHeaders extends TypeSpec.Reflection.Model = Azure.Core.Foundations.RetryAfterHeader,
    Parameters extends {} = {},
    Response extends {} = ArmResourceUpdatedResponse<Resource> | ArmResourceCreatedResponse<
      Resource,
      LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
        ArmAsyncOperationHeader &
        ArmLroLocationHeader
    >,
    Error extends {} = ErrorResponse
  > is AcatOperations.AcatCreateOperation<
    ResourceInstanceParameters<Resource, BaseParameters> & Parameters,
    Resource,
    ArmResourceUpdatedResponse<Resource> | ArmResourceCreatedResponse<
      Resource,
      LroHeaders
    >,
    Error
  >;

  /**
   * @dev A long-running resource CreateOrUpdate (PUT)
   * @template Resource the resource being patched
   * @template BaseParameters Optional. Allows overriding the operation parameters
   * @template LroHeaders Optional.  Allows overriding the lro headers returned on resource create
   * @template Parameters Optional. Additional parameters after the path parameters
   * @template Response Optional. The success response for the createOrReplace operation
   * @template Error Optional. The error response, if non-standard.
   */
  AcatResourceCreateOrReplaceAsync<
    Resource extends Foundations.Resource,
    BaseParameters = DefaultBaseParameters<Resource>,
    LroHeaders extends TypeSpec.Reflection.Model = Azure.Core.Foundations.RetryAfterHeader,
    Parameters extends {} = {},
    Response extends {} = ArmResourceUpdatedResponse<Resource> | ArmResourceCreatedResponse<
      Resource,
      LroHeaders
    >,
    Error extends {} = ErrorResponse
  > is AcatOperations.AcatResourceCreateOrUpdateAsync<
    Resource,
    BaseParameters,
    LroHeaders,
    Parameters,
    Response,
    Error
  >;

  /**
   * Synchronous PUT operation for Azure Resource Manager resources
   * @template Resource the resource being patched
   * @template BaseParameters Optional. Allows overriding the operation parameters
   * @template Parameters Optional. Additional parameters after the path parameters
   * @template Response Optional. The success response for the createOrUpdate operation
   * @template Error Optional. The error response, if non-standard.
   */
  @autoRoute
  @doc("Create a {name}", Resource)
  @armResourceCreateOrUpdate(Resource)
  @put
  AcatResourceCreateOrReplaceSync<
    Resource extends Foundations.Resource,
    BaseParameters = DefaultBaseParameters<Resource>,
    Parameters extends {} = {},
    Response extends {} = ArmResourceUpdatedResponse<Resource> | ArmResourceCreatedSyncResponse<Resource>,
    Error extends {} = ErrorResponse
  > is AcatOperations.AcatCreateOperation<
    ResourceInstanceParameters<Resource, BaseParameters> & Parameters,
    Resource,
    Response,
    Error
  >;
}
