
import { annotateFileError, setSummary } from "@azure-tools/specs-shared/error-reporting";

export interface ReportableOavError {
  message: string;
  file: string;
  classificationCode?: string;
  line?: number;  // we don't always have a line or column if the spec is invalid
  column?: number;
}

export function outputAnnotatedErrors(errors: ReportableOavError[]){
    errors.forEach((error) => {
        if (!error.classificationCode) {
            annotateFileError(error.message, error.file, error.line ?? 0, error.column ?? 0);
        }
        else {
            annotateFileError(`${error.classificationCode}: ${error.message}`, error.file, error.line ?? 0, error.column ?? 0);
        }
    });
}

export function outputSummaryReport(errors: ReportableOavError[], reportName: string = "Swagger SemanticValidation") {
    let builtLines: string[] = [];

    builtLines.push("## 🔥 Error Summary");
    builtLines.push("⚠️ This check is testing a new version of 'Swagger SemanticValidation'.")
    builtLines.push("⚠️ Failures are expected, and should be completely ignored by spec authors and reviewers.")
    builtLines.push(`⚠️ Meaningful results for this PR are in required check '${reportName}'.`)
    // we should sort the errors by file and error code
    builtLines.push("| File | Line#Column | Code | Message |");
    builtLines.push("| --- | --- | --- | --- |");

    // todo: sort the errors by file and error code before we print them
    errors.forEach((error) => {
        builtLines.push(`| ${error.file} | ${error.line}#${error.column} | ${error.classificationCode} | ${error.message} |`);
    });

    const summaryResult = builtLines.join('\n');
    setSummary(summaryResult);
}

