@doc("EG DataBox Data Model")
namespace Microsoft.EventGrid {
  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.DataBox.CopyStarted event.")
  model DataBoxCopyStartedEventData {
    ...DataBoxBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.DataBox.CopyCompleted event.")
  model DataBoxCopyCompletedEventData {
    ...DataBoxBase;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.DataBox.OrderCompleted event.")
  model DataBoxOrderCompletedEventData {
    ...DataBoxBase;
  }

  alias DataBoxBase = {
    @doc("Serial Number of the device associated with the event. The list is comma separated if more than one serial number is associated.")
    serialNumber?: string;

    @doc("Name of the current Stage")
    stageName?: DataBoxStageName;

    @doc("The time at which the stage happened.")
    stageTime?: utcDateTime;
  };

  @doc("Schema of DataBox Stage Name enumeration.")
  enum DataBoxStageName {
    @doc("Copy has started")
    CopyStarted,

    @doc("Copy has completed")
    CopyCompleted,

    @doc("Order has been completed")
    OrderCompleted,
  }
}
