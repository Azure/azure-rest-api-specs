import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Workloads;

@doc("Get SAP sizing recommendations by providing input SAPS for application tier and memory required for database tier")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Workloads/locations/{location}/sapVirtualInstanceMetadata/default/getSizingRecommendations")
@post
op sAPSizingRecommendations is Azure.Core.Foundations.Operation<
  {
    @doc("The ID of the target subscription.")
    @minLength(1)
    @path
    subscriptionId: string;

    @doc("The name of Azure region.")
    @minLength(1)
    @path
    location: string;

    @doc("SAP Sizing Recommendation Request body")
    @body
    SAPSizingRecommendation?: SAPSizingRecommendationRequest;
  },
  SAPSizingRecommendationResult
>;

@doc("Get a list of SAP supported SKUs for ASCS, Application and Database tier.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Workloads/locations/{location}/sapVirtualInstanceMetadata/default/getSapSupportedSku")
@post
op sAPSupportedSku is Azure.Core.Foundations.Operation<
  {
    @doc("The ID of the target subscription.")
    @minLength(1)
    @path
    subscriptionId: string;

    @doc("The name of Azure region.")
    @minLength(1)
    @path
    location: string;

    @doc("SAP Supported SKU Request body")
    @body
    SAPSupportedSku?: SAPSupportedSkusRequest;
  },
  SAPSupportedResourceSkusResult
>;

@doc("Get the SAP Disk Configuration Layout prod/non-prod SAP System.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Workloads/locations/{location}/sapVirtualInstanceMetadata/default/getDiskConfigurations")
@post
op sAPDiskConfigurations is Azure.Core.Foundations.Operation<
  {
    @doc("The ID of the target subscription.")
    @minLength(1)
    @path
    subscriptionId: string;

    @doc("The name of Azure region.")
    @minLength(1)
    @path
    location: string;

    @doc("SAP Disk Configurations Request body")
    @body
    SAPDiskConfigurations?: SAPDiskConfigurationsRequest;
  },
  SAPDiskConfigurationsResult
>;

@doc("Get the recommended SAP Availability Zone Pair Details for your region.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Workloads/locations/{location}/sapVirtualInstanceMetadata/default/getAvailabilityZoneDetails")
@post
op sAPAvailabilityZoneDetails is Azure.Core.Foundations.Operation<
  {
    @doc("The ID of the target subscription.")
    @minLength(1)
    @path
    subscriptionId: string;

    @doc("The name of Azure region.")
    @minLength(1)
    @path
    location: string;

    @doc("SAP Availability Zone Details Request body")
    @body
    SAPAvailabilityZoneDetails?: SAPAvailabilityZoneDetailsRequest;
  },
  SAPAvailabilityZoneDetailsResult
>;
