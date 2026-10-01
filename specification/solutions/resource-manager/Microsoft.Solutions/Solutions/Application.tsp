import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Solutions;
/**
 * Information about managed application.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
model Application extends GenericResource {
  @visibility(Lifecycle.Read)
  @path
  @key("applicationName")
  @minLength(3)
  @maxLength(64)
  @segment("applications")
  name: string;

  /**
   * The managed application properties.
   */
  properties: ApplicationProperties;

  /**
   * The plan information.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  plan?: Plan;

  /**
   * The kind of the managed application. Allowed values are MarketPlace and ServiceCatalog.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @pattern("^[-\\w\\._,\\(\\)]+$")
  kind: string;

  /**
   * The identity of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: Identity;
}

@armResourceOperations
interface Applications {
  /**
   * Gets the managed application.
   */
  get is ArmResourceRead<
    Application,
    Response = ArmResponse<Application> | NotFoundResponse
  >;

  /**
   * Creates or updates a managed application.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Application>;

  /**
   * Updates an existing managed application.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    Application,
    PatchModel = ApplicationPatchable,
    Response =
      | ArmResponse<Application>
      | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = Application> &
          Azure.Core.Foundations.RetryAfterHeader> & {
          @bodyRoot
          _: Application;
        }),
    OptionalRequestBody = true
  >;

  /**
   * Deletes the managed application.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Application,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all the applications within a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<Application>;

  /**
   * Lists all the applications within a subscription.
   */
  listBySubscription is ArmListBySubscription<Application>;

  /**
   * Refresh Permissions for application.
   */
  refreshPermissions is ArmResourceActionAsyncBase<
    Application,
    void,
    OkResponse | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>,
    Azure.ResourceManager.Foundations.BaseParameters<Application>
  >;

  /**
   * List allowed upgrade plans for application.
   */
  listAllowedUpgradePlans is ArmResourceActionSync<
    Application,
    void,
    ArmResponse<AllowedUpgradePlansResult>
  >;

  /**
   * Update access for application.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  updateAccess is ArmResourceActionAsyncBase<
    Application,
    UpdateAccessDefinition,
    | OkResponse
    | (ArmAcceptedLroResponse<
        "Resource operation accepted.",
        ArmLroLocationHeader<FinalResult = UpdateAccessDefinition> &
          Azure.Core.Foundations.RetryAfterHeader
      > &
        Body<UpdateAccessDefinition>),
    BaseParameters = Azure.ResourceManager.Foundations.BaseParameters<Application>
  >;

  /**
   * List tokens for application.
   */
  listTokens is ArmResourceActionSync<
    Application,
    ListTokenRequest,
    ArmResponse<ManagedIdentityTokenResult>
  >;
}

@@maxLength(Application.name, 64);
@@minLength(Application.name, 3);
@@doc(Application.name, "The name of the managed application.");
@@doc(Application.properties, "The managed application properties.");
@@doc(
  Applications.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update a managed application."
);
@@doc(
  Applications.update::parameters.properties,
  "Parameters supplied to update an existing managed application."
);
@@doc(
  Applications.updateAccess::parameters.body,
  "Request body parameters to update access."
);
@@doc(
  Applications.listTokens::parameters.body,
  "Request body parameters to list tokens."
);
