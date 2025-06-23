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
@@clientName(Metrics.includeApis, "includeApis");
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

@@clientName(DequeuedMessage.messageId, "messageId");
@@clientName(DequeuedMessage.insertionTime, "insertionTime");
@@clientName(DequeuedMessage.expirationTime, "expirationTime");
@@clientName(DequeuedMessage.popReceipt, "popReceipt");
@@clientName(DequeuedMessage.timeNextVisible, "timeNextVisible");
@@clientName(DequeuedMessage.dequeueCount, "dequeueCount");
@@clientName(DequeuedMessage.messageText, "messageText");

@@clientName(QueueMessage.messageText, "messageText");

@@clientName(EnqueuedMessage.messageId, "messageId");
@@clientName(EnqueuedMessage.insertionTime, "insertionTime");
@@clientName(EnqueuedMessage.expirationTime, "expirationTime");
@@clientName(EnqueuedMessage.popReceipt, "popReceipt");
@@clientName(EnqueuedMessage.timeNextVisible, "timeNextVisible");

@@clientName(PeekedMessage.messageId, "messageId");
@@clientName(PeekedMessage.insertionTime, "insertionTime");
@@clientName(PeekedMessage.expirationTime, "expirationTime");
@@clientName(PeekedMessage.dequeueCount, "dequeueCount");
@@clientName(PeekedMessage.messageText, "messageText");
