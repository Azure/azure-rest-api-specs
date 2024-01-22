import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./User.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
/**
 * A secret.
 */
@parentResource(User)
model Secret is TrackedResource<SecretProperties> {
  /**
   * The name of the secret.
   */
  @path
  @key("name")
  @segment("secrets")
  name: string;
}

@armResourceOperations
interface Secrets {
  /**
   * Get secret.
   */
  get is ArmResourceRead<
    Secret,
    {
      ...BaseParameters<Secret>;

      /**
       * Specify the $expand query. Example: 'properties($select=value)'
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Create or replace an existing secret. This operation can take a while to complete.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Secret>;

  /**
   * Allows modifying tags of secrets. All other properties will be ignored.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<Secret, SecretFragment>;

  /**
   * Delete secret.
   */
  delete is ArmResourceDeleteSync<Secret>;

  /**
   * List secrets in a given user profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Secrets_List")
  list is ArmResourceListByParent<
    Secret,
    {
      ...BaseParameters<Secret>;

      /**
       * Specify the $expand query. Example: 'properties($select=value)'
       */
      @query("$expand")
      $expand?: string;

      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')
       */
      @query("$filter")
      $filter?: string;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'
       */
      @query("$top")
      $top?: int32;

      /**
       * The ordering expression for the results, using OData notation. Example: '$orderby=name desc'
       */
      @query("$orderby")
      $orderby?: string;
    }
  >;
}

@@projectedName(Secrets.createOrUpdate::parameters.resource, "json", "secret");
@@extension(Secrets.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "secret"
);
@@doc(Secrets.createOrUpdate::parameters.resource, "A secret.");
@@projectedName(Secrets.update::parameters.properties, "json", "secret");
@@extension(Secrets.update::parameters.properties,
  "x-ms-client-name",
  "secret"
);
@@doc(Secrets.update::parameters.properties, "A secret.");
