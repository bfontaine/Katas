var rc = require('./KataRomanCalculator').RomanCalculator,
    assert = require('assert'),

    tests = [// [a,     b,    expected a+b]
               
                ['I',   'I',  'II'],
                ['I',   'II', 'III'],
                ['V',   'I',  'VI'],
                ['I',   'V',  'VI'],
                ['X',   'X',  'XX'],
                ['M',   'C',  'MC'],
                ['XX',  'II', 'XXII'],

                ['V',   'V',  'X'],
                ['L',   'L',  'C'],
                ['D',   'D',  'M'],

                ['II',  'II', 'IV'],
                ['XX',  'XX', 'XL'],
                ['CC',  'CC', 'CD'],

                ['XIV', 'LX', 'LXXIV']
            ],
    i, len = tests.length, val, expr,
    fails = 0;

console.log('Running '+len+' tests…');
for (i=0; i<len; i++) {
    val = rc.calc(tests[i][0], tests[i][1]);
    expr = tests[i][0]+'+'+tests[i][1]+'='+val+', expected: '+tests[i][2]+'.';
    try {
        assert.equal(val, tests[i][2]);
    } catch (AssertionError) {
        console.log(expr);
        fails++;
    }
}
console.log(len+' tests done.\n'
            +((len-fails)/len*100)+'% OK\n'
            +(fails/len*100)+'% failed');
