import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using Microsoft.Monitor;

@@clientName(Azure.ResourceManager.CommonTypes.Origin,
  "ArmOrigin",
  "python,go"
);

// JavaScript SDK visibility workaround:
// For write operations whose body models contain server-side read-only properties,
// provide write-specific models that omit those fields so SDK users see a clean API.
// Pattern: https://github.com/Azure/azure-rest-api-specs/pull/40791
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API is defined in a separate spec for Microsoft.Monitor namespace (specification/monitor/resource-manager/Microsoft.Monitor/Operations)"
namespace Microsoft.Monitor {
  // ===== Issue create-specific models =====
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Write-specific model intentionally omits server-side read-only fields including provisioningState"
  @doc("Issue properties for create/update operations, omitting server-side read-only fields (investigations, investigationsCount, provisioningState).")
  model IssuePayloadCreate {
    @doc("The issue title")
    title: string;

    @doc("The issue status")
    status: Status;

    @doc("The issue severity")
    severity: string;

    @doc("The issue impact time (in UTC)")
    impactTime: utcDateTime;

    @added(Versions.v2025_10_03)
    @doc("The issue background information")
    background?: Background;
  }

  @parentResource(AzureMonitorWorkspaceResource)
  @doc("Issue resource for create/update operations.")
  model IssueResourceCreate
    is Azure.ResourceManager.ProxyResource<IssuePayloadCreate> {
    @doc("The name of the Issue")
    @key("issueName")
    @path
    @segment("issues")
    @pattern("^(?!-)[a-zA-Z0-9-]+[^-]$")
    name: string;
  }

  // ===== BackgroundVisualization write-specific model =====
  @added(Versions.v2025_10_03)
  @doc("Background visualization for write operations, omitting the server-side read-only 'origin' field.")
  model BackgroundVisualizationCreate {
    @doc("The background visualization content, in Adaptive Card format")
    visualization: string;
  }

  // ===== RelatedAlert / RelatedAlerts write-specific models =====
  @doc("Properties of an alert related to the issue for write operations, omitting server-side read-only fields (origin, addedAt, lastModifiedAt).")
  model RelatedAlertCreate {
    @doc("The alert ID")
    id: Azure.Core.armResourceIdentifier;

    @doc("The alerts's relevance status")
    relevance: Relevance;
  }

  @doc("A list of related alerts for write operations.")
  model RelatedAlertsCreate {
    @doc("A list of related alerts")
    value: RelatedAlertCreate[];
  }

  // ===== RelatedResource / RelatedResources write-specific models =====
  @doc("Properties of a resource related to the issue for write operations, omitting server-side read-only fields (origin, addedAt, lastModifiedAt).")
  model RelatedResourceCreate {
    @doc("The resource ID")
    id: Azure.Core.armResourceIdentifier;

    @doc("The resource's relevance status")
    relevance: Relevance;
  }

  @doc("A list of related resources for write operations.")
  model RelatedResourcesCreate {
    @doc("A list of related resources")
    value: RelatedResourceCreate[];
  }
}

@@alternateType(Issue.create::parameters.resource,
  IssueResourceCreate,
  "javascript"
);
@@alternateType(Issue.setBackgroundVisualization::parameters.body,
  BackgroundVisualizationCreate,
  "javascript"
);
@@alternateType(Issue.addOrUpdateAlerts::parameters.body,
  RelatedAlertsCreate,
  "javascript"
);
@@alternateType(Issue.addOrUpdateResources::parameters.body,
  RelatedResourcesCreate,
  "javascript"
);
