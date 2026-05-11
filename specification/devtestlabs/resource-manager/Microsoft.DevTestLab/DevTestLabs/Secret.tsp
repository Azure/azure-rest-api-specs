import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
/**
 * A secret.
 */
@parentResource(User)
model Secret is Azure.ResourceManager.ProxyResource<SecretProperties, false> {
  ...ResourceNameParameter<
    Resource = Secret,
    KeyName = "secretName",
    SegmentName = "secrets",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Day 0 Property"
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface Secrets {
  /**
   * Get secret.
   */
  get is ArmResourceRead<
    Secret,
    Parameters = {
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Secret,
    LroHeaders = ArmLroLocationHeader<FinalResult = Secret> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Allows modifying tags of secrets. All other properties will be ignored.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "Already contains tags"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Secret, PatchModel = SecretFragment>;

  /**
   * Delete secret.
   */
  delete is ArmResourceDeleteSync<Secret>;

  /**
   * List secrets in a given user profile.
   */
  list is ArmResourceListByParent<
    Secret,
    Parameters = {
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
    },
    Response = ArmResponse<SecretList>
  >;
}

@@doc(Secret.name, "The name of the secret.");
@@doc(Secret.properties, "The properties of the resource.");
@@doc(Secrets.createOrUpdate::parameters.resource, "A secret.");
@@doc(Secrets.update::parameters.properties, "A secret.");
