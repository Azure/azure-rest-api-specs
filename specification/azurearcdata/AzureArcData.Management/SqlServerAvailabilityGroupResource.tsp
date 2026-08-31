import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SqlServerInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureArcData;
/**
 * Arc Sql Server Availability Group
 */
@parentResource(SqlServerInstance)
model SqlServerAvailabilityGroupResource
  is Azure.ResourceManager.TrackedResource<
    SqlServerAvailabilityGroupResourceProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = SqlServerAvailabilityGroupResource,
    KeyName = "availabilityGroupName",
    SegmentName = "availabilityGroups",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SqlServerAvailabilityGroupResources {
  /**
   * Retrieves an Arc Sql Server availability group.
   */
  get is ArmResourceRead<SqlServerAvailabilityGroupResource>;

  /**
   * Creates or replaces an Arc Sql Server Availability Group.
   */
  create is ArmResourceCreateOrReplaceSync<SqlServerAvailabilityGroupResource>;

  /**
   * Updates an existing Availability Group.
   */
  @patch(#{ implicitOptionality: false })
  @Azure.Core.useFinalStateVia("azure-async-operation")
  update is ArmCustomPatchAsync<
    SqlServerAvailabilityGroupResource,
    PatchModel = SqlServerAvailabilityGroupUpdate,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = SqlServerAvailabilityGroupResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes an Arc Sql Server availability group resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<SqlServerAvailabilityGroupResource>;

  /**
   * List the availability group associated with the given Arc Sql Server.
   */
  @summary("List the availability group associated with the given Arc Sql Server.")
  list is ArmResourceListByParent<
    SqlServerAvailabilityGroupResource,
    Response = ArmResponse<ArcSqlServerAvailabilityGroupListResult>
  >;

  /**
   * Retrieves detailed properties of the Availability Group.
   */
  @action("getDetailView")
  detailView is ArmResourceActionSync<
    SqlServerAvailabilityGroupResource,
    void,
    ArmResponse<SqlServerAvailabilityGroupResource>
  >;

  /**
   * Request manual failover of the availability group to this server.
   */
  failover is ArmResourceActionSync<
    SqlServerAvailabilityGroupResource,
    void,
    ArmResponse<SqlServerAvailabilityGroupResource>
  >;

  /**
   * Request forced failover of the availability group to this server.
   */
  forceFailoverAllowDataLoss is ArmResourceActionSync<
    SqlServerAvailabilityGroupResource,
    void,
    ArmResponse<SqlServerAvailabilityGroupResource>
  >;

  /**
   * Request adding database(s) to an existing availability group.
   */
  addDatabases is ArmResourceActionSync<
    SqlServerAvailabilityGroupResource,
    databases,
    ArmResponse<SqlServerAvailabilityGroupResource>
  >;

  /**
   * Request failover of Arc Sql Server to Azure Managed Instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @operationId("SqlServerAvailabilityGroups_failoverMiLink")
  failoverMiLink is ArmResourceActionAsync<
    SqlServerAvailabilityGroupResource,
    FailoverMiLinkResourceId,
    ArmResponse<SqlServerAvailabilityGroupResource>,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = SqlServerAvailabilityGroupResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the MI Link between an Azure Arc-enabled SQL Server and an Azure SQL Managed Instance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @operationId("SqlServerAvailabilityGroups_deleteMiLink")
  deleteMiLink is ArmResourceActionAsyncBase<
    SqlServerAvailabilityGroupResource,
    void,
    ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<SqlServerAvailabilityGroupResource>
  >;

  /**
   * Request removing database(s) from an existing availability group.
   */
  removeDatabases is ArmResourceActionSync<
    SqlServerAvailabilityGroupResource,
    databases,
    ArmResponse<SqlServerAvailabilityGroupResource>
  >;
}

@@doc(
  SqlServerAvailabilityGroupResource.name,
  "Name of SQL Availability Group"
);
@@doc(
  SqlServerAvailabilityGroupResource.properties,
  "Properties of Arc Sql Server availability group"
);
@@doc(
  SqlServerAvailabilityGroupResources.create::parameters.resource,
  "The request body for availability group resource."
);
@@doc(
  SqlServerAvailabilityGroupResources.update::parameters.properties,
  "The requested server availability group resource state."
);
@@doc(
  SqlServerAvailabilityGroupResources.addDatabases::parameters.body,
  "The database names to add to the SQL Server availability group resource."
);
@@doc(
  SqlServerAvailabilityGroupResources.failoverMiLink::parameters.body,
  "The azure resource identifier for the Sql Managed Instance."
);
@@doc(
  SqlServerAvailabilityGroupResources.removeDatabases::parameters.body,
  "The database names to remove from the SQL Server availability group resource."
);
