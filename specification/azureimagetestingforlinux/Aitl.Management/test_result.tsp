namespace Microsoft.AzureImageTestingForLinux;

@doc("Test results for a particular test case")
model TestResultProperties is ResourceProperties {
  @doc("The test result ID")
  resultId?: string;

  @doc("The test name")
  testName?: string;

  @doc("The test category")
  testCategory?: string;

  @doc("The test area")
  testArea?: string;

  @doc("The test priority")
  testPriority?: int32;

  @doc("The test status")
  status?: string;

  @doc("Test details")
  message?: string;

  @doc("Log URL")
  logUrl?: string;

  @doc("Image name source string")
  image?: string;

  @doc("VM Size used")
  vmSize?: string;

  @doc("Region test ran")
  location?: string;

  @doc("Kernel version used")
  kernelVersion?: string;

  @doc("Distro version used")
  distroVersion?: string;

  @doc("VHD Generation")
  vhdGeneration?: int32;

  @doc("Wala Version")
  walaVersion?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "extraFields requires a Record<string> for backward compatibility"
  @doc("Extra fields")
  extraFields?: Record<string>;

  @doc("Test duration")
  duration?: string;

  @doc("Start time")
  startTime?: string;

  @doc("End time")
  endTime?: string;
}
