#!/bin/sh
# A script to test the cmake dependency make generation framework using this simple test case

set -e
mkdir -p build
cd build
cmake ..
source_path=../

missing_expected_content=
contains_unexpected_content=
# Parameter 1: The file to check for content
# Parameter 2: The content to look for in the file
# Append missing_expected_content with the content missing from the file
expect_file_contains()
{
	local file=$1
	local content=$2
	grep $content $file > /dev/null
	if [ $? -ne 0 ]; then
		echo "expected file to contain ${content} but did not find in the file"
		missing_expected_content="$missing_expected_content:$content"
	fi
}
# Parameter 1: The file to check for content
# Parameter 2: The content to look for in the file
# Append contains_unexpected_content with the content missing from the file
expect_file_does_not_contain()
{
	local file=$1
	local content=$2
	grep $content $file > /dev/null
	if [ $? -eq 0 ]; then
		echo "ERROR!!! expected file should not contain ${content} but found in the file"
		contains_unexpected_content="$contains_unexpected_content:$content"
	fi
}

cd `dirname $0`
make_output_file=`mktemp`

# Get the make up to date with latest source
set -e
make clean > /dev/null
make > /dev/null
set +e

touch ${source_path}file1.h
make > $make_output_file 2>&1
echo make output after touching file1.h was:
cat $make_output_file

expect_file_contains $make_output_file 'file1.c'
expect_file_contains $make_output_file 'main.c'
expect_file_does_not_contain $make_output_file 'file2.c'

touch ${source_path}file2.h
make > $make_output_file 2>&1
echo make output after touching file2.h was:
cat $make_output_file

expect_file_contains $make_output_file 'file2.c'
expect_file_contains $make_output_file 'main.c'
expect_file_does_not_contain $make_output_file 'file1.c'


touch ${source_path}main.c
make > $make_output_file 2>&1
echo make output after touching main.c was:
cat $make_output_file

expect_file_contains $make_output_file 'main.c'
expect_file_does_not_contain $make_output_file 'file2.c'
expect_file_does_not_contain $make_output_file 'file1.c'

rm $make_output_file

if [ -n "$missing_expected_content" ] || [ -n "$contains_unexpected_content" ]; then
	echo "At least one test failed"
	exit 1
fi

./cmake-example-tests
exit $?
