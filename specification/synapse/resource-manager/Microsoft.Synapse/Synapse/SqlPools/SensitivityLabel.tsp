import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SqlPoolColumn.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;
/**
 * A sensitivity label.
 */
@singleton("default")
@parentResource(SqlPoolColumn)
model SensitivityLabel
  is Azure.ResourceManager.ProxyResource<SensitivityLabelProperties> {
  ...ResourceNameParameter<
    Resource = SensitivityLabel,
    KeyName = "sensitivityLabel",
    SegmentName = "sensitivityLabels",
    NamePattern = ""
  >;

  /**
   * managed by
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  managedBy?: string;
}

@armResourceOperations
interface SensitivityLabels {
  /**
   * Gets the sensitivity label of a given column
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPoolSensitivityLabels_Get")
  get is ArmResourceRead<SensitivityLabel>;

  /**
   * Creates or updates the sensitivity label of a given column in a Sql pool
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPoolSensitivityLabels_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SensitivityLabel>;

  /**
   * Deletes the sensitivity label of a given column in a Sql pool
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPoolSensitivityLabels_Delete")
  delete is ArmResourceDeleteSync<SensitivityLabel>;
}

@@doc(SensitivityLabel.name, "");
@@doc(SensitivityLabel.properties, "Resource properties.");
@@doc(
  SensitivityLabels.createOrUpdate::parameters.resource,
  "The column sensitivity label resource."
);
