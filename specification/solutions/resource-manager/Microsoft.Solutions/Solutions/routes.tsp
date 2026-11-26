// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Solutions;

/**
 * Generates the registry package links for Managed Applications and Solution Templates.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
@tag("PortalRegistryPackages")
op portalRegistryPackage is ArmProviderActionSync<
  Request = RegistryPackagePlan,
  Response = RegistryPackage
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ApplicationsOperationGroup {
  /**
   * Gets the managed application.
   */
  @route("/{+applicationId}")
  @get
  @tag("Applications")
  getById(
    ...ApiVersionParameter,

    /**
     * The ID of the managed application.
     */
    @path
    applicationId: string,
  ): ArmResponse<Application> | NotFoundResponse | ErrorResponse;

  /**
   * Creates or updates a managed application.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @route("/{+applicationId}")
  @put
  @tag("Applications")
  createOrUpdateById(
    ...ApiVersionParameter,

    /**
     * The ID of the managed application.
     */
    @path
    applicationId: string,

    /**
     * Parameters supplied to create or update a managed application.
     */
    @bodyRoot
    parameters: Application,
  ):
    | ArmResponse<Application>
    | ArmCreatedResponse<
        Application,
        ExtraHeaders = ArmAsyncOperationHeader<FinalResult = Application> &
          Azure.Core.Foundations.RetryAfterHeader
      >
    | ErrorResponse;

  /**
   * Updates an existing managed application.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @route("/{+applicationId}")
  @patch(#{ implicitOptionality: false })
  @tag("Applications")
  updateById(
    ...ApiVersionParameter,

    /**
     * The ID of the managed application.
     */
    @path
    applicationId: string,

    /**
     * Parameters supplied to update an existing managed application.
     */
    @bodyRoot
    parameters?: ApplicationPatchable,
  ):
    | ArmResponse<Application>
    | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = Application> &
        Azure.Core.Foundations.RetryAfterHeader> & {
        @bodyRoot
        _: Application;
      })
    | ErrorResponse;

  /**
   * Deletes the managed application.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @route("/{+applicationId}")
  @delete
  @tag("Applications")
  deleteById(
    ...ApiVersionParameter,

    /**
     * The ID of the managed application.
     */
    @path
    applicationId: string,
  ):
    | OkResponse
    | ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader &
        Azure.Core.Foundations.RetryAfterHeader>
    | ArmDeletedNoContentResponse
    | ErrorResponse;
}
