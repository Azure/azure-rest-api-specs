@doc("Describes the schema of the Redis Cache events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent.")
namespace EventGrid {
  alias RedisBaseEventData = {
    @doc("The time at which the event occurred.")
    timestamp?: utcDateTime;

    @doc("The name of this event.")
    name?: string;

    @doc("The status of this event. Failed or  succeeded ")
    status?: string;
  };

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.Cache.PatchingCompleted event.")
  model RedisPatchingCompletedEventData {
    ...RedisBaseEventData;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.Cache.ScalingCompleted event.")
  model RedisScalingCompletedEventData {
    ...RedisBaseEventData;
  }

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.Cache.ExportRDBCompleted event.")
  model RedisExportRDBCompletedEventData {
    ...RedisBaseEventData;
  }

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.Cache.ImportRDBCompleted event.")
  model RedisImportRDBCompletedEventData {
    ...RedisBaseEventData;
  }
}
