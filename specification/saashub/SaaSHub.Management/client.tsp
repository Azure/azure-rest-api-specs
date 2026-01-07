import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;
using Microsoft.SaaSHub;

/**
 * Client-specific customizations for Microsoft.SaaSHub models
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "SaaSHub is an existing onboarded RP"
namespace Microsoft.SaasHub.Client {
  /**
   * Client-specific customizations for Microsoft.SaaSHub models
   */
  @clientName("csharp", "MergeSaasResourceContent")
  model MergeSaasResourcesRequest {
    // Use composition rather than inheritance
    ...Microsoft.SaaSHub.MergeSaasResourcesRequest;
  }
}
