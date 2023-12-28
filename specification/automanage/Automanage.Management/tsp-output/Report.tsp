import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ConfigurationProfileAssignment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Automanage;
@doc("Definition of the report.")
@parentResource(ConfigurationProfileAssignment)
model Report is ProxyResource<AssignmentReportProperties> {
  @doc("The report name.")
  @key("reportName")
  @segment("reports")
  name: string;
}

@armResourceOperations
interface reports {
  @doc("Get information about a report associated with a configuration profile assignment run")
  get is ArmResourceRead<Report>;
  @doc("Retrieve a list of reports within a given configuration profile assignment")
  listByConfigurationProfileAssignments is ArmResourceListByParent<Report>;
}
