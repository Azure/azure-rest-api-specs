import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataFactory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataFactory;
@doc("Trigger resource type.")
@parentResource(DataFactory)
model DataFactoryTrigger is ProxyResource<Trigger> {
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
interface DataFactoryTriggers {
  @doc("Gets a trigger.")
  get is ArmResourceRead<
    DataFactoryTrigger,
    {
      ...BaseParameters<DataFactoryTrigger>;

      @doc("ETag of the trigger entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.")
      @header
      `If-None-Match`?: string;
    }
  >;
  @doc("Creates or updates a trigger.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    DataFactoryTrigger,
    {
      ...BaseParameters<DataFactoryTrigger>;

      @doc("ETag of the trigger entity.  Should only be specified for update, for which it should match existing entity or can be * for unconditional update.")
      @header
      `If-Match`?: string;
    }
  >;
  @doc("Deletes a trigger.")
  delete is ArmResourceDeleteSync<DataFactoryTrigger>;
  @doc("Lists triggers.")
  listByFactory is ArmResourceListByParent<DataFactoryTrigger>;
  @doc("Subscribe event trigger to events.")
  subscribeToEvents is ArmResourceActionAsync<
    DataFactoryTrigger,
    void,
    TriggerSubscriptionOperationStatus
  >;
  @doc("Get a trigger's event subscription status.")
  getEventSubscriptionStatus is ArmResourceActionSync<
    DataFactoryTrigger,
    void,
    TriggerSubscriptionOperationStatus
  >;
  @doc("Unsubscribe event trigger from events.")
  unsubscribeFromEvents is ArmResourceActionAsync<
    DataFactoryTrigger,
    void,
    TriggerSubscriptionOperationStatus
  >;
  @doc("Starts a trigger.")
  start is ArmResourceActionAsync<DataFactoryTrigger, void, void>;
  @doc("Stops a trigger.")
  stop is ArmResourceActionAsync<DataFactoryTrigger, void, void>;
  @doc("Rerun single trigger instance by runId.")
  rerun is ArmResourceActionSync<
    DataFactoryTrigger,
    void,
    void,
    {
      ...BaseParameters<DataFactoryTrigger>;

      @doc("The pipeline run identifier.")
      @path
      runId: string;
    }
  >;
  @doc("Cancel a single trigger instance by runId.")
  cancel is ArmResourceActionSync<
    DataFactoryTrigger,
    void,
    void,
    {
      ...BaseParameters<DataFactoryTrigger>;

      @doc("The pipeline run identifier.")
      @path
      runId: string;
    }
  >;
}
