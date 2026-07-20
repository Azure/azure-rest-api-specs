// TypeSpec fixture: x-ms-pageable violations (TSP-EXT-PAGEABLE)
// Seeded violations:
//   - Custom list operation with @extension("x-ms-pageable", { nextLinkName: "nextLink" }) (FORBIDDEN -- use ArmResourceListByParent)
//   - Custom list-by-subscription with @extension("x-ms-pageable", ...) (FORBIDDEN -- use ArmListBySubscription)
// Compliant patterns (positive controls -- should NOT be flagged):
//   - ArmResourceListByParent for list-by-resource-group
//   - ArmListBySubscription for list-by-subscription

import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Queue Service",
})
@versioned(Versions)
namespace Microsoft.QueueService;

/** API versions */
enum Versions {
  /** 2025-01-01 version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2025_01_01: "2025-01-01",
}

@segment("queues")
model Queue is TrackedResource<QueueProperties> {
  @key("queueName")
  @pattern("^[a-zA-Z0-9-]{3,64}$")
  name: string;
}

/** Properties of a queue. */
model QueueProperties {
  /** The maximum delivery count. */
  maxDeliveryCount?: int32;

  /** The provisioning state. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

/** A page of queues. */
model QueueListResult {
  /** The list of queues. */
  value: Queue[];

  /** A link to the next page of results. */
  nextLink?: string;
}

@segment("topics")
model Topic is TrackedResource<TopicProperties> {
  @key("topicName")
  @pattern("^[a-zA-Z0-9-]{3,64}$")
  name: string;
}

/** Properties of a topic. */
model TopicProperties {
  /** Whether the topic is partitioned. */
  partitioned?: boolean;

  /** The provisioning state. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

/** A page of topics. */
model TopicListResult {
  /** The list of topics. */
  value: Topic[];

  /** A link to the next page of results. */
  nextLink?: string;
}

@armResourceOperations
interface Queues {
  get is ArmResourceRead<Queue>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Queue>;
  update is ArmResourcePatchAsync<Queue, QueueProperties>;
  delete is ArmResourceDeleteAsync<Queue>;

  // Positive control #1: ArmResourceListByParent is correct -- should NOT be flagged.
  listByResourceGroup is ArmResourceListByParent<Queue>;

  // Positive control #2: ArmListBySubscription is correct -- should NOT be flagged.
  listBySubscription is ArmListBySubscription<Queue>;
}

@armResourceOperations
interface Topics {
  get is ArmResourceRead<Topic>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Topic>;
  update is ArmResourcePatchAsync<Topic, TopicProperties>;
  delete is ArmResourceDeleteAsync<Topic>;

  // Violation #1: custom list-by-resource-group with @extension("x-ms-pageable", ...) is FORBIDDEN.
  // Correct fix: use ArmResourceListByParent<Topic> instead.
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.QueueService/topics")
  @extension("x-ms-pageable", #{ nextLinkName: "nextLink" })
  listByResourceGroup(
    @path subscriptionId: string,
    @path resourceGroupName: string,
  ): TopicListResult;

  // Violation #2: custom list-by-subscription with @extension("x-ms-pageable", ...) is FORBIDDEN.
  // Correct fix: use ArmListBySubscription<Topic> instead.
  @get
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.QueueService/topics")
  @extension("x-ms-pageable", #{ nextLinkName: "nextLink" })
  listBySubscription(
    @path subscriptionId: string,
  ): TopicListResult;
}

interface Operations extends Azure.ResourceManager.Operations {}
