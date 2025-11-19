import { annotateFileError, setSummary } from "@azure-tools/specs-shared/error-reporting";

export interface ReportableOavError {
  message: string;
  file: string;
  errorCode?: string;
  line?: number;
  column?: number;
}

export function outputAnnotatedErrors(errors: ReportableOavError[]) {
  errors.forEach((error) => {
    let msg: string = `${error.message}`;

    if (error.errorCode) {
      msg = `${error.errorCode}: ${msg}`;
    }

    // we only attempt an in-place annotation if we have the line and column associated with the error
    // otherwise we just depend upon the summary report to show the error
    if (error.line && error.column) {
      annotateFileError(error.file, msg, error.line, error.column);
    }
  });
}

export function outputSuccessSummary(swaggerFiles: string[], reportName: string) {
  let builtLines: string[] = [];

  builtLines.push(`## All specifications passed ${reportName}`);
  builtLines.push("| File | Status |");
  builtLines.push("| --- | --- |");
  for (const swaggerFile of swaggerFiles) {
    builtLines.push(`| ${swaggerFile} | ✅ |`);
  }

  const summaryResult = builtLines.join("\n");

  if (process.env.GITHUB_STEP_SUMMARY) {
    setSummary(summaryResult);
  } else {
    console.log(summaryResult);
  }
}

export function outputErrorSummary(errors: ReportableOavError[], reportName: string) {
  let builtLines: string[] = [];
  let checkName: string = "";

  builtLines.push(`## Error Summary - ${reportName}`);

  // just mapping the report names we want to migrate to the old names here, so we don't have to pull it through everywhere when we want to change it
  if (reportName === "Swagger SemanticValidation") {
    checkName = "validate-spec";
  } else if (reportName === "Swagger ModelValidation") {
    checkName = "validate-example";
  }

  builtLines.push("| File | Line#Column | Code | Message |");
  builtLines.push("| --- | --- | --- | --- |");

  // sort the errors by file name then by error code
  errors.sort((a, b) => {
    const nameCompare = (a.file || "").localeCompare(b.file || "");
    if (nameCompare !== 0) {
      return nameCompare;
    }
    return (a.errorCode || "").localeCompare(b.errorCode || "");
  });

  errors.forEach((error) => {
    const fmtLineCol = error.line && error.column ? `${error.line}#${error.column}` : "N/A";
    builtLines.push(`| ${error.file} | ${fmtLineCol} | ${error.errorCode} | ${error.message} |`);
  });

  builtLines.push("\n");
  builtLines.push(
    `> [!IMPORTANT]\n> Repro any individual file's worth of errors by invoking \`npx oav ${checkName} <spec-file-path>\` from the root of the rest-api-specs repo.`,
  );

  const summaryResult = builtLines.join("\n");

  if (process.env.GITHUB_STEP_SUMMARY) {
    setSummary(summaryResult);
  } else {
    console.log(summaryResult);
  }
}
