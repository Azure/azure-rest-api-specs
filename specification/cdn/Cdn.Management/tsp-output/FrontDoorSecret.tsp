import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Profile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Cdn;
/**
 * Friendly Secret name mapping to the any Secret or secret related information.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Profile)
@includeInapplicableMetadataInPayload(false)
model FrontDoorSecret extends ProxyResource {
  /**
   * Name of the Secret under the profile.
   */
  @path
  @key("secretName")
  @segment("secrets")
  @visibility("read")
  name: string;

  /**
   * The JSON object that contains the properties of the Secret to create.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SecretDetails;
}

@armResourceOperations
interface FrontDoorSecrets {
  /**
   * Gets an existing Secret within a profile.
   */
  get is ArmResourceRead<FrontDoorSecret>;

  /**
   * Creates a new Secret within the specified profile.
   */
  create is ArmResourceCreateOrReplaceAsync<
    FrontDoorSecret,
    BaseParameters<FrontDoorSecret>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes an existing Secret within profile.
   */
  delete is ArmResourceDeleteAsync<
    FrontDoorSecret,
    BaseParameters<FrontDoorSecret>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists existing AzureFrontDoor secrets.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FrontDoorSecrets_ListByProfile")
  listByProfile is ArmResourceListByParent<FrontDoorSecret>;
}

@@projectedName(FrontDoorSecrets.create::parameters.resource, "json", "secret");
@@extension(FrontDoorSecrets.create::parameters.resource,
  "x-ms-client-name",
  "secret"
);
@@doc(FrontDoorSecrets.create::parameters.resource, "The Secret properties.");
