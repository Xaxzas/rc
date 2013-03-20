#!/bin/bash

if [[ "$http_proxy" == '' ]] ; then
    source proxyon
else
    source proxyoff
fi