import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Migrate;

// JavaScript SDK: use update-specific models for AssessmentProjectsOperations.update to exclude
// server-side read-only fields (e.g. provisioningState, createdTimestamp, updatedTimestamp,
// serviceEndpoint, privateEndpointConnections)

@doc("The updatable properties of an Assessment Project.")
model ProjectUpdateProperties {
  @doc("Assessment solution ARM id tracked by Microsoft.Migrate/migrateProjects.")
  assessmentSolutionId?: string;

  @doc("Assessment project status.")
  projectStatus?: ProjectStatus;

  @doc("The ARM id of service map workspace created by customer.")
  customerWorkspaceId?: string;

  @doc("Location of service map workspace created by customer.")
  customerWorkspaceLocation?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  @doc("""
    This value can be set to 'enabled' to avoid breaking changes on existing
    customer resources and templates. If set to 'disabled', traffic over public
    interface is not allowed, and private endpoint connections would be the
    exclusive access method.
    """)
  publicNetworkAccess?: string;

  @doc("""
    The ARM id of the storage account used for interactions when public access is
    disabled.
    """)
  customerStorageAccountArmId?: string;
}

@doc("An Assessment Project update resource.")
model AssessmentProjectUpdate {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The resource-specific properties for this resource.")
  properties?: ProjectUpdateProperties;
}

@@alternateType(
  Microsoft.Migrate.AssessmentProjectsOperations.update::parameters.properties,
  AssessmentProjectUpdate,
  "javascript"
);
