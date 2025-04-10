import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.StreamAnalytics;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FunctionProperties.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SubscriptionQuota.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkServiceConnection.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BlobStreamInputDataSource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EventHubStreamInputDataSource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EventHubV2StreamInputDataSource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IoTHubStreamInputDataSource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FileReferenceInputDataSource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BlobReferenceInputDataSource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ParquetSerialization.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CsvSerialization.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(JsonSerialization.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AvroSerialization.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AzureSqlReferenceInputDataSource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GatewayMessageBusStreamInputDataSource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BlobOutputDataSource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AzureTableOutputDataSource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EventHubOutputDataSource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EventHubV2OutputDataSource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AzureSqlDatabaseOutputDataSource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AzureSynapseOutputDataSource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DocumentDbOutputDataSource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AzureFunctionOutputDataSource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ServiceBusQueueOutputDataSource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ServiceBusTopicOutputDataSource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PowerBIOutputDataSource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AzureDataLakeStoreOutputDataSource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(GatewayMessageBusOutputDataSource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AzureMachineLearningWebServiceFunctionBinding.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(JavaScriptFunctionBinding.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AzureMachineLearningWebServiceFunctionRetrieveDefaultDefinitionParameters.bindingRetrievalProperties
);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(JavaScriptFunctionRetrieveDefaultDefinitionParameters.bindingRetrievalProperties
);

@@clientName(StreamingJobs.createOrReplace::parameters.resource,
  "streamingJob"
);
@@clientName(StreamingJobs.update::parameters.properties, "streamingJob");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StreamingJob.properties);

@@clientName(Inputs.createOrReplace::parameters.resource, "input");
@@clientName(Inputs.update::parameters.properties, "input");

@@clientName(Transformations.createOrReplace::parameters.resource,
  "transformation"
);
@@clientName(Transformations.update::parameters.properties, "transformation");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Transformation.properties);

@@clientName(Outputs.createOrReplace::parameters.resource, "output");
@@clientName(Outputs.update::parameters.properties, "output");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Output.properties);

@@clientName(Functions.createOrReplace::parameters.resource, "function");
@@clientName(Functions.update::parameters.properties, "function");

@@clientName(Clusters.createOrUpdate::parameters.resource, "cluster");
@@clientName(Clusters.update::parameters.properties, "cluster");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Cluster.properties);

@@clientName(PrivateEndpoints.createOrUpdate::parameters.resource,
  "privateEndpoint"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpoint.properties);
