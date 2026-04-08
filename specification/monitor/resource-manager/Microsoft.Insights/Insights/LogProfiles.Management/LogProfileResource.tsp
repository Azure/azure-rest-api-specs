import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.LogProfiles;
/**
 * The log profile resource.
 */
@subscriptionResource
model LogProfileResource
  is Azure.ResourceManager.TrackedResource<LogProfileProperties, false> {
  ...ResourceNameParameter<
    Resource = LogProfileResource,
    KeyName = "logProfileName",
    SegmentName = "logprofiles",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface LogProfileResources {
  /**
   * Gets the log profile.
   */
  @tag("LogProfiles")
  get is ArmResourceRead<
    LogProfileResource,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = ErrorResponse
  >;

  /**
   * Create or update a log profile in Azure Monitoring REST API.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("LogProfiles")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    LogProfileResource,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResourceUpdatedResponse<LogProfileResource>,
    Error = ErrorResponse
  >;

  /**
   * Updates an existing LogProfilesResource. To update other fields use the CreateOrUpdate method.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    LogProfileResource,
    PatchModel = LogProfileResourcePatch,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = ErrorResponse
  >;

  /**
   * Deletes the log profile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("LogProfiles")
  delete is ArmResourceDeleteSync<
    LogProfileResource,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmDeletedResponse,
    Error = ErrorResponse
  >;

  /**
   * List the log profiles.
   */
  @tag("LogProfiles")
  list is ArmResourceListByParent<
    LogProfileResource,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<LogProfileCollection>,
    Error = ErrorResponse
  >;
}

@@doc(LogProfileResource.name, "The name of the log profile.");
@@doc(LogProfileResource.properties,
  "The log profile properties of the resource."
);
@@doc(LogProfileResources.createOrUpdate::parameters.resource,
  "Parameters supplied to the operation."
);
@@doc(LogProfileResources.update::parameters.properties,
  "Parameters supplied to the operation."
);
