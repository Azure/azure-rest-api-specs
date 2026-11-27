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

namespace CloudInventoryApi;

/**
 * Singleton resource name for Microsoft.Security/cloudInventory.
 */
union CloudInventoryName {
  string,

  /** The default Cloud Inventory resource name. */
  default: "default",
}

/**
 * The source cloud or environment of the inventoried resource.
 */
union CloudInventoryEnvironment {
  string,

  /** Microsoft Azure */
  Azure: "Azure",

  /** Amazon Web Services */
  AWS: "AWS",

  /** Google Cloud Platform */
  GCP: "GCP",

  /** Microsoft Defender for Endpoint */
  MDE: "MDE",

  /** Microsoft Graph */
  MSGraph: "MSGraph",

  /** External Container Registry */
  ExternalContainerRegistry: "ExternalContainerRegistry",

  /** Docker Hub container registry */
  DockerHub: "DockerHub",

  /** JFrog Artifactory */
  JFrog: "JFrog",

  /** GitHub source control platform */
  GitHub: "GitHub",

  /** GitLab DevSecOps platform */
  GitLab: "GitLab",

  /** Cloud-agnostic environment */
  Agnostic: "Agnostic",

  /** Azure DevOps */
  AzureDevOps: "AzureDevOps",

  /** Other environment */
  Other: "Other",
}

/**
 * Page of Cloud Inventory resources.
 */
model CloudInventoryList {
  /**
   * The CloudInventory items on this page.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: CloudInventory[];

  /**
   * The link to the next page of items.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: url;
}

/**
 * Properties of a Microsoft.Security/cloudInventory resource (read-only RP Lite projection from Defender CloudMap / DSag).
 */
model CloudInventoryProperties {
  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /**
   * The ARM resource identifier of the inventoried entity.
   */
  @visibility(Lifecycle.Read)
  resourceId?: string;

  /**
   * The display name of the inventoried entity.
   */
  @visibility(Lifecycle.Read)
  resourceName?: string;

  /**
   * The normalized resource type of the inventoried entity (for example, 'virtualmachines', 'pod', 'container', 'instance').
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * The classification label of the inventoried entity in the security graph (for example, 'compute, virtual-machine' or 'kubernetes-pod').
   */
  @visibility(Lifecycle.Read)
  resourceLabel?: string;

  /**
   * The cloud or source environment of the inventoried entity.
   */
  @visibility(Lifecycle.Read)
  environments?: CloudInventoryEnvironment;

  /**
   * The resource group of the inventoried entity, when applicable.
   */
  @visibility(Lifecycle.Read)
  resourceGroup?: string;

  /**
   * The Microsoft.Security/securityConnectors ARM resource ID that onboarded the entity, when applicable.
   */
  @visibility(Lifecycle.Read)
  securityConnectorId?: string;
}
