import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Media;

@@clientName(AccountFilterCollection.`@odata.nextLink`, "OdataNextLink");

@@clientName(MediaServiceCollection.`@odata.nextLink`, "OdataNextLink");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MediaServiceUpdate.properties);

@@clientName(AssetCollection.`@odata.nextLink`, "OdataNextLink");

@@clientName(AssetFilterCollection.`@odata.nextLink`, "OdataNextLink");

@@clientName(TrackBase.`@odata.type`, "odataType");

@@clientName(ContentKeyPolicyCollection.`@odata.nextLink`, "OdataNextLink");

@@clientName(ContentKeyPolicyConfiguration.`@odata.type`, "odataType");

@@clientName(ContentKeyPolicyRestriction.`@odata.type`, "odataType");

@@clientName(TransformCollection.`@odata.nextLink`, "OdataNextLink");

@@clientName(Preset.`@odata.type`, "odataType");

@@clientName(JobCollection.`@odata.nextLink`, "OdataNextLink");

@@clientName(JobInput.`@odata.type`, "odataType");

@@clientName(JobOutput.`@odata.type`, "OdataType");

@@clientName(StreamingPolicyCollection.`@odata.nextLink`, "OdataNextLink");

@@clientName(StreamingLocatorCollection.`@odata.nextLink`, "OdataNextLink");

@@clientName(LiveEventListResult.`@odata.count`, "OdataCount");
@@clientName(LiveEventListResult.`@odata.nextLink`, "OdataNextLink");

@@clientName(LiveOutputListResult.`@odata.count`, "OdataCount");
@@clientName(LiveOutputListResult.`@odata.nextLink`, "OdataNextLink");

@@clientName(StreamingEndpointListResult.`@odata.count`, "OdataCount");
@@clientName(StreamingEndpointListResult.`@odata.nextLink`, "OdataNextLink");

@@clientName(ContentKeyPolicyPlayReadyContentKeyLocation.`@odata.type`,
  "OdataType"
);

@@clientName(ContentKeyPolicyRestrictionTokenKey.`@odata.type`, "OdataType");

@@clientName(Codec.`@odata.type`, "OdataType");

@@clientName(TrackDescriptor.`@odata.type`, "OdataType");

@@clientName(InputDefinition.`@odata.type`, "OdataType");

@@clientName(Overlay.`@odata.type`, "OdataType");

@@clientName(Format.`@odata.type`, "OdataType");

@@clientName(ClipTime.`@odata.type`, "odataType");

@@clientName(AccountFilters.createOrUpdate::parameters.resource, "parameters");
@@clientName(AccountFilters.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AccountFilter.properties);

@@clientName(MediaServices.createOrUpdate::parameters.resource, "parameters");
@@clientName(MediaServices.update::parameters.properties, "parameters");
@@clientName(MediaServices.syncStorageKeys::parameters.body, "parameters");
@@clientName(MediaServices.listEdgePolicies::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MediaService.properties);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

@@clientName(Assets.createOrUpdate::parameters.resource, "parameters");
@@clientName(Assets.update::parameters.properties, "parameters");
@@clientName(Assets.listContainerSas::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Asset.properties);

@@clientName(AssetFilters.createOrUpdate::parameters.resource, "parameters");
@@clientName(AssetFilters.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AssetFilter.properties);

@@clientName(AssetTracks.createOrUpdate::parameters.resource, "parameters");
@@clientName(AssetTracks.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AssetTrack.properties);

@@clientName(ContentKeyPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ContentKeyPolicies.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ContentKeyPolicy.properties);

@@clientName(Transforms.createOrUpdate::parameters.resource, "parameters");
@@clientName(Transforms.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Transform.properties);

@@clientName(Jobs.create::parameters.resource, "parameters");
@@clientName(Jobs.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Job.properties);

@@clientName(StreamingPolicies.create::parameters.resource, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StreamingPolicy.properties);

@@clientName(StreamingLocators.create::parameters.resource, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StreamingLocator.properties);

@@clientName(LiveEvents.create::parameters.resource, "parameters");
@@clientName(LiveEvents.update::parameters.properties, "parameters");
@@clientName(LiveEvents.stop::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(LiveEvent.properties);

@@clientName(LiveOutputs.create::parameters.resource, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(LiveOutput.properties);

@@clientName(StreamingEndpoints.create::parameters.resource, "parameters");
@@clientName(StreamingEndpoints.update::parameters.properties, "parameters");
@@clientName(StreamingEndpoints.scale::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StreamingEndpoint.properties);
