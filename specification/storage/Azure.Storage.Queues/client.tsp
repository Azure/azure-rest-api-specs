import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using AzureQueueStorage;

@@clientName(StorageServiceProperties.Logging, "logging");
@@clientName(StorageServiceProperties.HourMetrics, "hourMetrics");
@@clientName(StorageServiceProperties.MinuteMetrics, "minuteMetrics");
@@clientName(StorageServiceProperties.Cors, "cors");

@@clientName(StorageServicePropertiesRequest.Logging, "logging");
@@clientName(StorageServicePropertiesRequest.HourMetrics, "hourMetrics");
@@clientName(StorageServicePropertiesRequest.MinuteMetrics, "minuteMetrics");
@@clientName(StorageServicePropertiesRequest.Cors, "cors");

@@clientName(StorageServicePropertiesResponse.Logging, "logging");
@@clientName(StorageServicePropertiesResponse.HourMetrics, "hourMetrics");
@@clientName(StorageServicePropertiesResponse.MinuteMetrics, "minuteMetrics");
@@clientName(StorageServicePropertiesResponse.Cors, "cors");

@@clientName(Logging.Version, "version");
@@clientName(Logging.Delete, "delete");
@@clientName(Logging.Read, "read");
@@clientName(Logging.Write, "write");
@@clientName(Logging.RetentionPolicy, "retentionPolicy");

@@clientName(LoggingRequest.Version, "version");
@@clientName(LoggingRequest.Delete, "delete");
@@clientName(LoggingRequest.Read, "read");
@@clientName(LoggingRequest.Write, "write");
@@clientName(LoggingRequest.RetentionPolicy, "retentionPolicy");

@@clientName(LoggingResponse.Version, "version");
@@clientName(LoggingResponse.Delete, "delete");
@@clientName(LoggingResponse.Read, "read");
@@clientName(LoggingResponse.Write, "write");
@@clientName(LoggingResponse.RetentionPolicy, "retentionPolicy");

@@clientName(RetentionPolicy.Enabled, "enabled");
@@clientName(RetentionPolicy.Days, "days");

@@clientName(RetentionPolicyRequest.Enabled, "enabled");
@@clientName(RetentionPolicyRequest.Days, "days");

@@clientName(RetentionPolicyResponse.Enabled, "enabled");
@@clientName(RetentionPolicyResponse.Days, "days");

@@clientName(Metrics.Version, "version");
@@clientName(Metrics.Enabled, "enabled");
@@clientName(Metrics.IncludeAPIs, "includeAPIs");
@@clientName(Metrics.RetentionPolicy, "retentionPolicy");

@@clientName(MetricsRequest.Version, "version");
@@clientName(MetricsRequest.Enabled, "enabled");
@@clientName(MetricsRequest.IncludeAPIs, "includeAPIs");
@@clientName(MetricsRequest.RetentionPolicy, "retentionPolicy");

@@clientName(MetricsResponse.Version, "version");
@@clientName(MetricsResponse.Enabled, "enabled");
@@clientName(MetricsResponse.IncludeAPIs, "includeAPIs");
@@clientName(MetricsResponse.RetentionPolicy, "retentionPolicy");

@@clientName(CorsRule.AllowedOrigins, "allowedOrigins");
@@clientName(CorsRule.AllowedMethods, "allowedMethods");
@@clientName(CorsRule.AllowedHeaders, "allowedHeaders");
@@clientName(CorsRule.ExposedHeaders, "exposedHeaders");
@@clientName(CorsRule.MaxAgeInSeconds, "maxAgeInSeconds");

@@clientName(CorsRuleRequest.AllowedOrigins, "allowedOrigins");
@@clientName(CorsRuleRequest.AllowedMethods, "allowedMethods");
@@clientName(CorsRuleRequest.AllowedHeaders, "allowedHeaders");
@@clientName(CorsRuleRequest.ExposedHeaders, "exposedHeaders");
@@clientName(CorsRuleRequest.MaxAgeInSeconds, "maxAgeInSeconds");

@@clientName(CorsRuleResponse.AllowedOrigins, "allowedOrigins");
@@clientName(CorsRuleResponse.AllowedMethods, "allowedMethods");
@@clientName(CorsRuleResponse.AllowedHeaders, "allowedHeaders");
@@clientName(CorsRuleResponse.ExposedHeaders, "exposedHeaders");
@@clientName(CorsRuleResponse.MaxAgeInSeconds, "maxAgeInSeconds");

@@clientName(StorageError.Message, "message");

@@clientName(StorageServiceStats.GeoReplication, "geoReplication");

@@clientName(GeoReplication.Status, "status");
@@clientName(GeoReplication.LastSyncTime, "lastSyncTime");

@@clientName(ListQueuesSegmentResponse.ServiceEndpoint, "serviceEndpoint");
@@clientName(ListQueuesSegmentResponse.Prefix, "prefix");
@@clientName(ListQueuesSegmentResponse.Marker, "marker");
@@clientName(ListQueuesSegmentResponse.MaxResults, "maxResults");
@@clientName(ListQueuesSegmentResponse.QueueItems, "queueItems");
@@clientName(ListQueuesSegmentResponse.NextMarker, "nextMarker");

@@clientName(QueueItem.Name, "name");
@@clientName(QueueItem.Metadata, "metadata");

@@clientName(SignedIdentifier.Id, "id");
@@clientName(SignedIdentifier.AccessPolicy, "accessPolicy");

@@clientName(AccessPolicy.Start, "start");
@@clientName(AccessPolicy.Expiry, "expiry");
@@clientName(AccessPolicy.Permission, "permission");

@@clientName(DequeuedMessageItem.MessageId, "messageId");
@@clientName(DequeuedMessageItem.InsertionTime, "insertionTime");
@@clientName(DequeuedMessageItem.ExpirationTime, "expirationTime");
@@clientName(DequeuedMessageItem.PopReceipt, "popReceipt");
@@clientName(DequeuedMessageItem.TimeNextVisible, "timeNextVisible");
@@clientName(DequeuedMessageItem.DequeueCount, "dequeueCount");
@@clientName(DequeuedMessageItem.MessageText, "messageText");

@@clientName(QueueMessage.MessageText, "messageText");

@@clientName(EnqueuedMessage.MessageId, "messageId");
@@clientName(EnqueuedMessage.InsertionTime, "insertionTime");
@@clientName(EnqueuedMessage.ExpirationTime, "expirationTime");
@@clientName(EnqueuedMessage.PopReceipt, "popReceipt");
@@clientName(EnqueuedMessage.TimeNextVisible, "timeNextVisible");

@@clientName(PeekedMessageItem.MessageId, "messageId");
@@clientName(PeekedMessageItem.InsertionTime, "insertionTime");
@@clientName(PeekedMessageItem.ExpirationTime, "expirationTime");
@@clientName(PeekedMessageItem.DequeueCount, "dequeueCount");
@@clientName(PeekedMessageItem.MessageText, "messageText");
