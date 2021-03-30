import http from 'k6/http';
import { jUnit, textSummary } from 'https://jslib.k6.io/k6-summary/0.0.1/index.js';

export let options = { vus: 200, duration: '60s' };

var id = 0;
const headers = { headers:  { 'Content-Type': 'application/json' } };
const data = JSON.stringify({name:"name-put",description:"descriptionp-put"});

export default function () {
  id++;
  http.put(`http://localhost:8080/${id}`,data,headers);
}

export function handleSummary(data) {
  console.log('Preparing the end-of-test summary...');
  return {
      'stdout' : textSummary(data, { indent: ' ', enableColors: true}),
      'summary-put.json': JSON.stringify(data.metrics.iterations),
  }
}