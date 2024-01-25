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
/**
 * Definition of the report.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ConfigurationProfileAssignment)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(AssignmentReportProperties)
model Report extends ProxyResourceBase {
  /**
   * The report name.
   */
  @path
  @key("reportName")
  @segment("reports")
  @visibility("read")
  name: string;

  /**
   * The properties for the report.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AssignmentReportProperties;
}

@armResourceOperations
interface Reports {
  /**
   * Get information about a report associated with a configuration profile assignment run
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("reports_Get")
  get is ArmResourceRead<Report>;

  /**
   * Retrieve a list of reports within a given configuration profile assignment
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("reports_ListByConfigurationProfileAssignments")
  listByConfigurationProfileAssignments is ArmResourceListByParent<Report>;
}
