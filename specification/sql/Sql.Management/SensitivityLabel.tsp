import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DatabaseColumn.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A sensitivity label.
 */
@parentResource(DatabaseColumn)
model SensitivityLabel
  is Azure.ResourceManager.ProxyResource<SensitivityLabelProperties> {
  ...ResourceNameParameter<
    Resource = SensitivityLabel,
    KeyName = "sensitivityLabelSource",
    SegmentName = "sensitivityLabels",
    NamePattern = "",
    Type = SensitivityLabelSource
  >;

  /**
   * Resource that manages the sensitivity label.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  managedBy?: string;
}

alias SensitivityLabelOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the managed instance. */
    @path
    @segment("managedInstances")
    @key
    managedInstanceName: string;

    /** The name of the database. */
    @path
    @segment("databases")
    @key
    databaseName: string;

    /** The name of the schema. */
    @path
    @segment("schemas")
    @key
    schemaName: string;

    /** The name of the table. */
    @path
    @segment("tables")
    @key
    tableName: string;

    /** The name of the column. */
    @path
    @segment("columns")
    @key
    columnName: string;
  },
  {
    /** The source of the sensitivity label. */
    @path
    @segment("sensitivityLabels")
    @key
    sensitivityLabelSource: string;
  }
>;

@armResourceOperations
interface SensitivityLabels {
  /**
   * Gets the sensitivity label of a given column
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedDatabaseSensitivityLabels_Get")
  get is SensitivityLabelOps.Read<SensitivityLabel>;

  /**
   * Creates or updates the sensitivity label of a given column
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedDatabaseSensitivityLabels_CreateOrUpdate")
  createOrUpdate is SensitivityLabelOps.CreateOrUpdateSync<SensitivityLabel>;

  /**
   * Deletes the sensitivity label of a given column
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("ManagedDatabaseSensitivityLabels_Delete")
  delete is SensitivityLabelOps.DeleteSync<
    SensitivityLabel,
    Response = ArmDeletedResponse
  >;

  /**
   * Disables sensitivity recommendations on a given column
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedDatabaseSensitivityLabels_DisableRecommendation")
  @action("disable")
  disableRecommendation is SensitivityLabelOps.ActionSync<
    SensitivityLabel,
    void,
    OkResponse
  >;

  /**
   * Enables sensitivity recommendations on a given column (recommendations are enabled by default on all columns)
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedDatabaseSensitivityLabels_EnableRecommendation")
  @action("enable")
  enableRecommendation is SensitivityLabelOps.ActionSync<
    SensitivityLabel,
    void,
    OkResponse
  >;
}
alias SensitivityLabelOperationGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the server. */
    @path
    @segment("servers")
    @key
    serverName: string;

    /** The name of the database. */
    @path
    @segment("databases")
    @key
    databaseName: string;

    /** The name of the schema. */
    @path
    @segment("schemas")
    @key
    schemaName: string;

    /** The name of the table. */
    @path
    @segment("tables")
    @key
    tableName: string;

    /** The name of the column. */
    @path
    @segment("columns")
    @key
    columnName: string;
  },
  {
    /** The source of the sensitivity label. */
    @path
    @segment("sensitivityLabels")
    @key
    sensitivityLabelSource: string;
  }
>;

@armResourceOperations
interface SensitivityLabelOperationGroup {
  /**
   * Gets the sensitivity label of a given column
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SensitivityLabels_Get")
  get is SensitivityLabelOperationGroupOps.Read<SensitivityLabel>;

  /**
   * Creates or updates the sensitivity label of a given column
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SensitivityLabels_CreateOrUpdate")
  createOrUpdate is SensitivityLabelOperationGroupOps.CreateOrUpdateSync<SensitivityLabel>;

  /**
   * Deletes the sensitivity label of a given column
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("SensitivityLabels_Delete")
  delete is SensitivityLabelOperationGroupOps.DeleteSync<
    SensitivityLabel,
    Response = ArmDeletedResponse
  >;

  /**
   * Disables sensitivity recommendations on a given column
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SensitivityLabels_DisableRecommendation")
  @action("disable")
  disableRecommendation is SensitivityLabelOperationGroupOps.ActionSync<
    SensitivityLabel,
    void,
    OkResponse
  >;

  /**
   * Enables sensitivity recommendations on a given column (recommendations are enabled by default on all columns)
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SensitivityLabels_EnableRecommendation")
  @action("enable")
  enableRecommendation is SensitivityLabelOperationGroupOps.ActionSync<
    SensitivityLabel,
    void,
    OkResponse
  >;
}

@@doc(SensitivityLabel.name, "The source of the sensitivity label.");
@@doc(SensitivityLabel.properties, "Resource properties.");
@@doc(SensitivityLabels.createOrUpdate::parameters.resource,
  "The column sensitivity label resource."
);
@@doc(SensitivityLabelOperationGroup.createOrUpdate::parameters.resource,
  "The column sensitivity label resource."
);
