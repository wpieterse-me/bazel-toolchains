#!/bin/bash

echo "Wrapper - Start"
echo "$@"
exec "$@"
echo "Wrapper - End"
