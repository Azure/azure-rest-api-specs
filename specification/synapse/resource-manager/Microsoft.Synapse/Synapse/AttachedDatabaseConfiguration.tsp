import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./KustoPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;
/**
 * Class representing an attached database configuration.
 */
@parentResource(KustoPool)
model AttachedDatabaseConfiguration
  is Azure.ResourceManager.ProxyResource<AttachedDatabaseConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = AttachedDatabaseConfiguration,
    KeyName = "attachedDatabaseConfigurationName",
    SegmentName = "attachedDatabaseConfigurations",
    NamePattern = ""
  >;

  /**
   * Resource location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  location?: string;
}

@armResourceOperations
interface AttachedDatabaseConfigurations {
  /**
   * Returns an attached database configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoPoolAttachedDatabaseConfigurations_Get")
  get is ArmResourceRead<AttachedDatabaseConfiguration>;

  /**
   * Creates or updates an attached database configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("KustoPoolAttachedDatabaseConfigurations_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AttachedDatabaseConfiguration,
    Response =
      | ArmResourceUpdatedResponse<AttachedDatabaseConfiguration>
      | ArmResourceCreatedResponse<
          AttachedDatabaseConfiguration,
          ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
        >
      | (ArmAcceptedLroResponse & {
          @bodyRoot
          _: AttachedDatabaseConfiguration;
        })
  >;

  /**
   * Deletes the attached database configuration with the given name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("KustoPoolAttachedDatabaseConfigurations_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    AttachedDatabaseConfiguration,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * Returns the list of attached database configurations of the given Kusto Pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoPoolAttachedDatabaseConfigurations_ListByKustoPool")
  listByKustoPool is ArmResourceListByParent<
    AttachedDatabaseConfiguration,
    Response = ArmResponse<AttachedDatabaseConfigurationListResult>
  >;
}

@@doc(
  AttachedDatabaseConfiguration.name,
  "The name of the attached database configuration."
);
@@doc(
  AttachedDatabaseConfiguration.properties,
  "The properties of the attached database configuration."
);
@@doc(
  AttachedDatabaseConfigurations.createOrUpdate::parameters.resource,
  "The database parameters supplied to the CreateOrUpdate operation."
);
