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
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,

        /** the provider namespace */
        @path
        @segment("providers")
        @key
        providerNamespace: "Microsoft.Compute",

        /** The name of the virtual machine. */
        @path
        @segment("virtualMachines")
        @key
        vmName: string,
      },
      {
        ...Extension.ExtensionProviderNamespace<Report>,

        /** The configuration profile assignment name. */
        @path
        @segment("configurationProfileAssignments")
        @key
        configurationProfileAssignmentName: string,
      },
      {
        ...Extension.ExtensionProviderNamespace<Report>,

        /** The configuration profile assignment name. */
        @path
        @segment("configurationProfileAssignments")
        @key
        configurationProfileAssignmentName: string,

        /** The report name. */
        @path
        @segment("reports")
        @key
        reportName: string,
      }
    > {}

@armResourceOperations
interface Reports {
  /**
   * Get information about a report associated with a configuration profile assignment run
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("reports_Get")
  get is ReportOps.Read<Report>;

  /**
   * Retrieve a list of reports within a given configuration profile assignment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("reports_ListByConfigurationProfileAssignments")
  listByConfigurationProfileAssignments is ReportOps.List<
    Report,
    Response = ArmResponse<ReportList>
  >;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface HCRPReportOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,

        /** the provider namespace */
        @path
        @segment("providers")
        @key
        providerNamespace: "Microsoft.HybridCompute",

        /** The name of the Arc machine. */
        @path
        @segment("machines")
        @key
        machineName: string,
      },
      {
        ...Extension.ExtensionProviderNamespace<Report>,

        /** The configuration profile assignment name. */
        @path
        @segment("configurationProfileAssignments")
        @key
        configurationProfileAssignmentName: string,
      },
      {
        ...Extension.ExtensionProviderNamespace<Report>,

        /** The configuration profile assignment name. */
        @path
        @segment("configurationProfileAssignments")
        @key
        configurationProfileAssignmentName: string,

        /** The report name. */
        @path
        @segment("reports")
        @key
        reportName: string,
      }
    > {}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface HCRPReports {
  /**
   * Get information about a report associated with a configuration profile assignment run
   */
  get is HCRPReportOps.Read<Report>;

  /**
   * Retrieve a list of reports within a given configuration profile assignment
   */
  listByConfigurationProfileAssignments is HCRPReportOps.List<
    Report,
    Response = ArmResponse<ReportList>
  >;
}
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface HCIReportOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,

        /** the provider namespace */
        @path
        @segment("providers")
        @key
        providerNamespace: "Microsoft.AzureStackHci",

        /** The name of the Arc machine. */
        @path
        @segment("clusters")
        @key
        clusterName: string,
      },
      {
        ...Extension.ExtensionProviderNamespace<Report>,

        /** The configuration profile assignment name. */
        @path
        @segment("configurationProfileAssignments")
        @key
        configurationProfileAssignmentName: string,
      },
      {
        ...Extension.ExtensionProviderNamespace<Report>,

        /** The configuration profile assignment name. */
        @path
        @segment("configurationProfileAssignments")
        @key
        configurationProfileAssignmentName: string,

        /** The report name. */
        @path
        @segment("reports")
        @key
        reportName: string,
      }
    > {}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface HCIReports {
  /**
   * Get information about a report associated with a configuration profile assignment run
   */
  get is HCIReportOps.Read<Report>;

  /**
   * Retrieve a list of reports within a given configuration profile assignment
   */
  listByConfigurationProfileAssignments is HCIReportOps.List<
    Report,
    Response = ArmResponse<ReportList>
  >;
}

@@doc(Report.name, "The report name.");
@@doc(Report.properties, "The properties for the report.");
@@summary(Report.properties, "Properties");
