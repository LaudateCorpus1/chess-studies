#!/bin/sh
#
# skiminki's computer chess studies
# Copyright (C) 2019 Sami Kiminki
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

function usage ()
{
    echo "Usage: $1 [-noloop] [latex-options] <texfile>"
    exit 1
}

function run_pdflatex ()
{
    echo "pdflatex -output-directory=\"${OUTDIR}\" $@"
    pdflatex -output-directory="${OUTDIR}" "$@"
    EXIT="$?"
    if [ "$EXIT" -ne 0 ]
    then
	tail -n 100 "$LOGFILE"
	exit "$EXIT"
    fi
}

function compute_md5 ()
{
    if [ -f "$AUXFILE" ]
    then
	echo -n "$(eval md5sum "${AUXFILE}" | cut -d ' ' -f 1)"
    else
	echo -n "(file not found)"
    fi
}

DOLOOP="1"
if [ "$1" = "-noloop" ]
then
    DOLOOP=""
    shift
fi

if [ $# -lt 1 ]
then
    usage
fi

# take the last parameter as the texfile
eval TEXFILE="\$$#"

if [ \! -f "$TEXFILE" ]
then
    echo "'$TEXFILE' is not a regular file"
    exit 1
fi

# determine file names
OUTDIR=".tmp"
AUXFILE="${OUTDIR}/${TEXFILE%.tex}.aux"
PDFFILE="${TEXFILE%.tex}.pdf"
TMP_PDFFILE="${OUTDIR}/${PDFFILE}"
LOGFILE="${OUTDIR}/${TEXFILE%.tex}.log"

# compute initial md5 sum for incremental builds
AUXMD5="$(eval compute_md5 "${AUXFILE}")"
echo "MD5SUM ${AUXFILE}: ${AUXMD5}"

while true
do
    run_pdflatex "$@"
    if [ "${DOLOOP}" = "" ]
    then
	break
    fi

    NEWAUXMD5="$(eval compute_md5 "${AUXFILE}")"

    if [ "${NEWAUXMD5}" = "${AUXMD5}" ]
    then
	echo "MD5SUM ${AUXFILE}: ${NEWAUXMD5} stabilized"
	break
    fi
    echo "MD5SUM ${AUXFILE}: ${NEWAUXMD5} != ${AUXMD5}"
    AUXMD5="${NEWAUXMD5}"
done

mv -v "${TMP_PDFFILE}" "${PDFFILE}"
