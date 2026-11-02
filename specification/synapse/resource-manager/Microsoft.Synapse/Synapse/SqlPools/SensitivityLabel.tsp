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

namespace SqlPools;
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

alias SensitivityLabelReadOps = Azure.ResourceManager.Legacy.LegacyOperations<
  SqlPoolColumnParentParameters,
  {
    /** The source of the sensitivity label. */
    @segment("sensitivityLabels")
    @key
    @path
    sensitivityLabelSource: SensitivityLabelSource;
  }
>;

alias SensitivityLabelWriteOps = Azure.ResourceManager.Legacy.LegacyOperations<
  SqlPoolColumnParentParameters,
  {
    /** The source of the sensitivity label. */
    @segment("sensitivityLabels")
    @key
    @path
    sensitivityLabelSource: WritableSensitivityLabelSource;
  }
>;

alias SensitivityLabelRecommendationOps = Azure.ResourceManager.Legacy.LegacyOperations<
  SqlPoolColumnParentParameters,
  {
    /** The source of the sensitivity label. */
    @segment("sensitivityLabels")
    @key
    @path
    sensitivityLabelSource: RecommendedSensitivityLabelSource;
  }
>;

@armResourceOperations
interface SensitivityLabels {
  /**
   * Gets the sensitivity label of a given column
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPoolSensitivityLabels_Get")
  get is SensitivityLabelReadOps.Read<SensitivityLabel>;

  /**
   * Creates or updates the sensitivity label of a given column in a Sql pool
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPoolSensitivityLabels_CreateOrUpdate")
  createOrUpdate is SensitivityLabelWriteOps.CreateOrUpdateSync<SensitivityLabel>;

  /**
   * Deletes the sensitivity label of a given column in a Sql pool
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPoolSensitivityLabels_Delete")
  delete is SensitivityLabelWriteOps.DeleteSync<SensitivityLabel>;
}

@@doc(SensitivityLabel.name, "");
@@doc(SensitivityLabel.properties, "Resource properties.");
@@doc(
  SensitivityLabels.createOrUpdate::parameters.resource,
  "The column sensitivity label resource."
);
