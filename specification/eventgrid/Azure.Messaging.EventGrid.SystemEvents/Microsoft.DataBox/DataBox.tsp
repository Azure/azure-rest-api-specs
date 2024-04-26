/** EG DataBox Data Model */
namespace Microsoft.EventGrid.SystemEvents {
  /** Schema of the Data property of an EventGridEvent for a Microsoft.DataBox.CopyStarted event. */
  model DataBoxCopyStartedEventData {
    ...DataBoxBase;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.DataBox.CopyCompleted event. */
  model DataBoxCopyCompletedEventData {
    ...DataBoxBase;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.DataBox.OrderCompleted event. */
  model DataBoxOrderCompletedEventData {
    ...DataBoxBase;
  }

  alias DataBoxBase = {
    /** Serial Number of the device associated with the event. The list is comma separated if more than one serial number is associated. */
    serialNumber?: string;

    /** Name of the current Stage */
    stageName: DataBoxStageName;

    /** The time at which the stage happened. */
    stageTime: utcDateTime;
  };

  /** Schema of DataBox Stage Name enumeration. */
  union DataBoxStageName {
    /** Copy has started */
    "CopyStarted",

    /** Copy has completed */
    "CopyCompleted",

    /** Order has been completed */
    "OrderCompleted",

    string,
  }
}
