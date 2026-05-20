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
 * An environment, which is essentially an ARM template deployment.
 */
@parentResource(User)
model DtlEnvironment
  is Azure.ResourceManager.ProxyResource<EnvironmentProperties, false> {
  ...ResourceNameParameter<
    Resource = DtlEnvironment,
    KeyName = "environmentName",
    SegmentName = "environments",
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
interface Environments {
  /**
   * Get environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  get is ArmResourceRead<
    DtlEnvironment,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=deploymentProperties)'
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Create or replace an existing environment. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DtlEnvironment,
    LroHeaders = ArmLroLocationHeader<FinalResult = DtlEnvironment> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Allows modifying tags of environments. All other properties will be ignored.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "Already contains tags"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    DtlEnvironment,
    PatchModel = DtlEnvironmentFragment
  >;

  /**
   * Delete environment. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    DtlEnvironment,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List environments in a given user profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  list is ArmResourceListByParent<
    DtlEnvironment,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=deploymentProperties)'
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
    Response = ArmResponse<DtlEnvironmentList>
  >;
}

@@doc(DtlEnvironment.name, "The name of the environment.");
@@doc(DtlEnvironment.properties, "The properties of the environment.");
@@doc(Environments.createOrUpdate::parameters.resource,
  "An environment, which is essentially an ARM template deployment."
);
@@doc(Environments.update::parameters.properties,
  "An environment, which is essentially an ARM template deployment."
);
