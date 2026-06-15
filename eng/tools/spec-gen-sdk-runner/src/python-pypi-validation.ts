import { LogLevel, logMessage } from "./log.ts";
import { type ExecutionReportPackage } from "./types.ts";

export type PyPIPackageValidationStatus = "registered" | "notRegistered" | "checkFailed";

export interface PyPIPackageValidationResult {
  status: PyPIPackageValidationStatus;
  packageName: string;
  packageUrl: string;
  reason?: string;
}

type Fetch = typeof fetch;

const PYPI_PACKAGE_BASE_URL = "https://pypi.org/pypi";

function getPackageUrl(packageName: string): string {
  return `${PYPI_PACKAGE_BASE_URL}/${encodeURIComponent(packageName)}/json`;
}

export async function checkPackageOnPyPI(
  packageName: string,
  fetchImpl: Fetch = fetch,
): Promise<PyPIPackageValidationResult> {
  const packageUrl = getPackageUrl(packageName);

  try {
    const response = await fetchImpl(packageUrl);
    if (response.status === 200) {
      return { status: "registered", packageName, packageUrl };
    }
    if (response.status === 404) {
      return { status: "notRegistered", packageName, packageUrl };
    }

    return {
      status: "checkFailed",
      packageName,
      packageUrl,
      reason: `PyPI returned HTTP ${response.status}`,
    };
  } catch (error) {
    return {
      status: "checkFailed",
      packageName,
      packageUrl,
      reason: error instanceof Error ? error.message : String(error),
    };
  }
}

export async function validatePythonPackagesOnPyPI(
  packages: ExecutionReportPackage[],
): Promise<boolean> {
  if (packages.length === 0) {
    return true;
  }

  let allPackagesRegistered = true;
  for (const pkg of packages) {
    if (!pkg.packageName) {
      continue;
    }

    logMessage(
      `Checking whether Python package '${pkg.packageName}' is registered on PyPI.org...`,
      LogLevel.Info,
    );
    const result = await checkPackageOnPyPI(pkg.packageName);

    if (result.status === "registered") {
      logMessage(
        `Python package '${pkg.packageName}' is already registered on PyPI.org.`,
        LogLevel.Info,
      );
      continue;
    }

    allPackagesRegistered = false;
    if (result.status === "notRegistered") {
      logMessage(
        `Python package '${pkg.packageName}' is not registered on PyPI.org yet. To reserve this package name, complete these actions: 1. Request namespace review at aka.ms/azsdk/ns-review. 2. After namespace approval, trigger the package-name reservation pipeline: https://dev.azure.com/azure-sdk/internal/_build?definitionId=8013.`,
        LogLevel.Error,
      );
    } else {
      logMessage(
        `Unable to verify whether Python package '${pkg.packageName}' is registered on PyPI.org. Treating this as a validation failure. Details: ${result.reason ?? "Unknown error"}`,
        LogLevel.Error,
      );
    }
  }

  return allPackagesRegistered;
}
