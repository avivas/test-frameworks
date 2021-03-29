import http from 'k6/http';
import { jUnit, textSummary } from 'https://jslib.k6.io/k6-summary/0.0.1/index.js';

export let options = {
  vus: 100,
  duration: '60s',
};

const headers = { headers:  { 'Content-Type': 'application/json' } };
const data = JSON.stringify({name:'name',description:'description'});

export default function () {
  http.post('http://localhost:8080/',data,headers);
}

export function handleSummary(data) {
  console.log('Preparing the end-of-test summary...');
  return {
      'stdout': textSummary(data, { indent: ' ', enableColors: true}),
      'summary-post.json': JSON.stringify(data),
  }
}