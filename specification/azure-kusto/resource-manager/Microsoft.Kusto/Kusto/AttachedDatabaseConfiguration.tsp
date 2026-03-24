import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Kusto;
/**
 * Class representing an attached database configuration.
 */
@parentResource(Cluster)
model AttachedDatabaseConfiguration
  is Azure.ResourceManager.ProxyResource<AttachedDatabaseConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = AttachedDatabaseConfiguration,
    KeyName = "attachedDatabaseConfigurationName",
    SegmentName = "attachedDatabaseConfigurations",
    NamePattern = "^.*$"
  >;

  /**
   * Resource location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;
}

@armResourceOperations
interface AttachedDatabaseConfigurations {
  /**
   * Returns an attached database configuration.
   */
  get is ArmResourceRead<AttachedDatabaseConfiguration>;

  /**
   * Creates or updates an attached database configuration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AttachedDatabaseConfiguration,
    Response = ArmResourceUpdatedResponse<AttachedDatabaseConfiguration> | ArmResourceCreatedResponse<AttachedDatabaseConfiguration> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = AttachedDatabaseConfiguration> &
      ArmAsyncOperationHeader<FinalResult = AttachedDatabaseConfiguration> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: AttachedDatabaseConfiguration;
    })
  >;

  /**
   * Deletes the attached database configuration with the given name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    AttachedDatabaseConfiguration,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader &
      ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Returns the list of attached database configurations of the given Kusto cluster.
   */
  listByCluster is ArmResourceListByParent<
    AttachedDatabaseConfiguration,
    Response = ArmResponse<AttachedDatabaseConfigurationListResult>
  >;
}

@@doc(AttachedDatabaseConfiguration.name,
  "The name of the attached database configuration."
);
@@doc(AttachedDatabaseConfiguration.properties,
  "The properties of the attached database configuration."
);
@@doc(AttachedDatabaseConfigurations.createOrUpdate::parameters.resource,
  "The database parameters supplied to the CreateOrUpdate operation."
);
