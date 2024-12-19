const {
    Worker, isMainThread, parentPort
} = require('worker_threads');

if (isMainThread) {
    const worker = new Worker(__filename); // 워커 스레드 생성
    worker.on('message', message => console.log('from worker:', message)); // 워커의 메시지 수신
    worker.on('exit', () => console.log('worker exit')); // 워커 종료 처리
    worker.postMessage('ping'); // 워커로 메시지 전송
} else {
    parentPort.on('message', (value) => {
        console.log('from parent:', value); // 메인 스레드의 메시지 수신
        parentPort.postMessage('pong'); // 메인 스레드로 응답 메시지 전송
        parentPort.close(); // 통신 종료
    });
}







const {
    Worker, isMainThread, parentPort, workerData,
} = require('worker_threads');

if (isMainThread) { // 메인 스레드
    const threads = new Set(); // 워커 스레드 저장용 세트

    threads.add(new Worker(__filename, { workerData: { start: 1 } }));
    threads.add(new Worker(__filename, { workerData: { start: 2 } }));

    for (let worker of threads) {
        worker.on('message', message => console.log('from worker:', message)); // 워커 메시지 수신
        worker.on('exit', () => {
            threads.delete(worker); // 워커 종료 시 세트에서 제거
            if (threads.size === 0) {
                console.log('job done'); // 모든 워커 종료 시 출력
            }
        });
    }
} else { // 워커 스레드
    const data = workerData;
    parentPort.postMessage(data.start + 100); // 결과를 메인 스레드로 전송
}






const {
    Worker, isMainThread, parentPort, workerData
} = require('worker_threads');

const min = 2;
const primes = [];

function findPrimes(start, end){
    let isPrime = true;
    for(let i = start; i <= end; i ++){
        for(let j = min; j <= Math.sqrt(end); j++){
            if(i !== j && i % j === 0){
                isPrime = false;
                break;
            }
        }
        if(isPrime){
            primes.push(i);
        }
        isPrime = true;
    }
}

if(isMainThread){
    const max = 10000000;
    const threadCount = 8;
    const threads = new Set();
    const range = Math.floor((max-min)/threadCount);
    let start = min;
    console.time('prime');
    for(let i = 0; i < threadCount -1; i++){
        const end = start + range - 1;
        threads.add(new Worker(__filename, {workerData: {start, range: end}}));
        start += range;
    }
    threads.add(new Worker(__filename, {workerData: {start, range: max}}));
    for(let worker of threads){
        worker.on('error',(err) => {
            throw err;
        });
        worker.on('exit',() => {
            threads.delete(worker);
            if (threads.size === 0) {
                console.timeEnd('prime');
                console.log(primes.length);
            }
        });
        worker.on('message',(msg) => {
            primes = primes.concat(msg);
        });
    }
}else{
    findPrimes(workerData.start, workerData.range);
    parentPort.postMessage(primes);
}























