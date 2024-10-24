import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./main.tsp";
import "../common/models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Microsoft.MachineLearningServices;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Get an Online Endpoint.")
@route("/onlineEndpoints/{name}")
@get
op getOnlineEndpoint is Azure.Core.Foundations.Operation<
  {
    @doc("Name of the endpoint.")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
    @maxLength(254)
    @path
    name: string;
  },
  OnlineEndpoint
>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Delete an Online Endpoint.")
@route("/onlineEndpoints/{name}")
@delete
op deleteOnlineEndpoint is Azure.Core.Foundations.Operation<
  {
    @doc("Name of the endpoint.")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
    @maxLength(254)
    @path
    name: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Update an Online Endpoint.")
@route("/onlineEndpoints/{name}")
@patch
op updateOnlineEndpoint is Azure.Core.Foundations.Operation<
  {
    @doc("Name of the endpoint.")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
    @maxLength(254)
    @path
    name: string;

    @doc("Online Endpoint entity to apply during operation.")
    @body
    body: PartialMinimalTrackedResourceWithIdentity;
  },
  OnlineEndpoint
>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Create or Update an Online Endpoint.")
@route("/onlineEndpoints/{name}")
@put
op createOrUpdateOnlineEndpoint is Azure.Core.Foundations.Operation<
  {
    @doc("Name of the endpoint.")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
    @maxLength(254)
    @path
    name: string;

    @doc("Online Endpoint")
    @body
    body: OnlineEndpoint;
  },
  OnlineEndpoint
>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/onlineEndpoints")
@doc("List Online Endpoints.")
@get
op listOnlineEndpoints(
  @query
  @doc("Name of the endpoint.")
  name?: string,

  @query
  @doc("Number of endpoints to be retrieved in a page of results.")
  count?: int32,

  @query
  @doc("EndpointComputeType to be filtered by.")
  computeType?: EndpointComputeType,

  @query
  @doc("A set of tags with which to filter the returned models. It is a comma separated string of tags key or tags key=value. Example: tagKey1,tagKey2,tagKey3=value3 .")
  tags?: string,

  @query
  @doc("A set of properties with which to filter the returned models. It is a comma separated string of properties key and/or properties key=value Example: propKey1,propKey2,propKey3=value3 .")
  properties?: string,

  @query
  @doc("The option to order the response.")
  orderBy?: OrderString,
): PagedOnlineEndpoint;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("List EndpointAuthKeys for an Endpoint using Key-based authentication.")
@route("/onlineEndpoints/{name}/listKeys")
@post
op listKeysOnlineEndpoint is Azure.Core.Foundations.Operation<
  {
    @doc("Name of the endpoint.")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
    @maxLength(254)
    @path
    name: string;

    @doc("Online Endpoint")
    @body
    body: RegenerateEndpointKeysRequest;
  },
  EndpointAuthKeys
>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Regenerate EndpointAuthKeys for an Endpoint using Key-based authentication (asynchronous).")
@route("/onlineEndpoints/{name}/regenerateKeys")
@post
op regenerateKeysOnlineEndpoint is Azure.Core.Foundations.Operation<
  {
    @doc("Name of the endpoint.")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
    @maxLength(254)
    @path
    name: string;
  },
  EndpointAuthKeys
>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Retrieve a valid AML token for an Endpoint using AMLToken-based authentication.")
@route("/onlineEndpoints/{name}/token")
@put
op getTokenOnlineEndpoint is Azure.Core.Foundations.Operation<
  {
    @doc("Name of the endpoint.")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
    @maxLength(254)
    @path
    name: string;
  },
  EndpointAuthToken
>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/onlineEndpoints/{endpointName}/deployments")
@doc("List Online Deployments.")
@get
op listOnlineDeployments(
  @doc("Inference endpoint name.")
  @path
  endpointName: string,

  @doc("Ordering of list.")
  @query("$orderBy")
  $orderBy?: string,

  @doc("Top of list.")
  @query("$top")
  $top?: int32,
): PagedOnlineDeployment;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Delete an Online Deployment.")
@route("/onlineEndpoints/{endpointName}/deployments/{deploymentName}")
@delete
op deleteOnlineDeployment is Azure.Core.Foundations.Operation<
  {
    @doc("Inference endpoint name.")
    @path
    endpointName: string;

    @doc("Inference Endpoint Deployment name.")
    @path
    deploymentName: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Gets an online inference deployment by id.")
@route("/onlineEndpoints/{endpointName}/deployments/{deploymentName}")
@get
op getOnlineDeployment is Azure.Core.Foundations.Operation<
  {
    @doc("Inference endpoint name.")
    @path
    endpointName: string;

    @doc("Inference Endpoint Deployment name.")
    @path
    deploymentName: string;
  },
  OnlineDeployment
>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Update a Online Deployment.")
@route("/onlineEndpoints/{endpointName}/deployments/{deploymentName}")
@patch
op updateOnlineDeployment is Azure.Core.Foundations.Operation<
  {
    @doc("Inference endpoint name.")
    @path
    endpointName: string;

    @doc("Inference Endpoint Deployment name.")
    @path
    deploymentName: string;

    @doc("Online Endpoint entity to apply during operation.")
    @body
    body: PartialMinimalTrackedResourceWithSku;
  },
  OnlineDeployment
>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Create or Update an Online Deployment.")
@route("/onlineEndpoints/{endpointName}/deployments/{deploymentName}")
@put
op createOrUpdateOnlineDeployment is Azure.Core.Foundations.Operation<
  {
    @doc("Inference endpoint name.")
    @path
    endpointName: string;

    @doc("Inference Endpoint Deployment name.")
    @path
    deploymentName: string;

    @doc("Inference Endpoint entity to apply during operation.")
    @body
    body: OnlineDeployment;
  },
  OnlineDeployment
>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Polls an Endpoint operation.")
@route("/onlineEndpoints/{endpointName}/deployments/{deploymentName}/getLogs")
@post
op pollLogsOnlineDeployment is Azure.Core.Foundations.Operation<
  {
    @doc("Inference endpoint name.")
    @path
    endpointName: string;

    @doc("Inference Endpoint Deployment name.")
    @path
    deploymentName: string;

    @doc("The request containing parameters for retrieving logs.")
    @body
    body: DeploymentLogsRequest;
  },
  DeploymentLogs
>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("List Inference Endpoint Deployment Skus.")
@route("/onlineEndpoints/{endpointName}/deployments/{deploymentName}/skus")
@get
op getSkusOnlineDeployment is Azure.Core.Foundations.Operation<
  {
    @doc("Inference endpoint name.")
    @path
    endpointName: string;

    @doc("Inference Endpoint Deployment name.")
    @path
    deploymentName: string;

    @doc("Number of Skus to be retrieved in a page of results.")
    @query
    count: int32;
  },
  SkuResourceArmPaginatedResult
>;

///// Batch Endpoints ///////
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Get a Batch Endpoint.")
@route("/batchEndpoints/{endpointName}")
@get
op getBatchEndpoint is Azure.Core.Foundations.Operation<
  {
    @doc("Name for the Batch Endpoint.")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
    @maxLength(254)
    @path
    endpointName: string;
  },
  BatchEndpoint
>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Delete an Batch Endpoint.")
@route("/batchEndpoints/{endpointName}")
@delete
op deleteBatchEndpoint is Azure.Core.Foundations.Operation<
  {
    @doc("Inference Endpoint name.")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
    @maxLength(254)
    @path
    endpointName: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Update a Batch Endpoint.")
@route("/batchEndpoints/{endpointName}")
@patch
op updateBatchEndpoint is Azure.Core.Foundations.Operation<
  {
    @doc("Name for the Batch inference endpoint.")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
    @maxLength(254)
    @path
    endpointName: string;

    @doc("Mutable batch inference endpoint definition object.")
    @body
    body: PartialMinimalTrackedResourceWithIdentity;
  },
  BatchEndpoint
>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Create or Update a Batch Endpoint.")
@route("/batchEndpoints/{endpointName}")
@put
op createOrUpdateBatchEndpoint is Azure.Core.Foundations.Operation<
  {
    @doc("Name for the Batch inference endpoint.")
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
    @maxLength(254)
    @path
    endpointName: string;

    @doc("Batch inference endpoint definition object.")
    @body
    body: BatchEndpoint;
  },
  BatchEndpoint
>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/batchEndpoints")
@doc("List Batch Endpoints.")
@get
op listBatchEndpoints(
  @query
  @doc("Number of endpoints to be retrieved in a page of results.")
  count?: int32,
): PagedBatchEndpoint;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@route("/batchEndpoints/{endpointName}/deployments")
@doc("List Batch Deployments.")
@get
op listBatchDeployments(
  @doc("Endpoint name.")
  @path
  endpointName: string,

  @doc("Ordering of list.")
  @query("$orderBy")
  $orderBy?: string,

  @doc("Top of list.")
  @query("$top")
  $top?: int32,

  @doc("Continuation token for pagination.")
  @query("$skip")
  $skip?: string,
): PagedBatchDeployment;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Delete an Batch Deployment.")
@route("/batchEndpoints/{endpointName}/deployments/{deploymentName}")
@delete
op deleteBatchDeployment is Azure.Core.Foundations.Operation<
  {
    @doc("Endpoint name")
    @path
    endpointName: string;

    @doc("Inference deployment identifier.")
    @path
    deploymentName: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Gets a batch inference deployment by id.")
@route("/batchEndpoints/{endpointName}/deployments/{deploymentName}")
@get
op getBatchDeployment is Azure.Core.Foundations.Operation<
  {
    @doc("Endpoint name")
    @path
    endpointName: string;

    @doc("Inference deployment identifier.")
    @path
    deploymentName: string;
  },
  BatchDeployment
>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Update a Batch Deployment.")
@route("/batchEndpoints/{endpointName}/deployments/{deploymentName}")
@patch
op updateBatchDeployment is Azure.Core.Foundations.Operation<
  {
    @doc("Endpoint name")
    @path
    endpointName: string;

    @doc("Inference deployment identifier.")
    @path
    deploymentName: string;

    @doc("Mutable batch inference endpoint definition object.")
    @body
    body: PartialBatchDeploymentPartialMinimalTrackedResourceWithProperties;
  },
  BatchDeployment
>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Create or Update a Batch Deployment.")
@route("/batchEndpoints/{endpointName}/deployments/{deploymentName}")
@put
op createOrUpdateBatchDeployment is Azure.Core.Foundations.Operation<
  {
    @doc("Endpoint name")
    @path
    endpointName: string;

    @doc("The identifier for the Batch inference deployment.")
    @path
    deploymentName: string;

    @doc("Batch inference deployment definition object.")
    @body
    body: BatchDeployment;
  },
  BatchEndpoint
>;
