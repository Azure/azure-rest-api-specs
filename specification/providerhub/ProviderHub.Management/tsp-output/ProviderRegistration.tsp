import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ProviderHub;

@subscriptionResource
model ProviderRegistration is ProxyResource<ProviderRegistrationProperties> {
  /**
   * The name of the resource provider hosted within ProviderHub.
   */
  @path
  @key("providerNamespace")
  @segment("providerRegistrations")
  name: string;
}

@armResourceOperations
interface ProviderRegistrations {
  /**
   * Gets the provider registration details.
   */
  get is ArmResourceRead<ProviderRegistration>;

  /**
   * Creates or updates the provider registration.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ProviderRegistration,
    BaseParameters<ProviderRegistration>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes a provider registration.
   */
  delete is ArmResourceDeleteSync<ProviderRegistration>;

  /**
   * Gets the list of the provider registrations in the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ProviderRegistrations_List")
  list is ArmResourceListByParent<ProviderRegistration>;

  /**
   * Generates the manifest for the given provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GenerateManifest")
  generateManifest is ArmResourceActionSync<
    ProviderRegistration,
    void,
    ResourceProviderManifest
  >;

  /**
   * Checkin the manifest.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CheckinManifest")
  checkinManifest is ArmResourceActionSync<
    ProviderRegistration,
    CheckinManifestParams,
    CheckinManifestInfo
  >;
}

@@projectedName(ProviderRegistrations.createOrUpdate::parameters.resource,
  "json",
  "properties"
);
@@extension(ProviderRegistrations.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "properties"
);
@@doc(ProviderRegistrations.createOrUpdate::parameters.resource,
  "The provider registration properties supplied to the CreateOrUpdate operation."
);
@@projectedName(ProviderRegistrations.checkinManifest::parameters.body,
  "json",
  "checkinManifestParams"
);
@@extension(ProviderRegistrations.checkinManifest::parameters.body,
  "x-ms-client-name",
  "checkinManifestParams"
);
@@doc(ProviderRegistrations.checkinManifest::parameters.body,
  "The required body parameters supplied to the checkin manifest operation."
);
