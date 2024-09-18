import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.Workloads;

#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
@doc("Get SAP sizing recommendations by providing input SAPS for application tier and memory required for database tier")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Workloads/locations/{location}/sapVirtualInstanceMetadata/default/getSizingRecommendations")
@post
@operationId("SAPSizingRecommendations")
op getSizingRecommendations(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...LocationResourceParameter,

  @doc("SAP Sizing Recommendation Request body")
  @body
  SAPSizingRecommendation?: SAPSizingRecommendationRequest;
): ArmResponse<SAPSizingRecommendationResult> | ErrorResponse;

#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
@doc("Get a list of SAP supported SKUs for ASCS, Application and Database tier.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Workloads/locations/{location}/sapVirtualInstanceMetadata/default/getSapSupportedSku")
@post
@operationId("SAPSupportedSku")
op getSapSupportedSku(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...LocationResourceParameter,

    @doc("SAP Supported SKU Request body")
    @body
    SAPSupportedSku?: SAPSupportedSkusRequest;
): ArmResponse<SAPSupportedResourceSkusResult> | ErrorResponse;

#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
@doc("Get the SAP Disk Configuration Layout prod/non-prod SAP System.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Workloads/locations/{location}/sapVirtualInstanceMetadata/default/getDiskConfigurations")
@post
@operationId("SAPDiskConfigurations")
op getDiskConfigurations(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...LocationResourceParameter,

  @doc("SAP Disk Configurations Request body")
  @body
  SAPDiskConfigurations?: SAPDiskConfigurationsRequest;
): ArmResponse<SAPDiskConfigurationsResult> | ErrorResponse;

#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
@doc("Get the recommended SAP Availability Zone Pair Details for your region.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Workloads/locations/{location}/sapVirtualInstanceMetadata/default/getAvailabilityZoneDetails")
@post
@operationId("SAPAvailabilityZoneDetails")
op getAvailabilityZoneDetails(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...LocationResourceParameter,

  @doc("SAP Availability Zone Details Request body")
  @body
  SAPAvailabilityZoneDetails?: SAPAvailabilityZoneDetailsRequest;
): ArmResponse<SAPAvailabilityZoneDetailsResult> | ErrorResponse;