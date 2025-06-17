namespace K8s.Io.Api.Core.V1;

@doc("The available operator for the Toleration section.")
union TolerationOperator {
  @doc("Operator that checks for existence.")
  Exists: "Exists",

  @doc("Operator that checks for equality.")
  Equal: "Equal",

  string,
}

@doc("The available taint effect for the Toleration section")
union TaintEffect {
  @doc("The NoSchedule taint effect.")
  NoSchedule: "NoSchedule",

  string,
}
