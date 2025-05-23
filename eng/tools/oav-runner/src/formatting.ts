// todo: come up with a better type for this
export function outputAnnotatedErrors(errors: Array<object>){
  // echo "::error file=src/app.js,line=42,col=13::Something went wrong here"
    console.log(errors);
}

export function outputSummaryReport(targetDirectory: string, errors: Array<object>){
  /*
    echo "## 🔥 Error Summary" >> $GITHUB_STEP_SUMMARY
    echo "| File | Line | Message |"         >> $GITHUB_STEP_SUMMARY
    echo "| ---- | ---- | ------- |"         >> $GITHUB_STEP_SUMMARY
    echo "| src/app.js | 42 | Something went wrong |" \
      >> $GITHUB_STEP_SUMMARY
  */
    console.log(`outputting ${errors} to summary report to ${targetDirectory}`);
}