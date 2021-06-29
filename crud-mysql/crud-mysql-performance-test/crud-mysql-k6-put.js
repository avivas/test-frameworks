import http from 'k6/http';
import { jUnit, textSummary } from 'https://jslib.k6.io/k6-summary/0.0.1/index.js';

export let options = { vus: 100, duration: '60s' };//200, 60

var id = 0;
const headers = { headers:  { 'Content-Type': 'application/json' } };
const data = JSON.stringify({name:"name-put",description:"descriptionp-put"});

export default function () {
  id++;
  http.put(`http://localhost:8080/${id}`,data,headers);
}

export function handleSummary(data) {
  console.log(`Preparing the end-of-test summary... ${__ENV.APP_NAME}`);
  const appName = __ENV.APP_NAME;
  data.appName = appName;
  const contentToExport =   '"' + appName
                          + '","PUT"'
                          + ','  + data.metrics.iterations.values.count
                          + ','  + data.metrics.iterations.values.rate
                          + ','  + data.metrics.http_req_failed.values.passes
                          ;
  const summaryFileName = `summary-put-${appName}.csv`;      
  var result = { 'stdout': textSummary(data, { indent: ' ', enableColors: true}) };
  result[summaryFileName] = contentToExport;
  return result;
}