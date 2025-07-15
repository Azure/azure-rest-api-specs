import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ConfigurationProfileAssignment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automanage;
/**
 * Definition of the report.
 */
@parentResource(ConfigurationProfileAssignment)
model Report
  is Azure.ResourceManager.ProxyResource<AssignmentReportProperties> {
  ...ResourceNameParameter<
    Resource = Report,
    KeyName = "reportName",
    SegmentName = "reports",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ReportOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** virtualMachines */
        @path @segment("virtualMachines") vmName: string,

        ...KeysOf<ResourceNameParameter<
          Resource = ConfigurationProfileAssignment,
          KeyName = "configurationProfileAssignmentName",
          SegmentName = "configurationProfileAssignments",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = Report,
        KeyName = "reportName",
        SegmentName = "reports",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface Reports {
  /**
   * Get information about a report associated with a configuration profile assignment run
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("reports_Get")
  get is ReportOps.Read<Report>;

  /**
   * Retrieve a list of reports within a given configuration profile assignment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("reports_ListByConfigurationProfileAssignments")
  listByConfigurationProfileAssignments is ReportOps.List<
    Report,
    Response = ArmResponse<ReportList>
  >;
}
@armResourceOperations
interface HCRPReportOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** machines */
        @path @segment("machines") machineName: string,

        ...KeysOf<ResourceNameParameter<
          Resource = ConfigurationProfileAssignment,
          KeyName = "configurationProfileAssignmentName",
          SegmentName = "configurationProfileAssignments",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = Report,
        KeyName = "reportName",
        SegmentName = "reports",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface HCRPReports {
  /**
   * Get information about a report associated with a configuration profile assignment run
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HCRPReports_Get")
  get is HCRPReportOps.Read<Report>;

  /**
   * Retrieve a list of reports within a given configuration profile assignment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HCRPReports_ListByConfigurationProfileAssignments")
  listByConfigurationProfileAssignments is HCRPReportOps.List<
    Report,
    Response = ArmResponse<ReportList>
  >;
}
@armResourceOperations
interface HCIReportOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** clusters */
        @path @segment("clusters") clusterName: string,

        ...KeysOf<ResourceNameParameter<
          Resource = ConfigurationProfileAssignment,
          KeyName = "configurationProfileAssignmentName",
          SegmentName = "configurationProfileAssignments",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = Report,
        KeyName = "reportName",
        SegmentName = "reports",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface HCIReports {
  /**
   * Get information about a report associated with a configuration profile assignment run
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HCIReports_Get")
  get is HCIReportOps.Read<Report>;

  /**
   * Retrieve a list of reports within a given configuration profile assignment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("HCIReports_ListByConfigurationProfileAssignments")
  listByConfigurationProfileAssignments is HCIReportOps.List<
    Report,
    Response = ArmResponse<ReportList>
  >;
}

@@doc(Report.name, "The report name.");
@@doc(Report.properties, "The properties for the report.");
