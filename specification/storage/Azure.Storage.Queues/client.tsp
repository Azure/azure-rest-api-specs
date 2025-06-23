import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Storage.Queue;

@@clientName(StorageServiceProperties.logging, "logging");
@@clientName(StorageServiceProperties.hourMetrics, "hourMetrics");
@@clientName(StorageServiceProperties.minuteMetrics, "minuteMetrics");
@@clientName(StorageServiceProperties.cors, "cors");

@@clientName(Logging.version, "version");
@@clientName(Logging.delete, "delete");
@@clientName(Logging.read, "read");
@@clientName(Logging.write, "write");
@@clientName(Logging.retentionPolicy, "retentionPolicy");

@@clientName(RetentionPolicy.enabled, "enabled");
@@clientName(RetentionPolicy.days, "days");

@@clientName(Metrics.version, "version");
@@clientName(Metrics.enabled, "enabled");
@@clientName(Metrics.includeApis, "includeAPIs");
@@clientName(Metrics.retentionPolicy, "retentionPolicy");

@@clientName(CorsRule.allowedOrigins, "allowedOrigins");
@@clientName(CorsRule.allowedMethods, "allowedMethods");
@@clientName(CorsRule.allowedHeaders, "allowedHeaders");
@@clientName(CorsRule.exposedHeaders, "exposedHeaders");
@@clientName(CorsRule.maxAgeInSeconds, "maxAgeInSeconds");

@@clientName(StorageError.message, "message");

@@clientName(StorageServiceStats.geoReplication, "geoReplication");

@@clientName(GeoReplication.status, "status");
@@clientName(GeoReplication.lastSyncTime, "lastSyncTime");

@@clientName(ListQueuesSegmentResponse.serviceEndpoint, "serviceEndpoint");
@@clientName(ListQueuesSegmentResponse.prefix, "prefix");
@@clientName(ListQueuesSegmentResponse.marker, "marker");
@@clientName(ListQueuesSegmentResponse.maxResults, "maxResults");
@@clientName(ListQueuesSegmentResponse.queueItems, "queueItems");
@@clientName(ListQueuesSegmentResponse.nextMarker, "nextMarker");

@@clientName(QueueItem.name, "name");
@@clientName(QueueItem.metadata, "metadata");

@@clientName(SignedIdentifier.id, "id");
@@clientName(SignedIdentifier.accessPolicy, "accessPolicy");

@@clientName(AccessPolicy.start, "start");
@@clientName(AccessPolicy.expiry, "expiry");
@@clientName(AccessPolicy.permission, "permission");

@@clientName(DequeuedMessageItem.messageId, "messageId");
@@clientName(DequeuedMessageItem.insertionTime, "insertionTime");
@@clientName(DequeuedMessageItem.expirationTime, "expirationTime");
@@clientName(DequeuedMessageItem.popReceipt, "popReceipt");
@@clientName(DequeuedMessageItem.timeNextVisible, "timeNextVisible");
@@clientName(DequeuedMessageItem.dequeueCount, "dequeueCount");
@@clientName(DequeuedMessageItem.messageText, "messageText");

@@clientName(QueueMessage.messageText, "messageText");

@@clientName(EnqueuedMessage.messageId, "messageId");
@@clientName(EnqueuedMessage.insertionTime, "insertionTime");
@@clientName(EnqueuedMessage.expirationTime, "expirationTime");
@@clientName(EnqueuedMessage.popReceipt, "popReceipt");
@@clientName(EnqueuedMessage.timeNextVisible, "timeNextVisible");

@@clientName(PeekedMessageItem.messageId, "messageId");
@@clientName(PeekedMessageItem.insertionTime, "insertionTime");
@@clientName(PeekedMessageItem.expirationTime, "expirationTime");
@@clientName(PeekedMessageItem.dequeueCount, "dequeueCount");
@@clientName(PeekedMessageItem.messageText, "messageText");
