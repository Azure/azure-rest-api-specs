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

namespace Microsoft.Sql;
/**
 * A sensitivity label.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(SensitivityLabelProperties)
@includeInapplicableMetadataInPayload(false)
model SensitivityLabel extends ProxyResource {
  /**
   * The source of the sensitivity label.
   */
  @path
  @key("sensitivityLabelSource")
  @segment("sensitivityLabels")
  name: SensitivityLabelSource;

  /**
   * Resource that manages the sensitivity label.
   */
  @visibility("read")
  managedBy?: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SensitivityLabelProperties;
}

@armResourceOperations
interface SensitivityLabels {
  /**
   * Gets the sensitivity label of a given column
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedDatabaseSensitivityLabels_Get")
  get is ArmResourceRead<SensitivityLabel>;

  /**
   * Creates or updates the sensitivity label of a given column
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedDatabaseSensitivityLabels_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SensitivityLabel>;

  /**
   * Deletes the sensitivity label of a given column
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedDatabaseSensitivityLabels_Delete")
  delete is ArmResourceDeleteSync<SensitivityLabel>;
}

@@projectedName(SensitivityLabels.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(SensitivityLabels.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(SensitivityLabels.createOrUpdate::parameters.resource,
  "The column sensitivity label resource."
);
