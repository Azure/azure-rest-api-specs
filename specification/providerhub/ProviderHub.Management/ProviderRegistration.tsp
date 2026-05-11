import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ProviderHub;

@subscriptionResource
model ProviderRegistration
  is Azure.ResourceManager.ProxyResource<ProviderRegistrationProperties> {
  ...ResourceNameParameter<
    Resource = ProviderRegistration,
    KeyName = "providerNamespace",
    SegmentName = "providerRegistrations",
    NamePattern = ""
  >;

  /**
   * Provider registration kind. This Metadata is also used by portal/tooling/etc to render different UX experiences for resources of the same type.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: ProviderRegistrationKind = ProviderRegistrationKind.Managed;
}

@armResourceOperations
interface ProviderRegistrations {
  /**
   * Gets the provider registration details.
   */
  get is ArmResourceRead<
    ProviderRegistration,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Creates or updates the provider registration.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ProviderRegistration,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Deletes a provider registration.
   */
  delete is ArmResourceDeleteSync<
    ProviderRegistration,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Gets the list of the provider registrations in the subscription.
   */
  list is ArmResourceListByParent<
    ProviderRegistration,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<ProviderRegistrationArrayResponseWithContinuation>
  >;

  /**
   * Generates the manifest for the given provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  generateManifest is ArmResourceActionSync<
    ProviderRegistration,
    void,
    ArmResponse<ResourceProviderManifest>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Checkin the manifest.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  checkinManifest is ArmResourceActionSync<
    ProviderRegistration,
    CheckinManifestParams,
    ArmResponse<CheckinManifestInfo>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Generates the operations api for the given provider.
   */
  generateOperations is ArmResourceActionSync<
    ProviderRegistration,
    void,
    ArmResponse<OperationsDefinition[]>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Deletes resources.
   */
  deleteResources is ArmResourceActionAsyncBase<
    ProviderRegistration,
    ResourceManagementAction,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * The resource action name.
       */
      @maxLength(63)
      @minLength(3)
      @pattern("^[a-z][a-z0-9]*$")
      @path
      @segment("resourceActions")
      resourceActionName: string;
    }
  >;

  /**
   * Generates the new region frontload manifest.
   */
  @action("generateNewRegionFrontloadManifest")
  newRegionFrontloadReleaseGenerateManifest is ArmResourceActionSync<
    ProviderRegistration,
    FrontloadPayload,
    ArmResponse<ResourceProviderManifest>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@doc(ProviderRegistration.name,
  "The name of the resource provider hosted within ProviderHub."
);
@@doc(ProviderRegistration.properties, "");
@@doc(ProviderRegistrations.createOrUpdate::parameters.resource,
  "The provider registration properties supplied to the CreateOrUpdate operation."
);
@@doc(ProviderRegistrations.checkinManifest::parameters.body,
  "The required body parameters supplied to the checkin manifest operation."
);
@@doc(ProviderRegistrations.deleteResources::parameters.body,
  "The properties supplied to the DeleteResources operation."
);
@@doc(ProviderRegistrations.newRegionFrontloadReleaseGenerateManifest::parameters.body,
  ""
);
