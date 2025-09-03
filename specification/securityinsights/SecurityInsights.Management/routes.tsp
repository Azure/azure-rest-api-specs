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

@armVirtualResource
model EntityResource {
  ...ResourceNameParameter<
    Resource = EntityResource,
    KeyName = "entityIdentifier",
    SegmentName = "entities",
    NamePattern = "^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$"
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface EntitiesOperationGroup {
  /**
   * Triggers playbook on a specific entity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Entities_RunPlaybook")
  @autoRoute
  runPlaybook is Extension.ActionSync<OperationalInsights, EntityResource, Request = EntityManualTriggerRequestBody, Response = void>;
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
  @autoRoute
  @action("createIndicator")
  createIndicator is Extension.ActionSync<
    OperationalInsights,
    ThreatIntelligenceMain,
    Request = ThreatIntelligenceIndicatorModel,
    Response = ThreatIntelligenceInformation
  >;
  /**
   * Query threat intelligence indicators as per filtering criteria.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ThreatIntelligenceIndicator_QueryIndicators")
  @autoRoute
  @action("queryIndicators")
  queryIndicators is Extension.ActionSync<
    OperationalInsights,
    ThreatIntelligenceMain,
    Request = ThreatIntelligenceFilteringCriteria,
    Response = ThreatIntelligenceInformationList,
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ThreatIntelligenceIndicatorMetricsOperationGroup {
  /**
   * Get threat intelligence indicators metrics (Indicators counts by Type, Threat Type, Source).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @autoRoute
  @get
  @action("metrics")
  list is Extension.ActionSync<
    OperationalInsights,
    ThreatIntelligenceMain,
    Request = void,
    Response = ThreatIntelligenceMetricsList,
  >;
}
