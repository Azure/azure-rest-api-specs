@doc("States of a configuration resource")
union ConfigurationState {
  @doc("Good, just in progress creating the resources")
  InProgress: "InProgress",

  @doc("Something is stuck waiting to be resolved, e.g. incorrect underlying storage configuration")
  Pending: "Pending",

  @doc("The configuration is running and in use")
  Running: "Running",

  @doc("The configuration is terminating")
  Terminating: "Terminating",

  @doc("The configuration is updating")
  Updating: "Updating",

  @doc("We can't determine the status of the configuration")
  Unknown: "Unknown",

  string,
}
