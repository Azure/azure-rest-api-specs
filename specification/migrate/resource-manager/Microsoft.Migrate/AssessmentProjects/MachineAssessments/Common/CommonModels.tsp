namespace Microsoft.Migrate;

@doc("Details on the total up-time for the VM.")
model VmUptime {
  @doc("Number of days in a month for VM uptime.")
  daysPerMonth?: int32;

  @doc("Number of hours per day for VM uptime.")
  hoursPerDay?: int32;
}

@doc("Represents a information \\ details of a processor.")
model ProcessorInfo {
  @doc("Gets or sets the name \\ model of a processor.")
  name?: string;

  @doc("Gets or sets the number of sockets.")
  numberOfSockets?: int32;

  @doc("Gets or sets the number of cores in a socket.")
  numberOfCoresPerSocket?: int32;
}

@doc("Ultra Disk Support")
union UltraDiskSupport {
  @doc("Ultra Disk Supported")
  UltraDiskSupported: "UltraDiskSupported",

  @doc("Ultra Disk Not Supported")
  UltraDiskNotSupported: "UltraDiskNotSupported",

  string,
}

@doc("Error web model class.")
model Error {
  @doc("Gets the error ID.")
  @visibility(Lifecycle.Read)
  id?: int32;

  @doc("Gets the error code.")
  @visibility(Lifecycle.Read)
  code?: string;

  @doc("Gets the Run as account ID.")
  @visibility(Lifecycle.Read)
  runAsAccountId?: string;

  @doc("Gets the Appliance name.")
  @visibility(Lifecycle.Read)
  applianceName?: string;

  @doc("Gets the error message.")
  @visibility(Lifecycle.Read)
  message?: string;

  @doc("Gets the error summary message.")
  @visibility(Lifecycle.Read)
  summaryMessage?: string;

  @doc("Gets the agent scenario where this error occurred.")
  @visibility(Lifecycle.Read)
  agentScenario?: string;

  @doc("Gets the error possible causes.")
  @visibility(Lifecycle.Read)
  possibleCauses?: string;

  @doc("Gets the recommended action for the error.")
  @visibility(Lifecycle.Read)
  recommendedAction?: string;

  @doc("Gets the error severity.")
  @visibility(Lifecycle.Read)
  severity?: string;

  @doc("Gets the error message parameters.")
  @visibility(Lifecycle.Read)
  messageParameters?: NameValuePair<string, string>[];

  @doc("Gets the time stamp when the error was updated.")
  @visibility(Lifecycle.Read)
  updatedTimeStamp?: utcDateTime;

  @doc("Gets the type of assessment impacted by this error.")
  @visibility(Lifecycle.Read)
  impactedAssessmentType?: string;
}
