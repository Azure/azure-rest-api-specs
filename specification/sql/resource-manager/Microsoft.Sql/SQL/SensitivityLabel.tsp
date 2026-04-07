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
    NamePattern = ""
  >;

  /**
   * Resource that manages the sensitivity label.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  {}
>;

@armResourceOperations(#{ omitTags: true })
interface SensitivityLabels {
  /**
   * Gets the sensitivity label of a given column
   */
  @tag("ManagedDatabaseSensitivityLabels")
  get is SensitivityLabelOps.Read<
    SensitivityLabel,
    Parameters = {
      /** The source of the sensitivity label. */
      @path
      @segment("sensitivityLabels")
      @key
      sensitivityLabelSource: SensitivityLabelSource;
    }
  >;

  /**
   * Creates or updates the sensitivity label of a given column
   */
  @tag("ManagedDatabaseSensitivityLabels")
  createOrUpdate is SensitivityLabelOps.CreateOrUpdateSync<
    SensitivityLabel,
    Parameters = {
      /** The source of the sensitivity label. */
      @path
      @segment("sensitivityLabels")
      @key
      sensitivityLabelSource: CurrentSensitivityLabelSource;
    }
  >;

  /**
   * Deletes the sensitivity label of a given column
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ManagedDatabaseSensitivityLabels")
  delete is SensitivityLabelOps.DeleteSync<
    SensitivityLabel,
    Response = ArmDeletedResponse,
    Parameters = {
      /** The source of the sensitivity label. */
      @path
      @segment("sensitivityLabels")
      @key
      sensitivityLabelSource: CurrentSensitivityLabelSource;
    }
  >;

  /**
   * Disables sensitivity recommendations on a given column
   */
  @tag("ManagedDatabaseSensitivityLabels")
  @action("disable")
  disableRecommendation is SensitivityLabelOps.ActionSync<
    SensitivityLabel,
    void,
    Response = OkResponse,
    Parameters = {
      /** The source of the sensitivity label. */
      @path
      @segment("sensitivityLabels")
      @key
      sensitivityLabelSource: RecommendedSensitivityLabelSource;
    }
  >;

  /**
   * Enables sensitivity recommendations on a given column (recommendations are enabled by default on all columns)
   */
  @tag("ManagedDatabaseSensitivityLabels")
  @action("enable")
  enableRecommendation is SensitivityLabelOps.ActionSync<
    SensitivityLabel,
    void,
    Response = OkResponse,
    Parameters = {
      /** The source of the sensitivity label. */
      @path
      @segment("sensitivityLabels")
      @key
      sensitivityLabelSource: RecommendedSensitivityLabelSource;
    }
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
  {}
>;

@armResourceOperations(#{ omitTags: true })
interface SensitivityLabelOperationGroup {
  /**
   * Gets the sensitivity label of a given column
   */
  @tag("SensitivityLabels")
  get is SensitivityLabelOperationGroupOps.Read<
    SensitivityLabel,
    Parameters = {
      /** The source of the sensitivity label. */
      @path
      @segment("sensitivityLabels")
      @key
      sensitivityLabelSource: SensitivityLabelSource;
    }
  >;

  /**
   * Creates or updates the sensitivity label of a given column
   */
  @tag("SensitivityLabels")
  createOrUpdate is SensitivityLabelOperationGroupOps.CreateOrUpdateSync<
    SensitivityLabel,
    Parameters = {
      /** The source of the sensitivity label. */
      @path
      @segment("sensitivityLabels")
      @key
      sensitivityLabelSource: CurrentSensitivityLabelSource;
    }
  >;

  /**
   * Deletes the sensitivity label of a given column
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("SensitivityLabels")
  delete is SensitivityLabelOperationGroupOps.DeleteSync<
    SensitivityLabel,
    Response = ArmDeletedResponse,
    Parameters = {
      /** The source of the sensitivity label. */
      @path
      @segment("sensitivityLabels")
      @key
      sensitivityLabelSource: CurrentSensitivityLabelSource;
    }
  >;

  /**
   * Disables sensitivity recommendations on a given column
   */
  @tag("SensitivityLabels")
  @action("disable")
  disableRecommendation is SensitivityLabelOperationGroupOps.ActionSync<
    SensitivityLabel,
    void,
    Response = OkResponse,
    Parameters = {
      /** The source of the sensitivity label. */
      @path
      @segment("sensitivityLabels")
      @key
      sensitivityLabelSource: RecommendedSensitivityLabelSource;
    }
  >;

  /**
   * Enables sensitivity recommendations on a given column (recommendations are enabled by default on all columns)
   */
  @tag("SensitivityLabels")
  @action("enable")
  enableRecommendation is SensitivityLabelOperationGroupOps.ActionSync<
    SensitivityLabel,
    void,
    Response = OkResponse,
    Parameters = {
      /** The source of the sensitivity label. */
      @path
      @segment("sensitivityLabels")
      @key
      sensitivityLabelSource: RecommendedSensitivityLabelSource;
    }
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
