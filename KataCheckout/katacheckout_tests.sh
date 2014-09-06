#! /bin/bash
erlc *.erl && echo 'eunit:test(katacheckout).' | erl
