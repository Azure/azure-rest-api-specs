import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Factory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataFactory;
@doc("Trigger resource type.")
@parentResource(Factory)
model TriggerResource is ProxyResource<Trigger> {
  @doc("The trigger name.")
  @maxLength(260)
  @minLength(1)
  @pattern("^[A-Za-z0-9_][^<>*#.%&:\\\\+?/]*$")
  @path
  @key("triggerName")
  @segment("triggers")
  name: string;
}

@armResourceOperations
interface Triggers {
  @doc("Gets a trigger.")
  get is ArmResourceRead<
    TriggerResource,
    {
      ...BaseParameters<TriggerResource>;

      @doc("ETag of the trigger entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.")
      @header
      `If-None-Match`?: string;
    }
  >;
  @doc("Creates or updates a trigger.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    TriggerResource,
    {
      ...BaseParameters<TriggerResource>;

      @doc("ETag of the trigger entity.  Should only be specified for update, for which it should match existing entity or can be * for unconditional update.")
      @header
      `If-Match`?: string;
    }
  >;
  @doc("Deletes a trigger.")
  delete is ArmResourceDeleteSync<TriggerResource>;
  @doc("Lists triggers.")
  listByFactory is ArmResourceListByParent<TriggerResource>;
  @doc("Subscribe event trigger to events.")
  subscribeToEvents is ArmResourceActionAsync<
    TriggerResource,
    void,
    TriggerSubscriptionOperationStatus
  >;
  @doc("Get a trigger's event subscription status.")
  getEventSubscriptionStatus is ArmResourceActionSync<
    TriggerResource,
    void,
    TriggerSubscriptionOperationStatus
  >;
  @doc("Unsubscribe event trigger from events.")
  unsubscribeFromEvents is ArmResourceActionAsync<
    TriggerResource,
    void,
    TriggerSubscriptionOperationStatus
  >;
  @doc("Starts a trigger.")
  start is ArmResourceActionAsync<TriggerResource, void, void>;
  @doc("Stops a trigger.")
  stop is ArmResourceActionAsync<TriggerResource, void, void>;
}

@armResourceOperations
interface TriggerRuns {
  @doc("Rerun single trigger instance by runId.")
  rerun is ArmResourceActionSync<
    TriggerResource,
    void,
    void,
    {
      ...BaseParameters<TriggerResource>;

      @doc("The pipeline run identifier.")
      @path
      runId: string;
    }
  >;
  @doc("Cancel a single trigger instance by runId.")
  cancel is ArmResourceActionSync<
    TriggerResource,
    void,
    void,
    {
      ...BaseParameters<TriggerResource>;

      @doc("The pipeline run identifier.")
      @path
      runId: string;
    }
  >;
}
