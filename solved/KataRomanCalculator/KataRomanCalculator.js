(function(exports){
    var RomanCalculator = {},
        numbers = ['M','D','C','L','X','I'];

    // extend a number representation, e.g.:
    // IX -> VIIII, XC -> LXXXX, etc.
    function extend(nb) {
        return nb
                .replace(/CM/g, 'DCCCC')
                .replace(/CD/g, 'CCCC')
                .replace(/XC/g, 'LXXXX')
                .replace(/XL/g, 'XXXX')
                .replace(/IX/g, 'VIIII')
                .replace(/IV/g, 'IIII');
    }

    // compress a number representation, e.g.:
    // VIIII -> IX, LXXXX -> XC, etc.
    function compress(nb) {
        return nb
                .replace(/VV/g, 'X')
                .replace(/LL/g, 'C')
                .replace(/DD/g, 'M')
                .replace(/DCCCC/g, 'CM')
                .replace(/CCCC/g,  'CD')
                .replace(/LXXXX/g, 'XC')
                .replace(/XXXX/g,  'XL')
                .replace(/VIIII/g, 'IX')
                .replace(/IIII/g,  'IV');
    }
    
    RomanCalculator.calc = function(n1, n2) {

        n1 = extend(n1);
        n2 = extend(n2);
    
        var t = [], sum = n1 + n2;

        // to Array
        Array.prototype.forEach.call(sum, function(e) {
            t.push(e);
        });

        t.sort(function(e1,e2){
            return numbers.indexOf(e1) > numbers.indexOf(e2);
        });

        return compress(t.join(''));
    };
    
    exports.RomanCalculator = RomanCalculator;
})(this);
