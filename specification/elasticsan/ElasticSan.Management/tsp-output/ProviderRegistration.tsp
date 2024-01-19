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
  @doc("The name of the resource provider hosted within ProviderHub.")
  @path
  @key("providerNamespace")
  @segment("providerRegistrations")
  name: string;
}

@armResourceOperations
interface ProviderRegistrations {
  @doc("Gets the provider registration details.")
  get is ArmResourceRead<ProviderRegistration>;

  @doc("Creates or updates the provider registration.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ProviderRegistration,
    BaseParameters<ProviderRegistration>,
    ArmAsyncOperationHeader
  >;

  @doc("Deletes a provider registration.")
  delete is ArmResourceDeleteSync<ProviderRegistration>;

  @doc("Gets the list of the provider registrations in the subscription.")
  list is ArmResourceListByParent<ProviderRegistration>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Generates the manifest for the given provider.")
  @operationId("GenerateManifest")
  generateManifest is ArmResourceActionSync<
    ProviderRegistration,
    void,
    ResourceProviderManifest
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Checkin the manifest.")
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
