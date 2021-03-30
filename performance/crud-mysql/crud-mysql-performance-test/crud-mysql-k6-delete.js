import http from 'k6/http';
import { jUnit, textSummary } from 'https://jslib.k6.io/k6-summary/0.0.1/index.js';

export let options = { vus: 200, duration: '60s'};

var id = 0;
export default function () {
  id++;
  http.del(`http://localhost:8080/${id}`);
}

export function handleSummary(data) {
  console.log('Preparing the end-of-test summary...');
  return {
      'stdout': textSummary(data, { indent: ' ', enableColors: true}),
      'summary-delete.json': JSON.stringify(data.metrics.iterations),
  }
}