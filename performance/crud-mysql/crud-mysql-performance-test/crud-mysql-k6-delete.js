import http from 'k6/http';
import { jUnit, textSummary } from 'https://jslib.k6.io/k6-summary/0.0.1/index.js';

export let options = { vus: 100, duration: '60s'};

var id = 0;
export default function () {
  id++;
  http.del(`http://localhost:8080/${id}`);
}

export function handleSummary(data) {
  console.log(`Preparing the end-of-test summary... ${__ENV.APP_NAME}`);
  const appName = __ENV.APP_NAME;
  data.appName = appName;
  const contentToExport =   '"' + appName
                          + '","DELETE"'
                          + ',' + data.metrics.iterations.values.count
                          + ',' + data.metrics.iterations.values.rate
                          + ',' + data.metrics.http_req_failed.values.passes
                          ;
  const summaryFileName = `summary-delete-${appName}.csv`;      
  var result = { 'stdout': textSummary(data, { indent: ' ', enableColors: true}) };
  result[summaryFileName] = contentToExport;
  return result;
}