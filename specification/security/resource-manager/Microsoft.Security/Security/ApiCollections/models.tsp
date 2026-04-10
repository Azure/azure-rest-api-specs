import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Common;

namespace ApiCollectionsAPI;

/**
 * Page of a list of API collections as represented by Microsoft Defender for APIs.
 */
model ApiCollectionList {
  /**
   * API collections in this page.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: ApiCollection[];

  /**
   * The URI to fetch the next page.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * Describes the properties of an API collection.
 */
model ApiCollectionProperties {
  /**
   * Gets the provisioning state of the API collection.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The display name of the API collection.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * The resource Id of the resource from where this API collection was discovered.
   */
  @visibility(Lifecycle.Read)
  discoveredVia?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ApiManagement/service";
    }
  ]>;

  /**
   * The base URI for this API collection. All endpoints of this API collection extend this base URI.
   */
  @visibility(Lifecycle.Read)
  baseUrl?: url;

  /**
   * The number of API endpoints discovered in this API collection.
   */
  @visibility(Lifecycle.Read)
  numberOfApiEndpoints?: int64;

  /**
   * The number of API endpoints in this API collection that have not received any API traffic in the last 30 days.
   */
  @visibility(Lifecycle.Read)
  numberOfInactiveApiEndpoints?: int64;

  /**
   * The number of API endpoints in this API collection that are unauthenticated.
   */
  @visibility(Lifecycle.Read)
  numberOfUnauthenticatedApiEndpoints?: int64;

  /**
   * The number of API endpoints in this API collection for which API traffic from the internet was observed.
   */
  @visibility(Lifecycle.Read)
  numberOfExternalApiEndpoints?: int64;

  /**
   * The number of API endpoints in this API collection which are exposing sensitive data in their requests and/or responses.
   */
  @visibility(Lifecycle.Read)
  numberOfApiEndpointsWithSensitiveDataExposed?: int64;

  /**
   * The highest priority sensitivity label from Microsoft Purview in this API collection.
   */
  @visibility(Lifecycle.Read)
  sensitivityLabel?: string;
}

