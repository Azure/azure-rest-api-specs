import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ConfigurationProfileAssignment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automanage;
@doc("Definition of the report.")
@parentResource(ConfigurationProfileAssignment)
model Report is ProxyResource<AssignmentReportProperties> {
  @doc("The report name.")
  @path
  @key("reportName")
  @segment("reports")
  name: string;
}

@armResourceOperations
interface Reports {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get information about a report associated with a configuration profile assignment run")
  @operationId("reports_Get")
  get is ArmResourceRead<Report>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve a list of reports within a given configuration profile assignment")
  @operationId("reports_ListByConfigurationProfileAssignments")
  listByConfigurationProfileAssignments is ArmResourceListByParent<Report>;
}
