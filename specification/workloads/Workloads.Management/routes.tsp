// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";


using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;


namespace Microsoft.Workloads;



#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
/**
* Get SAP sizing recommendations by providing input SAPS for application tier and memory required for database tier
*/
@autoRoute
@action("sapVirtualInstanceMetadata/default/getSizingRecommendations")
sAPSizingRecommendations is ArmProviderActionSync<Request = SAPSizingRecommendationRequest,Response = SAPSizingRecommendationResult,Scope = SubscriptionActionScope,Parameters = LocationParameter>
/**
* Get a list of SAP supported SKUs for ASCS, Application and Database tier.
*/
@autoRoute
@action("sapVirtualInstanceMetadata/default/getSapSupportedSku")
sAPSupportedSku is ArmProviderActionSync<Request = SAPSupportedSkusRequest,Response = SAPSupportedResourceSkusResult,Scope = SubscriptionActionScope,Parameters = LocationParameter>
/**
* Get the SAP Disk Configuration Layout prod/non-prod SAP System.
*/
@autoRoute
@action("sapVirtualInstanceMetadata/default/getDiskConfigurations")
sAPDiskConfigurations is ArmProviderActionSync<Request = SAPDiskConfigurationsRequest,Response = SAPDiskConfigurationsResult,Scope = SubscriptionActionScope,Parameters = LocationParameter>
/**
* Get the recommended SAP Availability Zone Pair Details for your region.
*/
@autoRoute
@action("sapVirtualInstanceMetadata/default/getAvailabilityZoneDetails")
sAPAvailabilityZoneDetails is ArmProviderActionSync<Request = SAPAvailabilityZoneDetailsRequest,Response = SAPAvailabilityZoneDetailsResult,Scope = SubscriptionActionScope,Parameters = LocationParameter>