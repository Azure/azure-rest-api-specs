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
model DtlEnvironment
  is Azure.ResourceManager.TrackedResource<EnvironmentProperties, false> {
  ...ResourceNameParameter<
    Resource = DtlEnvironment,
    KeyName = "name",
    SegmentName = "environments",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DtlEnvironments {
  /**
   * Get environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Environments_Get")
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
  @operationId("Environments_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DtlEnvironment,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Allows modifying tags of environments. All other properties will be ignored.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("Environments_Update")
  update is ArmTagsPatchAsync<DtlEnvironment>;

  /**
   * Delete environment. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Environments_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    DtlEnvironment,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List environments in a given user profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Environments_List")
  list is ArmResourceListByParent<
    DtlEnvironment,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=deploymentProperties)'
       */
      @query("$expand")
      $expand?: string;

      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')'
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
@@doc(DtlEnvironment.properties, "The properties of the resource.");
@@doc(DtlEnvironments.createOrUpdate::parameters.resource,
  "An environment, which is essentially an ARM template deployment."
);
@@doc(DtlEnvironments.update::parameters.properties,
  "Allows modifying tags of environments. All other properties will be ignored."
);
