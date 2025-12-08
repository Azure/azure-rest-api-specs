import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./Registry.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerRegistry;
/**
 * An object that represents a container registry.
 */
model Registry is Azure.ResourceManager.TrackedResource<RegistryProperties> {
  ...ResourceNameParameter<
    Resource = Registry,
    KeyName = "registryName",
    SegmentName = "registries",
    NamePattern = "^[a-zA-Z0-9]*$"
  >;

  /**
   * The SKU of the container registry.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku: Sku;

  /**
   * The identity of the container registry.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: IdentityProperties;
}

@armResourceOperations
interface Registries {
  /**
   * Gets the properties of the specified container registry.
   */
  get is ArmResourceRead<Registry>;

  /**
   * Creates a container registry with the specified parameters.
   */
  create is ArmResourceCreateOrReplaceAsync<Registry>;

  /**
   * Updates a container registry with the specified parameters.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Registry,
    PatchModel = RegistryUpdateParameters,
    Response = ArmResponse<Registry> | ArmResourceCreatedResponse<
      Registry,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = Registry> &
        Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Deletes a container registry.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Registry,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all the container registries under the specified resource group.
   */
  @list
  listByResourceGroup is ArmResourceListByParent<
    Registry,
    Response = ArmResponse<RegistryListResult>
  >;

  /**
   * Lists all the container registries under the specified subscription.
   */
  @list
  list is ArmListBySubscription<
    Registry,
    Response = ArmResponse<RegistryListResult>
  >;

  /**
   * Copies an image to this container registry from the specified container registry.
   */
  importImage is ArmResourceActionAsync<
    Registry,
    ImportImageParameters,
    {
      @body body: void;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets the quota usages for the specified container registry.
   */
  @get
  listUsages is ArmResourceActionSync<
    Registry,
    void,
    ArmResponse<RegistryUsageListResult>
  >;

  /**
   * Lists the login credentials for the specified container registry.
   */
  listCredentials is ArmResourceActionSync<
    Registry,
    void,
    ArmResponse<RegistryListCredentialsResult>
  >;

  /**
   * Regenerates one of the login credentials for the specified container registry.
   */
  regenerateCredential is ArmResourceActionSync<
    Registry,
    RegenerateCredentialParameters,
    ArmResponse<RegistryListCredentialsResult>
  >;

  /**
   * Generate keys for a token of a specified container registry.
   */
  generateCredentials is ArmResourceActionAsync<
    Registry,
    GenerateCredentialsParameters,
    GenerateCredentialsResult
  >;

  /**
   * Checks whether the container registry name is available for use. The name must contain only alphanumeric characters, be globally unique, and between 5 and 50 characters in length.
   */
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = RegistryNameCheckRequest,
    Response = RegistryNameStatus,
    Scope = SubscriptionActionScope
  >;
}

@@maxLength(Registry.name, 50);
@@minLength(Registry.name, 5);
@@doc(Registry.name, "The name of the container registry.");
@@doc(Registry.properties, "The properties of the container registry.");
@@doc(Registries.create::parameters.resource,
  "The parameters for creating a container registry."
);
@@doc(Registries.update::parameters.properties,
  "The parameters for updating a container registry."
);
@@doc(Registries.importImage::parameters.body,
  "The parameters specifying the image to copy and the source container registry."
);
@@doc(Registries.regenerateCredential::parameters.body,
  "Specifies name of the password which should be regenerated -- password or password2."
);
@@doc(Registries.generateCredentials::parameters.body,
  "The parameters for generating credentials."
);
