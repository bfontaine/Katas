var rc = require('./KataRomanCalculator').RomanCalculator,
    assert = require('assert'),

    tests = [
                ['XIV', 'LX', 'LXXIV'],
                ['XX', 'II', 'XXII'],
                ['II', 'II', 'IV'],
                ['D', 'D', 'M']
            ],
    i, len = tests.length, val;

for (i=0; i<len; i++) {
    val = rc.calc(tests[i][0], tests[i][1]);
    assert.equal(
            val,
            tests[i][2],
            tests[i][0]+'+'+tests[i][1]+'='+val+', expected '+tests[i][2]+'.'
            );
}
