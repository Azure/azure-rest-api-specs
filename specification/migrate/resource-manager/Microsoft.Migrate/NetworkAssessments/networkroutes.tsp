import "./Common/DataModels/DownloadUrl.tsp";
import "./Common/ArmModels/AssessmentProjectV2.tsp";
import "./WebModels/NetworkAssessment.tsp";
import "./WebModels/NetworkAssessmentSummary.tsp";
import "./WebModels/AssessedNetworkTopology.tsp";
import "./WebModels/AssessedVirtualNetwork.tsp";
import "./WebModels/AssessedSubnet.tsp";
import "./WebModels/AssessedLoadBalancer.tsp";
import "./WebModels/AssessedLbRule.tsp";
import "./WebModels/AssessedInboundNatRule.tsp";
import "./WebModels/AssessedNetworkSecurityGroup.tsp";
import "./WebModels/AssessedNsgRule.tsp";
import "./WebModels/AssessedApplicationGateway.tsp";
import "./WebModels/AssessedAppGwRoutingRule.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Common query parameters for assessed resource list operations.")
model AssessedResourceListQueryParameters {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "OData Filter"
  @doc("Filter query.")
  @query("$filter")
  filter?: string;

  @doc("Optional parameter for page size.")
  @query
  pageSize?: int32;

  @doc("Optional parameter for continuation token.")
  @query
  continuationToken?: string;

  @doc("Total record count.")
  @query
  totalRecordCount?: int32;
}

@armResourceOperations
interface NetworkAssessmentOperations {
  @added(NetworkApiVersions.v2026_02_02_preview)
  get is ArmResourceRead<NetworkAssessment>;

  @added(NetworkApiVersions.v2026_02_02_preview)
  listByParent is ArmResourceListByParent<NetworkAssessment>;

  @added(NetworkApiVersions.v2026_02_02_preview)
  create is ArmResourceCreateOrUpdateAsync<NetworkAssessment>;

  @added(NetworkApiVersions.v2026_02_02_preview)
  delete is ArmResourceDeleteSync<NetworkAssessment>;

  @summary("Get download URL for the assessment report.")
  @doc("Get the URL for downloading the assessment in a report format.")
  @added(NetworkApiVersions.v2026_02_02_preview)
  downloadUrl is ArmResourceActionAsync<NetworkAssessment, void, DownloadUrl>;
}

@armResourceOperations
interface NetworkAssessmentSummaryOperations {
  @added(NetworkApiVersions.v2026_02_02_preview)
  get is ArmResourceRead<NetworkAssessmentSummary>;

  @added(NetworkApiVersions.v2026_02_02_preview)
  listByParent is ArmResourceListByParent<NetworkAssessmentSummary>;
}

@armResourceOperations
interface AssessedNetworkTopologyOperations {
  @added(NetworkApiVersions.v2026_02_02_preview)
  get is ArmResourceRead<AssessedNetworkTopology>;

  @added(NetworkApiVersions.v2026_02_02_preview)
  listByParent is ArmResourceListByParent<
    AssessedNetworkTopology,
    {
      ...AssessedResourceListQueryParameters;
    }
  >;
}

@armResourceOperations
interface AssessedVirtualNetworkOperations {
  @added(NetworkApiVersions.v2026_02_02_preview)
  get is ArmResourceRead<AssessedVirtualNetwork>;

  @added(NetworkApiVersions.v2026_02_02_preview)
  listByParent is ArmResourceListByParent<
    AssessedVirtualNetwork,
    {
      ...AssessedResourceListQueryParameters;
    }
  >;
}

@armResourceOperations
interface AssessedSubnetOperations {
  @added(NetworkApiVersions.v2026_02_02_preview)
  get is ArmResourceRead<AssessedSubnet>;

  @added(NetworkApiVersions.v2026_02_02_preview)
  listByParent is ArmResourceListByParent<
    AssessedSubnet,
    {
      ...AssessedResourceListQueryParameters;
    }
  >;
}

@armResourceOperations
interface AssessedLoadBalancerOperations {
  @added(NetworkApiVersions.v2026_02_02_preview)
  get is ArmResourceRead<AssessedLoadBalancer>;

  @added(NetworkApiVersions.v2026_02_02_preview)
  listByParent is ArmResourceListByParent<
    AssessedLoadBalancer,
    {
      ...AssessedResourceListQueryParameters;
    }
  >;
}

@armResourceOperations
interface AssessedLbRuleOperations {
  @added(NetworkApiVersions.v2026_02_02_preview)
  get is ArmResourceRead<AssessedLbRule>;

  @added(NetworkApiVersions.v2026_02_02_preview)
  listByParent is ArmResourceListByParent<
    AssessedLbRule,
    {
      ...AssessedResourceListQueryParameters;
    }
  >;
}

@armResourceOperations
interface AssessedNetworkSecurityGroupOperations {
  @added(NetworkApiVersions.v2026_02_02_preview)
  get is ArmResourceRead<AssessedNetworkSecurityGroup>;

  @added(NetworkApiVersions.v2026_02_02_preview)
  listByParent is ArmResourceListByParent<
    AssessedNetworkSecurityGroup,
    {
      ...AssessedResourceListQueryParameters;
    }
  >;
}

@armResourceOperations
interface AssessedNsgRuleOperations {
  @added(NetworkApiVersions.v2026_02_02_preview)
  get is ArmResourceRead<AssessedNsgRule>;

  @added(NetworkApiVersions.v2026_02_02_preview)
  listByParent is ArmResourceListByParent<
    AssessedNsgRule,
    {
      ...AssessedResourceListQueryParameters;
    }
  >;
}

@armResourceOperations
interface AssessedInboundNatRuleOperations {
  @added(NetworkApiVersions.v2026_02_02_preview)
  get is ArmResourceRead<AssessedInboundNatRule>;

  @added(NetworkApiVersions.v2026_02_02_preview)
  listByParent is ArmResourceListByParent<
    AssessedInboundNatRule,
    {
      ...AssessedResourceListQueryParameters;
    }
  >;
}

@armResourceOperations
interface AssessedApplicationGatewayOperations {
  @added(NetworkApiVersions.v2026_02_02_preview)
  get is ArmResourceRead<AssessedApplicationGateway>;

  @added(NetworkApiVersions.v2026_02_02_preview)
  listByParent is ArmResourceListByParent<
    AssessedApplicationGateway,
    {
      ...AssessedResourceListQueryParameters;
    }
  >;
}

@armResourceOperations
interface AssessedAppGwRoutingRuleOperations {
  @added(NetworkApiVersions.v2026_02_02_preview)
  get is ArmResourceRead<AssessedAppGwRoutingRule>;

  @added(NetworkApiVersions.v2026_02_02_preview)
  listByParent is ArmResourceListByParent<
    AssessedAppGwRoutingRule,
    {
      ...AssessedResourceListQueryParameters;
    }
  >;
}
