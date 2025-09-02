// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface EntitiesOperationGroup {
  /**
   * Triggers playbook on a specific entity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Entities_RunPlaybook")
  @autoRoute
  runPlaybook is ArmProviderActionSync<
    Request = EntityManualTriggerRequestBody,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the workspace.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
      @path
      @segment("workspaces")
      workspaceName: string;

      /**
       * Entity ID
       */
      @path
      @segment("entities")
      entityIdentifier: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface SourceControlOperationGroup {
  /**
   * Gets a list of repositories metadata.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SourceControl_listRepositories")
  @autoRoute
  listRepositories is ArmProviderActionSync<
    Request = RepositoryAccessProperties,
    Response = RepoList,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the workspace.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
      @path
      @segment("workspaces")
      workspaceName: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ThreatIntelligenceIndicatorOperationGroup {
  /**
   * Create a new threat intelligence indicator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ThreatIntelligenceIndicator_CreateIndicator")
  @autoRoute
  @action("threatIntelligence/main/createIndicator")
  createIndicator is ArmProviderActionSync<
    Request = ThreatIntelligenceIndicatorModel,
    Response = ThreatIntelligenceInformation,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the workspace.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
      @path
      @segment("workspaces")
      workspaceName: string;
    }
  >;
  /**
   * Query threat intelligence indicators as per filtering criteria.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ThreatIntelligenceIndicator_QueryIndicators")
  @autoRoute
  @action("threatIntelligence/main/queryIndicators")
  queryIndicators is ArmProviderActionSync<
    Request = ThreatIntelligenceFilteringCriteria,
    Response = ThreatIntelligenceInformationList,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the workspace.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
      @path
      @segment("workspaces")
      workspaceName: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ThreatIntelligenceIndicatorMetricsOperationGroup {
  /**
   * Get threat intelligence indicators metrics (Indicators counts by Type, Threat Type, Source).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ThreatIntelligenceIndicatorMetrics_List")
  @autoRoute
  @get
  @action("threatIntelligence/main/metrics")
  list is ArmProviderActionSync<
    Response = ThreatIntelligenceMetricsList,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the workspace.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
      @path
      @segment("workspaces")
      workspaceName: string;
    }
  >;
}
