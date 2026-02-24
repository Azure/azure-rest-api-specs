import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Vault.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.KeyVault;
/**
 * Resource information with extended details.
 */
@parentResource(Vault)
model Secret is Azure.ResourceManager.ProxyResource<SecretProperties, false> {
  ...ResourceNameParameter<
    Resource = Secret,
    KeyName = "secretName",
    SegmentName = "secrets",
    NamePattern = ""
  >;

  /**
   * Azure location of the key vault resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * Tags assigned to the key vault resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface Secrets {
  /**
   * Gets the specified secret.  NOTE: This API is intended for internal use in ARM deployments. Users should use the data-plane REST service for interaction with vault secrets.
   */
  get is ArmResourceRead<Secret, Error = CloudError>;

  /**
   * Create or update a secret in a key vault in the specified subscription.  NOTE: This API is intended for internal use in ARM deployments. Users should use the data-plane REST service for interaction with vault secrets.
   */
  @armResourceCreateOrUpdate(Secret)
  createOrUpdate is Azure.ResourceManager.Foundations.ArmCreateOperation<
    ResourceInstanceParameters<
      Secret,
      Azure.ResourceManager.Foundations.DefaultBaseParameters<Secret>
    >,
    SecretCreateOrUpdateParameters,
    Response = ArmResponse<Secret> | ArmResourceCreatedSyncResponse<Secret>,
    ErrorResponse = CloudError
  >;

  /**
   * Update a secret in the specified subscription.  NOTE: This API is intended for internal use in ARM deployments.  Users should use the data-plane REST service for interaction with vault secrets.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Secret,
    PatchModel = SecretPatchParameters,
    Response = ArmResponse<Secret> | ArmResourceCreatedSyncResponse<Secret>,
    Error = CloudError
  >;

  /**
   * The List operation gets information about the secrets in a vault.  NOTE: This API is intended for internal use in ARM deployments. Users should use the data-plane REST service for interaction with vault secrets.
   */
  list is ArmResourceListByParent<
    Secret,
    Parameters = {
      /**
       * Maximum number of results to return.
       */
      @query("$top")
      $top?: int32;
    },
    Error = CloudError
  >;
}

@@doc(Secret.name, "The name of the secret.");
@@doc(Secret.properties, "Properties of the secret");
@@doc(Secrets.createOrUpdate::parameters.resource,
  "Parameters to create or update the secret"
);
@@doc(Secrets.update::parameters.properties, "Parameters to patch the secret");
